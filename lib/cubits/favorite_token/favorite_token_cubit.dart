import 'dart:async';

import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/cubits/user/user_cubit.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/data/services/api/favorite_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoriteTokenCubit extends Cubit<FavoriteTokenState> {
  StreamSubscription? _userSubscription;

  FavoriteTokenCubit() : super(const FavoriteTokenState()) {
    init();
  }

  void init() {
    final userCubit = getIt<UserCubit>();

    // Check if user is already logged in
    if (userCubit.state.isLoggedIn) {
      getFavoriteTokens();
    }

    // Listen to user login status changes
    _userSubscription = userCubit.stream.listen((userState) {
      if (userState.isLoggedIn) {
        getFavoriteTokens();
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> addToken(Token token) async {
    emit(
        state.copyWith(actionStatus: const FavoriteTokenActionStatus.adding()));

    final network = token.network?.trim() == ''
        ? token.chainName.toLowerCase()
        : token.network ?? '';
    try {
      await getIt<FavoriteApi>().addFavoriteToken(
        network: network,
        address: token.address,
      );

      final favoriteToken = FavoriteToken.fromCommonToken(token);

      // Insert new token at the beginning, but after top tokens
      final updatedTokens = [...state.tokens];

      // Find the index after the last top token
      int insertIndex = 0;
      for (int i = 0; i < updatedTokens.length; i++) {
        if (updatedTokens[i].isTop ?? false) {
          insertIndex = i + 1;
        } else {
          break;
        }
      }

      // Insert the new token after top tokens
      updatedTokens.insert(insertIndex, favoriteToken);

      emit(state.copyWith(
          tokens: updatedTokens,
          actionStatus: const FavoriteTokenActionStatus.success()));
    } catch (e, s) {
      emit(state.copyWith(
          actionStatus: FavoriteTokenActionStatus.error(e.toString())));

      await SentryService().reportError(e, s,
          tags: {"feature": "addToken"},
          extra: {"network": network, "address": token.address});
    }
  }

  Future<void> removeToken(Token token) async {
    emit(state.copyWith(
        actionStatus: const FavoriteTokenActionStatus.removing()));

    try {
      await getIt<FavoriteApi>().deleteFavoriteToken(
          network: token.network ?? token.chainName.toLowerCase(),
          address: token.address);

      emit(state.copyWith(
          tokens: state.tokens
              .where((element) => !(element.contractAddress == token.address &&
                  element.network == token.network))
              .toList(),
          actionStatus: const FavoriteTokenActionStatus.success()));
    } catch (e, s) {
      emit(state.copyWith(
          actionStatus: FavoriteTokenActionStatus.error(e.toString())));

      await SentryService().reportError(e, s, tags: {
        "feature": "removeToken"
      }, extra: {
        "network": token.network ?? token.chainName.toLowerCase(),
        "address": token.address
      });
    }
  }

  Future<void> pinToken(Token token) async {
    emit(state.copyWith(
        actionStatus: const FavoriteTokenActionStatus.pinning()));

    try {
      await getIt<FavoriteApi>().pinFavoriteToken(
        network: token.network ?? '',
        address: token.address,
      );

      Logger.info("pinToken: $token");

      // Find and remove the token from the list
      final updatedTokens = <FavoriteToken>[];
      FavoriteToken? pinnedToken;

      for (final element in state.tokens) {
        if (element.contractAddress == token.address &&
            element.network == token.network) {
          pinnedToken = element.copyWith(isTop: true);
        } else {
          updatedTokens.add(element);
        }
      }

      // Insert the pinned token at the beginning (index 0)
      if (pinnedToken != null) {
        updatedTokens.insert(0, pinnedToken);
      }

      emit(state.copyWith(
          tokens: updatedTokens,
          actionStatus: const FavoriteTokenActionStatus.success()));
    } catch (e) {
      emit(state.copyWith(
          actionStatus: FavoriteTokenActionStatus.error(e.toString())));
    }
  }

  void _sortTokensByTop(List<FavoriteToken> tokens) {
    tokens.sort((a, b) {
      // Top tokens come first
      if ((a.isTop ?? false) && !(b.isTop ?? false)) return -1;
      if (!(a.isTop ?? false) && (b.isTop ?? false)) return 1;
      return 0; // Keep original order for tokens with same top status
    });
  }

  Future<void> handleFavoriteToken(Token token) async {
    final newNetwork = token.network?.trim() == ''
        ? token.chainName.toLowerCase() == 'ethereum'
            ? 'eth'
            : token.chainName.toLowerCase()
        : token.network;

    final isFavorite = state.tokens.any((element) =>
        element.contractAddress == token.address &&
        element.network == newNetwork);

    if (isFavorite) {
      await removeToken(token);
    } else {
      await addToken(token);
    }
  }

  bool isFavoriteToken(Token token) {
    return state.tokens.any((element) =>
        element.contractAddress == token.address &&
        element.network == token.network);
  }

  Future<void> getFavoriteTokens() async {
    emit(const FavoriteTokenState(
        listStatus: FavoriteTokenListStatus.loading()));
    final wallet = await getIt<WalletStorage>().getSelectedWallet();

    try {
      final tokens = await getIt<FavoriteApi>()
          .getUserFavoriteToken(walletId: wallet?.id ?? '');

      // Sort tokens with top tokens first
      // _sortTokensByTop(tokens);

      emit(state.copyWith(
          tokens: tokens, listStatus: FavoriteTokenListStatus.success(tokens)));
    } catch (e, s) {
      emit(const FavoriteTokenState(
          listStatus: FavoriteTokenListStatus.error('')));

      await SentryService().reportError(e, s,
          tags: {"feature": "getFavoriteTokens"},
          extra: {"walletId": wallet?.id});
    }
  }
}
