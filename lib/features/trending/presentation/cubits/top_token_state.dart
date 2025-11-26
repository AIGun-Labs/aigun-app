part of 'top_token_cubit.dart';

enum TopTokenStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class TopTokenState with _$TopTokenState {
  const factory TopTokenState({
    @Default(TopTokenStatus.initial) TopTokenStatus status,
    @Default([]) List<TopTokenEntity> tokens,
    String? lastTime,
    @Default(true) bool hasMore,
    String? errorMessage,
  }) = _TopTokenState;
}
