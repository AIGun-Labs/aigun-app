part of 'tokens_cubit.dart';

enum TokensStatus { initial, loading, success, failure }

@freezed
class TokensState with _$TokensState {
  @override
  final TokensStatus status;
  @override
  final List<BaseTokenEntity> tokens;

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
  final Map<String, BaseTokenEntity> realtimeMap;

  @override
  final bool isLoadingMore;

  const TokensState({
    this.status = TokensStatus.initial,
    this.tokens = const [],
    this.hasMore = true,
    this.errorMessage,
    this.visibleTokenKeys = const {},
    this.realtimeMap = const {},
    this.queryParameters,
    this.paginationField,
    this.isLoadingMore = false,
  });
}
