import 'package:flutter_aigun/data/models/token/query_token/query_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_token_state.freezed.dart';

@freezed
class QueryTokenStatus with _$QueryTokenStatus {
  const factory QueryTokenStatus.initial() = _QueryTokenInitial;
  const factory QueryTokenStatus.loading() = _QueryTokenLoading;
  const factory QueryTokenStatus.success(List<QueryToken> tokens) =
      _QueryTokenSuccess;
  const factory QueryTokenStatus.error(String message) = _QueryTokenError;
  const factory QueryTokenStatus.noData() = _QueryTokenNoData;
}

@freezed
class QueryTokenState with _$QueryTokenState {
  const factory QueryTokenState({
    @Default(QueryTokenStatus.initial()) QueryTokenStatus status,
    @Default([]) List<QueryToken> tokens,
    @Default(null) String? keyWord,
  }) = _QueryTokenState;
}
