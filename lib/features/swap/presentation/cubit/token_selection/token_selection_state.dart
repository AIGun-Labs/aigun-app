import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../swap/swap_state.dart';

part 'token_selection_state.freezed.dart';

/// Token Selection State
@freezed
sealed class TokenSelectionState with _$TokenSelectionState {
  const TokenSelectionState._();

  const factory TokenSelectionState({
    /// Source token for swap
    @Default(defaultFormTradeToken) TransactionEntity? fromToken,

    /// Target token for swap
    @Default(defaultTradeToken) TransactionEntity? toToken,

    /// Available tokens from user wallet
    @Default([]) List<BaseTokenEntity> availableTokens,

    /// Native tokens list
    @Default([]) List<BaseTokenEntity> nativeTokens,

    /// Current from token balance
    @Default(null) double? fromBalance,

    /// Balance loading status
    @Default(TokenBalanceStatus.initial()) TokenBalanceStatus balanceStatus,

    /// Search status
    @Default(TokenSearchStatus.initial()) TokenSearchStatus searchStatus,
  }) = _TokenSelectionState;

  /// Check if user has enough balance
  bool get hasEnoughBalance {
    if (fromBalance == null || fromBalance! <= 0) return false;
    return true;
  }

  /// Check if both tokens are selected
  bool get hasSelectedTokens => fromToken != null && toToken != null;
}

/// Token balance loading status
@freezed
sealed class TokenBalanceStatus with _$TokenBalanceStatus {
  const factory TokenBalanceStatus.initial() = _TokenBalanceInitial;
  const factory TokenBalanceStatus.loading() = _TokenBalanceLoading;
  const factory TokenBalanceStatus.success(String balance) =
      _TokenBalanceSuccess;
  const factory TokenBalanceStatus.failure([String? message]) =
      _TokenBalanceFailure;
}

/// Token search status
@freezed
sealed class TokenSearchStatus with _$TokenSearchStatus {
  const factory TokenSearchStatus.initial() = _TokenSearchInitial;
  const factory TokenSearchStatus.loading() = _TokenSearchLoading;
  const factory TokenSearchStatus.success() = _TokenSearchSuccess;
  const factory TokenSearchStatus.failure([String? message]) =
      _TokenSearchFailure;
}
