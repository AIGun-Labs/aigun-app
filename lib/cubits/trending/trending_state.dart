import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_state.freezed.dart';

enum GetLastestTokensFailure {
  getLastestTokens,
}

@freezed
class GetLastestTokensStatus with _$GetLastestTokensStatus {
  const factory GetLastestTokensStatus.initial() = _GetLastestTokensInitial;
  const factory GetLastestTokensStatus.loading() = _GetLastestTokensLoading;
  const factory GetLastestTokensStatus.success(
      List<LastestToken> lastestTokens) = _GetLastestTokensSuccess;
  const factory GetLastestTokensStatus.failure(
      GetLastestTokensFailure failure) = _GetLastestTokensFailure;
}

@freezed
class TrendingState with _$TrendingState {
  const factory TrendingState({
    @Default(GetLastestTokensStatus.initial()) GetLastestTokensStatus status,
    @Default([]) List<LastestToken> lastestTokens,
  }) = _TrendingState;
}
