import 'package:flutter/material.dart';

/// 交易按钮配置
///
/// 通用的交易按钮配置类，支持在不同 Cubit（SwapCubit, QuickTradeCubit 等）中复用
/// 外部通过传入配置来控制按钮的状态和行为
class TradeButtonConfig {
  /// 按钮文本
  final String text;

  /// 是否可用
  final bool isEnabled;

  /// 是否正在加载中（交易中）
  final bool isLoading;

  /// 是否正在询价中
  final bool isQuoteLoading;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 背景颜色
  final Color? backgroundColor;

  /// 禁用时背景颜色
  final Color? disabledBackgroundColor;

  /// 文本颜色
  final Color? textColor;

  /// 图标颜色
  final Color? iconColor;

  /// 自定义图标（可选）
  final Widget? icon;

  /// 自定义内容（完全覆盖默认内容）
  final Widget? customContent;

  /// 加载中显示的内容（可选，默认使用 Lottie 动画）
  final Widget? loadingContent;

  /// 按钮圆角
  final BorderRadius? borderRadius;

  /// 切角大小（用于特殊形状按钮）
  final double cutSize;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 是否为购买模式（影响默认样式）
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

  /// 检查按钮是否应该显示为禁用状态
  bool get shouldShowDisabled => !isEnabled || isLoading || isQuoteLoading;

  /// 复制并修改配置
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

/// 交易按钮状态构建器
///
/// 帮助从业务状态构建 TradeButtonConfig
/// 提供常见的状态逻辑封装
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

  /// 按钮是否可用
  bool get isEnabled =>
      hasValidParams &&
      hasValidQuote &&
      hasEnoughBalance &&
      hasEnoughFee &&
      hasInputAmount &&
      !isTrading;

  /// 获取错误类型
  TradeButtonError? get error {
    if (!hasInputAmount) return null;
    if (!hasEnoughFee) return TradeButtonError.insufficientFee;
    if (!hasEnoughBalance) return TradeButtonError.insufficientBalance;
    if (!hasValidQuote) return TradeButtonError.noQuote;
    if (!hasValidParams) return TradeButtonError.invalidParams;
    return null;
  }

  /// 获取错误文本
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

/// 按钮错误类型
enum TradeButtonError {
  insufficientBalance,
  insufficientFee,
  noQuote,
  invalidParams,
}
