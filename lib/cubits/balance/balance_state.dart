import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_state.freezed.dart';

@freezed
class BalanceState with _$BalanceState {
  const factory BalanceState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    Balance? balances,
    @Default(false) bool hideSmallAssets,
    @Default(0) int selectedChainIndex,
    @Default('') String searchQuery,
    @Default([]) List<Token> filteredTokens,
    @Default([]) List<Token> sortedTokens,
  }) = _BalanceState;
}
