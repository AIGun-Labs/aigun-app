import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_token_state.freezed.dart';

enum SearchTokenStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class SearchTokenState with _$SearchTokenState {
  const factory SearchTokenState({
    @Default([]) List<Token> matchedTokens,
    @Default('') String searchKeyword,
    @Default(SearchTokenStatus.initial) SearchTokenStatus status,
  }) = _SearchTokenState;
}
