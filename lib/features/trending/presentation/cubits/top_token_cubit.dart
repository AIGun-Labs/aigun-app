import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/top_token_entity.dart';
import '../../domain/usecases/fetch_top_tokens.dart';

part 'top_token_cubit.freezed.dart';
part 'top_token_state.dart';

class TopTokenCubit extends Cubit<TopTokenState> {
  final FetchTopTokens _fetchTopTokens;

  TopTokenCubit(this._fetchTopTokens) : super(const TopTokenState());

  Future<void> refresh() async {
    emit(state.copyWith(
      status: TopTokenStatus.loading,
      hasMore: true,
      lastTime: null, // 刷新时重置游标
      errorMessage: null,
    ));

    final result = await _fetchTopTokens.call(null);

    _handleResult(result, isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (state.status == TopTokenStatus.loading || !state.hasMore) return;

    final result = await _fetchTopTokens(state.lastTime);

    _handleResult(result, isLoadMore: true);
  }

  void _handleResult(Result<List<TopTokenEntity>> result,
      {bool isLoadMore = false}) {
    result.whenOrNull(success: (newTokens) {
      if (newTokens.isEmpty) {
        emit(state.copyWith(
          hasMore: false,
          status: TopTokenStatus.success,
        ));

        return;
      }

      final nextLastTime = newTokens.last.displayTime.toString();

      emit(state.copyWith(
        status: TopTokenStatus.success,
        tokens: isLoadMore ? [...state.tokens, ...newTokens] : newTokens,
        hasMore: true,
        lastTime: nextLastTime,
      ));
    }, failure: (String message) {
      emit(state.copyWith(
        status: TopTokenStatus.failure,
        errorMessage: message,
      ));
    });
  }
}
