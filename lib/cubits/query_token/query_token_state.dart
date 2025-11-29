import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/token/query_token/query_token.dart';

part 'query_token_state.freezed.dart';

enum QueryTokenStatus { initial, loading, success, error }

@freezed
sealed class QueryTokenState with _$QueryTokenState {
  const factory QueryTokenState({
    @Default(QueryTokenStatus.initial) QueryTokenStatus status,
    @Default([]) List<QueryToken> tokens,
    @Default(null) String? keyword,
    @Default(null) QueryToken? queryToken,
    @Default(false) bool isLoading,
    @Default(false) bool noData,
    // @Default(false) bool noMoreData
  }) = _QueryTokenState;
}
