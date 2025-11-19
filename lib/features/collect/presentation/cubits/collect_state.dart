part of 'collect_cubit.dart';

enum CollectStatus {
  initial,
  loading,
  success,
  error,
  noData,
}

enum CollectActionStatus {
  idle,
  adding,
  removing,
  pinning,
  success,
  error,
}

@freezed
class CollectState with _$CollectState {
  // 添加私有构造函数
  const CollectState._();

  const factory CollectState({
    @Default(CollectStatus.initial) CollectStatus status,
    @Default([]) List<CollectTokenEntity> tokens,
    @Default(CollectActionStatus.idle) CollectActionStatus actionStatus,
    String? errorMessage,
  }) = _CollectState;

  bool isCollected(CollectTokenEntity? token) {
    if (token == null) return false;
    return tokens.any((element) =>
        element.address == token.address && element.network == token.network);
  }
}
