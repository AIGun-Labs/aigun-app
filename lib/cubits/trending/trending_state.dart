import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/trending/lastest_token/lastest_token.dart';

part 'trending_state.freezed.dart';

enum GetLastestTokensFailure {
  getLastestTokens,
}

@freezed
class GetLastestTokensStatus with _$GetLastestTokensStatus {
  const factory GetLastestTokensStatus.initial() = _GetLastestTokensInitial;
  const factory GetLastestTokensStatus.loading() = _GetLastestTokensLoading;
  const factory GetLastestTokensStatus.success(
      List<LatestToken> lastestTokens) = _GetLastestTokensSuccess;
  const factory GetLastestTokensStatus.failure(
      GetLastestTokensFailure failure) = _GetLastestTokensFailure;
}

@freezed
class TrendingState with _$TrendingState {
  const factory TrendingState({
    @Default(GetLastestTokensStatus.initial()) GetLastestTokensStatus status,
    @Default([]) List<LatestToken> lastestTokens,
  }) = _TrendingState;
}
