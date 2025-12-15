import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../utils/storage/local/wallet_storage.dart';
import '../../../trending/domain/usecases/fetch_collected_tokens_usecase.dart';
import '../../domain/usecases/fetch_add_collect.dart';
import '../../domain/usecases/fetch_delete_collect.dart';
import '../../domain/usecases/fetch_pin_collect.dart';

part 'collect_cubit.freezed.dart';
part 'collect_state.dart';

class CollectCubit extends Cubit<CollectState> {
  late final FetchCollectedTokensUsecase _fetchCollectedTokens;
  late final FetchAddCollect _fetchAddCollect;
  late final FetchDeleteCollect _fetchDeleteCollect;
  late final FetchPinCollect _fetchPinCollect;
  late final WalletStorage _walletStorage;
  late final UserCubit _userCubit;

  StreamSubscription? _userSubscription;

  CollectCubit(
    this._fetchCollectedTokens,
    this._fetchAddCollect,
    this._fetchDeleteCollect,
    this._fetchPinCollect,
    this._walletStorage,
    this._userCubit,
  ) : super(const CollectState()) {
    _initListeners();
  }

  void _initListeners() {
    _userSubscription = _userCubit.stream.listen((state) {
      if (!state.isLoggedIn) {
        emit(const CollectState(status: CollectStatus.noData));
      } else {
        loadCollectTokens();
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> loadCollectTokens() async {
    final wallet = await _walletStorage.getSelectedWallet();

    if (wallet == null) {
      emit(
        const CollectState(
          status: CollectStatus.error,
          errorMessage: 'No wallet selected',
        ),
      );
      return;
    }

    if (wallet.id == null || wallet.id!.isEmpty) {
      emit(
        const CollectState(
          status: CollectStatus.error,
          errorMessage: 'Wallet id not found',
        ),
      );
      return;
    }

    if (state.tokens.isEmpty) {
      emit(state.copyWith(status: CollectStatus.loading));
    }

    final result = await _fetchCollectedTokens.call(walletId: wallet.id!);

    if (isClosed) return;

    result.whenOrNull(
      success: (tokens) {
        emit(state.copyWith(status: CollectStatus.success, tokens: tokens));
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: CollectStatus.error,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> handleCollect({required BaseTokenEntity token}) async {
    if (state.actionStatus == CollectActionStatus.adding ||
        state.actionStatus == CollectActionStatus.removing) {
      return;
    }

    final isCollected = state.isCollected(token);

    if (isCollected) {
      await _deleteCollectToken(network: token.network, address: token.address);
    } else {
      await _addCollectToken(token: token);
    }
  }

  Future<void> _addCollectToken({required BaseTokenEntity token}) async {
    emit(state.copyWith(actionStatus: CollectActionStatus.adding));
    final result = await _fetchAddCollect.call(
      network: token.network,
      address: token.address,
    );

    if (result.isSuccess) {
      final updatedTokens = [...state.tokens];

      int insertIndex = 0;
      for (int i = 0; i < updatedTokens.length; i++) {
        if (updatedTokens[i].isTop ?? false) {
          insertIndex = i + 1;
        } else {
          break;
        }
      }

      updatedTokens.insert(insertIndex, token);

      emit(
        state.copyWith(
          tokens: updatedTokens,
          actionStatus: CollectActionStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CollectStatus.error,
          actionStatus: CollectActionStatus.error,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  Future<void> _deleteCollectToken({
    required String network,
    required String address,
  }) async {
    emit(state.copyWith(actionStatus: CollectActionStatus.removing));

    final result = await _fetchDeleteCollect.call(
      network: network,
      address: address,
    );

    if (result.isSuccess) {
      emit(
        state.copyWith(
          actionStatus: CollectActionStatus.success,
          tokens: state.tokens
              .where(
                (element) =>
                    !(element.address == address && element.network == network),
              )
              .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CollectStatus.error,
          actionStatus: CollectActionStatus.error,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  Future<void> pinCollectToken({
    required String network,
    required String address,
  }) async {
    emit(state.copyWith(actionStatus: CollectActionStatus.pinning));
    final result = await _fetchPinCollect.call(
      network: network,
      address: address,
    );

    if (result.isSuccess) {
      final updatedTokens = <BaseTokenEntity>[];
      BaseTokenEntity? pinnedToken;

      for (final item in state.tokens) {
        if (item.address == address && item.network == network) {
          pinnedToken = item.copyWith(isTop: true);
        } else {
          updatedTokens.add(item);
        }
      }
      if (pinnedToken != null) {
        updatedTokens.insert(0, pinnedToken);
      }

      emit(
        state.copyWith(
          tokens: updatedTokens,
          actionStatus: CollectActionStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CollectStatus.error,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }
}
