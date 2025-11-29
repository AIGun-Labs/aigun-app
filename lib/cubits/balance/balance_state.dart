import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';
import '../../data/models/wallet/token/token.dart';

part 'balance_state.freezed.dart';

@freezed
sealed class BalanceState with _$BalanceState {
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

  static const BalanceState initial = BalanceState();
}
