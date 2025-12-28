import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

part 'trade_button_state.freezed.dart';

@freezed
sealed class TradeButtonState with _$TradeButtonState {
  const TradeButtonState._();
  const factory TradeButtonState.disabled({
    required TradeButtonDisabledReason reason,
  }) = TradeButtonDisabled;
  const factory TradeButtonState.quoteLoading() = TradeButtonQuoteLoading;
  const factory TradeButtonState.trading() = TradeButtonTrading;
  const factory TradeButtonState.ready() = TradeButtonReady;
  bool get isEnabled => this is TradeButtonReady;
  bool get isLoading =>
      this is TradeButtonQuoteLoading || this is TradeButtonTrading;
  String getLabel(BuildContext context, {required String defaultLabel}) {
    return when(
      disabled: (reason) => reason.getLabel(context),
      quoteLoading: () => defaultLabel,
      trading: () => defaultLabel,
      ready: () => defaultLabel,
    );
  }

  Color getBackgroundColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.quinary,
      quoteLoading: () => AppColors.quinary,
      trading: () => AppColors.quinary,
      ready: () => AppColors.buttonPrimary(context),
    );
  }

  Color getLabelColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.textTertiary(context),
      quoteLoading: () => AppColors.textTertiary(context),
      trading: () => AppColors.textTertiary(context),
      ready: () => Colors.black,
    );
  }

  Color getIconColor(BuildContext context) {
    return getLabelColor(context);
  }
}

@freezed
sealed class TradeButtonDisabledReason with _$TradeButtonDisabledReason {
  const TradeButtonDisabledReason._();
  const factory TradeButtonDisabledReason.noAmount() = _NoAmount;
  const factory TradeButtonDisabledReason.invalidAmount() = _InvalidAmount;
  const factory TradeButtonDisabledReason.insufficientBalance({
    required String tokenSymbol,
  }) = _InsufficientBalance;
  const factory TradeButtonDisabledReason.insufficientFee() = _InsufficientFee;
  const factory TradeButtonDisabledReason.noQuote() = _NoQuote;
  const factory TradeButtonDisabledReason.quoteFailed() = _QuoteFailed;
  const factory TradeButtonDisabledReason.invalidParams() = _InvalidParams;
  const factory TradeButtonDisabledReason.sameToken() = _SameToken;
  String getLabel(BuildContext context) {
    return when(
      noAmount: () => S.of(context).tradeNow,
      invalidAmount: () => S.of(context).invalidAmount,
      insufficientBalance: (symbol) =>
          '$symbol ${S.of(context).balanceNotEnough}',
      insufficientFee: () => S.of(context).feeNotEnough,
      noQuote: () => S.of(context).tradeNow,
      quoteFailed: () => S.of(context).quoteFailed,
      invalidParams: () => S.of(context).invalidParams,
      sameToken: () => S.of(context).selectDifferentToken,
    );
  }

  int get priority => when(
    noQuote: () => 1, //
    noAmount: () => 2, //
    quoteFailed: () => 3, //
    invalidAmount: () => 4, //
    insufficientFee: () => 5, //
    insufficientBalance: (_) => 6, //
    invalidParams: () => 7, //
    sameToken: () => 8, // ：
  );
}
