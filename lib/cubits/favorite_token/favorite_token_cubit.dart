import 'dart:async';

import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/data/services/api/favorite_api.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteTokenCubit extends Cubit<FavoriteTokenState> {
  late final StreamSubscription userSubscription;

  FavoriteTokenCubit() : super(const FavoriteTokenState()) {
    init();
  }

  void init() {
    getFavoriteTokens();
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  Future<void> addToken(Token token) async {
    try {
      await getIt<FavoriteApi>().addFavoriteToken(
        chainId: token.chainId.toString(),
        chainName: token.chainName,
        chainLogo: token.chainLogo,
        address: token.address,
        tokenName: token.tokenName,
        symbol: token.symbol,
        tokenAvatar: token.tokenAvatar,
        decimals: token.decimals.toString(),
      );

      final favoriteToken = FavoriteToken.fromCommonToken(token);

      emit(state.copyWith(
          tokens: [...state.tokens, favoriteToken],
          status:
              FavoriteTokenStatus.success([...state.tokens, favoriteToken])));
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }

  Future<void> removeToken(Token token) async {
    try {
      await getIt<FavoriteApi>().deleteFavoriteToken(
          chainName: token.chainName, address: token.address);

      emit(state.copyWith(
          tokens: state.tokens
              .where((element) => !(element.contractAddress == token.address &&
                  element.tokenName == token.tokenName &&
                  element.chainId?.toInt() == token.chainId &&
                  element.symbol == token.slug &&
                  element.tokenAvatar == token.tokenAvatar))
              .toList()));
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }

  Future<void> handleFavoriteToken(Token token) async {
    final isFavorite = state.tokens.any((element) =>
        element.contractAddress == token.address &&
        element.symbol == token.symbol &&
        element.tokenName == token.tokenName &&
        element.chainId?.toInt() == token.chainId &&
        element.tokenAvatar == token.tokenAvatar);

    if (isFavorite) {
      await removeToken(token);
    } else {
      await addToken(token);
    }
  }

  bool isFavoriteToken(Token token) {
    return state.tokens.any((element) =>
        element.contractAddress == token.address &&
        element.network == token.slug);
  }

  Future<void> getFavoriteTokens() async {
    emit(const FavoriteTokenState(status: FavoriteTokenStatus.loading()));

    try {
      final wallet = await getIt<WalletStorage>().getSelectedWallet();

      final tokens = await getIt<FavoriteApi>()
          .getUserFavoriteToken(walletId: wallet?.id ?? '');

      emit(state.copyWith(
          tokens: tokens, status: FavoriteTokenStatus.success(tokens)));
    } catch (e) {
      emit(const FavoriteTokenState(status: FavoriteTokenStatus.error('')));
    }
  }

  Future<void> addFavoriteToken(Token token) async {
    try {
      await getIt<FavoriteApi>().addFavoriteToken(
        chainId: token.chainId.toString(),
        chainName: token.chainName,
        chainLogo: token.chainLogo,
        address: token.address,
        tokenName: token.tokenName,
        symbol: token.symbol,
        tokenAvatar: token.tokenAvatar,
        decimals: token.decimals.toString(),
      );
      addToken(token);
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }
}
