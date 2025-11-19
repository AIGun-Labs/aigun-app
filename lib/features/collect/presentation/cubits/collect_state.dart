part of 'collect_cubit.dart';

enum CollectStatus {
  initial,
  loading,
  success,
  error,
  noData,
}

@freezed
class CollectState with _$CollectState {
  const factory CollectState({
    @Default(CollectStatus.initial) CollectStatus status,
    @Default([]) List<CollectTokenEntity> tokens,
    String? errorMessage,
  }) = _CollectState;
}
