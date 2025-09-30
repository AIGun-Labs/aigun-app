import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest_token_state.freezed.dart';

@freezed
class LatestTokenStatus with _$LatestTokenStatus {
  const factory LatestTokenStatus.initial() = _Initial;
  const factory LatestTokenStatus.loading() = _Loading;
  const factory LatestTokenStatus.loadingMore() = _LoadingMore;
  const factory LatestTokenStatus.success(List<LatestToken> tokens) = _Success;
  const factory LatestTokenStatus.error(String message) = _Error;
}

@freezed
class LatestTokenState with _$LatestTokenState {
  const factory LatestTokenState({
    @Default([]) List<LatestToken> tokens,
    @Default(LatestTokenStatus.initial()) LatestTokenStatus status,
    String? lastQueryTime,
    @Default(false) bool hasMore,
  }) = _LatestTokenState;
}