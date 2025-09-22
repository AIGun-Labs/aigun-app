import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/data/services/api/favorite_api.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteTokenCubit extends Cubit<FavoriteTokenState> {
  FavoriteTokenCubit() : super(const FavoriteTokenState()) {
    init();
  }

  void init() {
    getFavoriteTokens();
  }

  void addToken(Token token) {
    addFavoriteToken(token);
    emit(state.copyWith(tokens: [...state.tokens, token]));
  }

  void removeToken(Token token) {
    try {
      unFavoriteToken(chainName: token.chainName, address: token.address);
      emit(state.copyWith(
          tokens: state.tokens
              .where((element) => !(element.address == token.address &&
                  element.tokenName == token.tokenName &&
                  element.chainId == token.chainId &&
                  element.symbol == token.symbol &&
                  element.tokenAvatar == token.tokenAvatar))
              .toList()));
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }

  void handleFavoriteToken(Token token) {
    final isFavorite = state.tokens.any((element) =>
        element.address == token.address &&
        element.symbol == token.symbol &&
        element.tokenName == token.tokenName &&
        element.chainId == token.chainId &&
        element.tokenAvatar == token.tokenAvatar);

    if (isFavorite) {
      removeToken(token);
    } else {
      addToken(token);
    }
  }

  bool isFavoriteToken(Token token) {
    return state.tokens.any((element) =>
        element.address == token.address &&
        element.symbol == token.symbol &&
        element.tokenName == token.tokenName &&
        element.chainId == token.chainId &&
        element.tokenAvatar == token.tokenAvatar);
  }

  Future<void> getFavoriteTokens() async {
    emit(const FavoriteTokenState(status: FavoriteTokenStatus.loading()));

    try {
      final tokens = await getIt<FavoriteApi>().getUserFavoriteToken();

      emit(state.copyWith(
          tokens: tokens, status: FavoriteTokenStatus.success(tokens)));
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }

  Future<void> addFavoriteToken(Token token) async {
    try {
      await getIt<FavoriteApi>().addFavoriteToken(token);
      addToken(token);
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }

  Future<void> unFavoriteToken(
      {required String chainName, required String address}) async {
    emit(state.copyWith(status: const FavoriteTokenStatus.loading()));

    try {
      await getIt<FavoriteApi>().unFavoriteToken(
        chainName: chainName,
        address: address,
      );
      // 找到对应的token并从本地状态移除
      final tokenToRemove = state.tokens.firstWhere(
        (element) =>
            element.chainName == chainName && element.address == address,
        orElse: () => throw Exception('Token not found'),
      );
      removeToken(tokenToRemove);
    } catch (e) {
      emit(state.copyWith(status: FavoriteTokenStatus.error(e.toString())));
    }
  }
}
