import 'dart:async';

import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/data/services/api/favorite_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteTokenCubit extends Cubit<FavoriteTokenState> {
  FavoriteTokenCubit() : super(const FavoriteTokenState()) {
    init();
  }

  void init() {
    getFavoriteTokens();
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
      emit(state.copyWith(
          tokens: [...state.tokens, favoriteToken],
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

  // Future<void> addFavoriteToken(Token token) async {
  //   try {
  //     await getIt<FavoriteApi>().addFavoriteToken(
  //       chainId: token.chainId.toString(),
  //       chainName: token.chainName,
  //       chainLogo: token.chainLogo,
  //       address: token.address,
  //       tokenName: token.tokenName,
  //       symbol: token.symbol,
  //       tokenAvatar: token.tokenAvatar,
  //       decimals: token.decimals.toString(),
  //     );
  //     addToken(token);
  //   } catch (e) {
  //     emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
  //   }
  // }
}
