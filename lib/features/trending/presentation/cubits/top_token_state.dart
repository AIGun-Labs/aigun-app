part of 'top_token_cubit.dart';

enum TopTokenStatus { initial, loading, success, failure }

@freezed
class TopTokenState with _$TopTokenState {
  @override
  final TopTokenStatus status;
  @override
  final List<BaseTokenEntity> tokens;
  @override
  final String? lastTime;
  @override
  final bool hasMore;
  @override
  final String? errorMessage;

  @override
  final Map<String, dynamic>? queryParameters;

  @override
  final String? paginationField;

  @override
  final Set<String> visibleTokenKeys;
  @override
  final Map<String, RealtimeEntity> realtimeMap;

  const TopTokenState({
    this.status = TopTokenStatus.initial,
    this.tokens = const [],
    this.lastTime,
    this.hasMore = true,
    this.errorMessage,
    this.visibleTokenKeys = const {},
    this.realtimeMap = const {},
    this.queryParameters,
    this.paginationField,
  });
}
