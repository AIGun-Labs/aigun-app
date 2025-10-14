import 'dart:async';

import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/latest_token/latest_token_state.dart';
import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestTokenCubit extends Cubit<LatestTokenState> {
  final TrendingApi _trendingApi;
  final FavoriteTokenCubit _favoriteTokenCubit;

  LatestTokenCubit(this._trendingApi, this._favoriteTokenCubit)
      : super(const LatestTokenState()) {
    init();
  }

  void init() {
    loadLatestTokens();
  }

  Future<void> loadLatestTokens({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.copyWith(
        status: const LatestTokenStatus.loading(),
        tokens: [],
        lastQueryTime: null,
      ));
    } else if (state.status == const LatestTokenStatus.loading()) {
      return;
    } else {
      emit(state.copyWith(status: const LatestTokenStatus.loading()));
    }

    try {
      final tokens = await _trendingApi.getLastestTokens(
        lastQueryTime: isRefresh ? null : state.lastQueryTime,
      );

      final newTokens = isRefresh ? tokens : [...state.tokens, ...tokens];
      final hasMore = tokens.isNotEmpty;

      emit(state.copyWith(
        tokens: newTokens,
        status: LatestTokenStatus.success(newTokens),
        hasMore: hasMore,
        lastQueryTime: tokens.isNotEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : state.lastQueryTime,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        status: LatestTokenStatus.error(e.toString()),
      ));

      await SentryService()
          .reportError(e, s, tags: {"feature": "loadLatestTokens"});
    }
  }

  Future<void> loadMoreTokens() async {
    if (state.status == const LatestTokenStatus.loadingMore() ||
        !state.hasMore) {
      return;
    }

    emit(state.copyWith(status: const LatestTokenStatus.loadingMore()));

    try {
      final tokens = await _trendingApi.getLastestTokens(
        lastQueryTime: state.lastQueryTime,
      );

      final newTokens = [...state.tokens, ...tokens];
      final hasMore = tokens.isNotEmpty;

      emit(state.copyWith(
        tokens: newTokens,
        status: LatestTokenStatus.success(newTokens),
        hasMore: hasMore,
        lastQueryTime: tokens.isNotEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : state.lastQueryTime,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        status: LatestTokenStatus.error(e.toString()),
      ));

      await SentryService()
          .reportError(e, s, tags: {"feature": "loadMoreTokens"});
    }
  }

  Token latestTokenToToken(LatestToken latestToken) {
    return Token.fromLastestToken(latestToken);
  }

  Future<void> toggleFavorite(LatestToken latestToken) async {
    final token = latestTokenToToken(latestToken);
    await _favoriteTokenCubit.handleFavoriteToken(token);
  }

  bool isFavorite(LatestToken latestToken) {
    final token = latestTokenToToken(latestToken);
    return _favoriteTokenCubit.isFavoriteToken(token);
  }

  Future<void> refreshTokens() async {
    await loadLatestTokens(isRefresh: true);
  }
}
