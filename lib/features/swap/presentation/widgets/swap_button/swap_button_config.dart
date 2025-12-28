import 'package:flutter/material.dart';

///
class TradeButtonConfig {
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final bool isQuoteLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Widget? icon;
  final Widget? customContent;
  final Widget? loadingContent;
  final BorderRadius? borderRadius;
  final double cutSize;
  final double? width;
  final double? height;
  final bool isBuyMode;

  const TradeButtonConfig({
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    this.isQuoteLoading = false,
    this.onPressed,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
    this.iconColor,
    this.icon,
    this.customContent,
    this.loadingContent,
    this.borderRadius,
    this.cutSize = 20.0,
    this.width,
    this.height,
    this.isBuyMode = false,
  });
  bool get shouldShowDisabled => !isEnabled || isLoading || isQuoteLoading;
  TradeButtonConfig copyWith({
    String? text,
    bool? isEnabled,
    bool? isLoading,
    bool? isQuoteLoading,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? textColor,
    Color? iconColor,
    Widget? icon,
    Widget? customContent,
    Widget? loadingContent,
    BorderRadius? borderRadius,
    double? cutSize,
    double? width,
    double? height,
    bool? isBuyMode,
  }) {
    return TradeButtonConfig(
      text: text ?? this.text,
      isEnabled: isEnabled ?? this.isEnabled,
      isLoading: isLoading ?? this.isLoading,
      isQuoteLoading: isQuoteLoading ?? this.isQuoteLoading,
      onPressed: onPressed ?? this.onPressed,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      icon: icon ?? this.icon,
      customContent: customContent ?? this.customContent,
      loadingContent: loadingContent ?? this.loadingContent,
      borderRadius: borderRadius ?? this.borderRadius,
      cutSize: cutSize ?? this.cutSize,
      width: width ?? this.width,
      height: height ?? this.height,
      isBuyMode: isBuyMode ?? this.isBuyMode,
    );
  }
}

///
class TradeButtonStateBuilder {
  final bool hasValidParams;
  final bool hasValidQuote;
  final bool isQuoteLoading;
  final bool isTrading;
  final bool hasEnoughBalance;
  final bool hasEnoughFee;
  final bool hasInputAmount;
  final String? fromTokenSymbol;

  const TradeButtonStateBuilder({
    this.hasValidParams = true,
    this.hasValidQuote = false,
    this.isQuoteLoading = false,
    this.isTrading = false,
    this.hasEnoughBalance = true,
    this.hasEnoughFee = true,
    this.hasInputAmount = false,
    this.fromTokenSymbol,
  });
  bool get isEnabled =>
      hasValidParams &&
      hasValidQuote &&
      hasEnoughBalance &&
      hasEnoughFee &&
      hasInputAmount &&
      !isTrading;
  TradeButtonError? get error {
    if (!hasInputAmount) return null;
    if (!hasEnoughFee) return TradeButtonError.insufficientFee;
    if (!hasEnoughBalance) return TradeButtonError.insufficientBalance;
    if (!hasValidQuote) return TradeButtonError.noQuote;
    if (!hasValidParams) return TradeButtonError.invalidParams;
    return null;
  }

  String? getErrorText({
    required String balanceNotEnoughText,
    required String feeNotEnoughText,
  }) {
    final errorType = error;
    if (errorType == null) return null;

    switch (errorType) {
      case TradeButtonError.insufficientFee:
        return feeNotEnoughText;
      case TradeButtonError.insufficientBalance:
        return fromTokenSymbol != null
            ? '$fromTokenSymbol $balanceNotEnoughText'
            : balanceNotEnoughText;
      case TradeButtonError.noQuote:
      case TradeButtonError.invalidParams:
        return null;
    }
  }
}

enum TradeButtonError {
  insufficientBalance,
  insufficientFee,
  noQuote,
  invalidParams,
}
