import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../utils/storage/local/wallet_storage.dart';
import '../../domain/entities/collect_token_entity.dart';
import '../../domain/usecases/fetch_add_collect.dart';
import '../../domain/usecases/fetch_collect_tokens.dart';
import '../../domain/usecases/fetch_delete_collect.dart';
import '../../domain/usecases/fetch_pin_collect.dart';

part 'collect_cubit.freezed.dart';
part 'collect_state.dart';

class CollectCubit extends Cubit<CollectState> {
  late final FetchCollectTokens _fetchCollectTokens;
  late final FetchAddCollect _fetchAddCollect;
  late final FetchDeleteCollect _fetchDeleteCollect;
  late final FetchPinCollect _fetchPinCollect;
  late final WalletStorage _walletStorage;
  late final UserCubit _userCubit;

  StreamSubscription? _userSubscription;

  CollectCubit(this._fetchCollectTokens, this._fetchAddCollect,
      this._fetchDeleteCollect, this._fetchPinCollect, this._walletStorage)
      : super(const CollectState()) {
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
      emit(const CollectState(
          status: CollectStatus.error, errorMessage: 'No wallet selected'));
      return;
    }

    if (wallet.id == null || wallet.id!.isEmpty) {
      emit(const CollectState(
          status: CollectStatus.error, errorMessage: 'Wallet id not found'));
      return;
    }

    if (state.tokens.isEmpty) {
      emit(state.copyWith(status: CollectStatus.loading));
    }

    final result = await _fetchCollectTokens.call(walletId: wallet.id!);

    if (isClosed) return;

    result.whenOrNull(success: (tokens) {
      emit(state.copyWith(status: CollectStatus.success, tokens: tokens));
    }, failure: (error) {
      emit(state.copyWith(
          status: CollectStatus.error, errorMessage: error.toString()));
    });
  }

  Future<void> addCollectToken({required CollectTokenEntity token}) async {
    final result = await _fetchAddCollect.call(
        network: token.network, address: token.address);

    if (result.isSuccess) {
      final updatedTokens = [...state.tokens];

      int insertIndex = 0;
      for (int i = 0; i < updatedTokens.length; i++) {
        if (updatedTokens[i].isTop) {
          insertIndex = i + 1;
        } else {
          break;
        }
      }

      updatedTokens.insert(insertIndex, token);

      emit(
          state.copyWith(status: CollectStatus.success, tokens: updatedTokens));
    } else {
      emit(state.copyWith(
          status: CollectStatus.error, errorMessage: result.errorMessage));
    }
  }

  Future<void> deleteCollectToken({required CollectTokenEntity token}) async {
    final result = await _fetchDeleteCollect.call(
        network: token.network, address: token.address);

    if (result.isSuccess) {
      emit(state.copyWith(
          status: CollectStatus.success,
          tokens: state.tokens
              .where((element) => !(element.address == token.address &&
                  element.network == token.network))
              .toList()));
    } else {
      emit(state.copyWith(
          status: CollectStatus.error, errorMessage: result.errorMessage));
    }
  }

  Future<void> pinCollectToken({required CollectTokenEntity token}) async {
    final result = await _fetchPinCollect.call(
        network: token.network, address: token.address);

    if (result.isSuccess) {
      final updatedTokens = <CollectTokenEntity>[];
      CollectTokenEntity? pinnedToken;

      for (final item in state.tokens) {
        if (item.address == token.address && item.network == token.network) {
          pinnedToken = item.copyWith(isTop: true);
        } else {
          updatedTokens.add(item);
        }
      }
      if (pinnedToken != null) {
        updatedTokens.insert(0, pinnedToken);
      }

      emit(
          state.copyWith(status: CollectStatus.success, tokens: updatedTokens));
    } else {
      emit(state.copyWith(
          status: CollectStatus.error, errorMessage: result.errorMessage));
    }
  }
}
