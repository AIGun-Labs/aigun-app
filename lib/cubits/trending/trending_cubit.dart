import 'dart:async';

import 'package:flutter_aigun/cubits/trending/trending_state.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final TrendingApi trendingApi;
  Timer? _timer;

  TrendingCubit(this.trendingApi) : super(const TrendingState()) {
    // 初始化时立即触发一次 getLastestTokens
    getLastestTokens();

    // 每隔 25 秒触发一次 getLastestTokens
    _timer = Timer.periodic(const Duration(seconds: 25), (timer) {
      getLastestTokens();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> getLastestTokens() async {
    emit(state.copyWith(status: const GetLastestTokensStatus.loading()));

    try {
      final lastestTokens = await trendingApi.getLastestTokens();

      final newLastestTokens = lastestTokens.take(7).toList();

      emit(state.copyWith(
          status: GetLastestTokensStatus.success(newLastestTokens),
          lastestTokens: newLastestTokens));
    } catch (e, s) {
      emit(state.copyWith(
          status: const GetLastestTokensStatus.failure(
              GetLastestTokensFailure.getLastestTokens)));

      await SentryService().reportError(e, s);
    }
  }
}
