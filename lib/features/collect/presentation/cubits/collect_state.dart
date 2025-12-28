part of 'collect_cubit.dart';

enum CollectStatus { initial, loading, success, error, noData }

enum CollectActionStatus {
  idle,
  adding,
  removing,
  pinning,
  success,
  added,
  removed,
  pinned,
  error,
}

@freezed
sealed class CollectState with _$CollectState {
  const factory CollectState({
    @Default(CollectStatus.initial) CollectStatus status,
    @Default([]) List<BaseTokenEntity> tokens,
    @Default(CollectActionStatus.idle) CollectActionStatus actionStatus,
    String? errorMessage,
  }) = _CollectState;
  const CollectState._();

  bool isCollected(BaseTokenEntity? token) {
    if (token == null) return false;
    return tokens.any(
      (element) =>
          element.address == token.address && element.network == token.network,
    );
  }
}
