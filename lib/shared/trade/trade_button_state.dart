import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

part 'trade_button_state.freezed.dart';

/// 交易按钮的所有可能状态
/// 使用密封联合类型确保类型安全和完整的模式匹配
@freezed
sealed class TradeButtonState with _$TradeButtonState {
  const TradeButtonState._();

  /// 按钮禁用状态 - 无法进行交易
  const factory TradeButtonState.disabled({
    required TradeButtonDisabledReason reason,
  }) = TradeButtonDisabled;

  /// 正在获取报价 - 显示加载动画
  const factory TradeButtonState.quoteLoading() = TradeButtonQuoteLoading;

  /// 正在执行交易
  const factory TradeButtonState.trading() = TradeButtonTrading;

  /// 准备就绪 - 所有验证通过，可以交易
  const factory TradeButtonState.ready() = TradeButtonReady;

  // ==================== UI 辅助方法 ====================

  /// 按钮是否可点击
  bool get isEnabled => this is TradeButtonReady;

  /// 是否显示加载动画
  bool get isLoading =>
      this is TradeButtonQuoteLoading || this is TradeButtonTrading;

  /// 获取按钮文本标签
  String getLabel(BuildContext context, {required String defaultLabel}) {
    return when(
      disabled: (reason) => reason.getLabel(context),
      quoteLoading: () => defaultLabel,
      trading: () => defaultLabel,
      ready: () => defaultLabel,
    );
  }

  /// 获取按钮背景色
  Color getBackgroundColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.quinary,
      quoteLoading: () => AppColors.quinary,
      trading: () => AppColors.quinary,
      ready: () => AppColors.buttonPrimary(context),
    );
  }

  /// 获取按钮文字颜色
  Color getLabelColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.textTertiary(context),
      quoteLoading: () => AppColors.textTertiary(context),
      trading: () => AppColors.textTertiary(context),
      ready: () => Colors.black,
    );
  }

  /// 获取图标颜色
  Color getIconColor(BuildContext context) {
    return getLabelColor(context);
  }
}

/// 按钮禁用的具体原因
/// 每个原因都有对应的优先级和错误消息
@freezed
sealed class TradeButtonDisabledReason with _$TradeButtonDisabledReason {
  const TradeButtonDisabledReason._();

  /// 未输入金额
  const factory TradeButtonDisabledReason.noAmount() = _NoAmount;

  /// 金额无效（小数转换后为零）
  const factory TradeButtonDisabledReason.invalidAmount() = _InvalidAmount;

  /// 余额不足
  const factory TradeButtonDisabledReason.insufficientBalance({
    required String tokenSymbol,
  }) = _InsufficientBalance;

  /// 手续费不足
  const factory TradeButtonDisabledReason.insufficientFee() = _InsufficientFee;

  /// 没有报价
  const factory TradeButtonDisabledReason.noQuote() = _NoQuote;

  /// 报价失败
  const factory TradeButtonDisabledReason.quoteFailed() = _QuoteFailed;

  /// 参数无效
  const factory TradeButtonDisabledReason.invalidParams() = _InvalidParams;

  /// 选择了相同的代币
  const factory TradeButtonDisabledReason.sameToken() = _SameToken;

  /// 获取错误消息文本
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

  /// 错误优先级
  /// 数字越大优先级越高，优先显示高优先级的错误
  int get priority => when(
    noQuote: () => 1, // 等待报价
    noAmount: () => 2, // 没输入金额
    quoteFailed: () => 3, // 报价失败
    invalidAmount: () => 4, // 金额无效
    insufficientFee: () => 5, // 手续费不足
    insufficientBalance: (_) => 6, // 余额不足
    invalidParams: () => 7, // 参数错误
    sameToken: () => 8, // 最高优先级：选择了相同代币
  );
}
