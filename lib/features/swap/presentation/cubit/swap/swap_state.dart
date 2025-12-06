import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../domain/entities/quote_entity.dart';
import '../../../domain/entities/swap_result_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import 'swap_event.dart';

part 'swap_state.freezed.dart';

// ==================== Default Tokens ====================

/// 默认目标代币（USDC on Solana）
const TransactionEntity defaultTradeToken = TransactionEntity(
  isNative: false,
  chainId: '1151111081099710',
  chainLogo:
      'https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg',
  chainName: 'Solana',
  tokenAvatar:
      'https://static.oklink.com/cdn/web3/currency/token/large/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-107/type=default_90_0?v=1756203256814',
  tokenName: 'USDC',
  address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
  tokenPrice: 0,
  balance: '0',
  decimals: 6,
  network: 'solana',
  symbol: 'USDC',
);

/// 默认源代币（SOL on Solana）
const TransactionEntity defaultFormTradeToken = TransactionEntity(
  isNative: true,
  chainId: '1151111081099710',
  chainLogo:
      'https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg',
  chainName: 'Solana',
  tokenAvatar:
      'https://static.oklink.com/cdn/web3/currency/token/501-11111111111111111111111111111111-1.png/type=default_350_0?v=1734571825920',
  tokenName: 'SOL',
  address: '11111111111111111111111111111111',
  tokenPrice: 0,
  balance: '0',
  decimals: 9,
  network: 'solana',
  symbol: 'SOL',
);

/// 默认 BNB 代币
const TransactionEntity defaultBNBTradeToken = TransactionEntity(
  isNative: true,
  chainId: '56',
  chainLogo: 'assets/chain/bsc.png',
  chainName: 'BNB Chain',
  tokenAvatar:
      'image/iFE4m6Yk_eFlSyQMfxs3JG63Y77FvV68mwVQOTV9Sb5zEo1BdDm495nIqzsWagZ6FO3Z17ORa-x9dos2k-ebsA==',
  tokenName: 'BNB',
  address: '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
  tokenPrice: 0,
  balance: '0',
  decimals: 9,
  network: 'bsc',
  symbol: 'BNB',
);

// ==================== Legacy Status Types (保持向后兼容) ====================

enum TradeStatus { none, paramsInvalid }

@freezed
sealed class GetTokenBalanceStatus with _$GetTokenBalanceStatus {
  const factory GetTokenBalanceStatus.initial() = _GetTokenBalanceInitial;
  const factory GetTokenBalanceStatus.loading() = _GetTokenBalanceLoading;
  const factory GetTokenBalanceStatus.success(String balance) =
      _GetTokenBalanceSuccess;
  const factory GetTokenBalanceStatus.failure() = _GetTokenBalanceFailure;
}

@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(QuoteEntity quote) = _QuoteSuccess;
  const factory QuoteStatus.failure() = _QuoteFailure;
}

@freezed
sealed class TradeParamsStatus with _$TradeParamsStatus {
  const factory TradeParamsStatus.initial() = _TradeParamsInitial;
  const factory TradeParamsStatus.loading() = _TradeParamsLoading;
  const factory TradeParamsStatus.success() = _TradeParamsSuccess;
  const factory TradeParamsStatus.failure() = _TradeParamsFailure;
}

@freezed
sealed class TradeStatusMessage with _$TradeStatusMessage {
  const factory TradeStatusMessage.initial() = _TradeStatusInitial;
  const factory TradeStatusMessage.loading() = _TradeStatusLoading;
  const factory TradeStatusMessage.success(SwapResultEntity transaction) =
      _TradeStatusSuccess;
  const factory TradeStatusMessage.failure(TradeStatus failure) =
      _TradeStatusFailure;
}

// ==================== New Status Types ====================

/// Swap 整体状态
@freezed
sealed class SwapStatus with _$SwapStatus {
  const factory SwapStatus.initial() = _SwapStatusInitial;
  const factory SwapStatus.ready() = _SwapStatusReady;
  const factory SwapStatus.trading() = _SwapStatusTrading;
  const factory SwapStatus.success(SwapResultEntity result) =
      _SwapStatusSuccess;
  const factory SwapStatus.failure(String message) = _SwapStatusFailure;
}

// ==================== Main State ====================

/// SwapState - 主协调器状态
///
/// 这个状态聚合了子 Cubit 的关键数据，用于 UI 渲染
@freezed
sealed class SwapState with _$SwapState {
  const SwapState._();

  const factory SwapState({
    // ==================== 从子 Cubit 同步的状态 ====================

    /// 源代币（从 TokenSelectionCubit 同步）
    @Default(defaultFormTradeToken) TransactionEntity? fromToken,

    /// 目标代币（从 TokenSelectionCubit 同步）
    @Default(defaultTradeToken) TransactionEntity? toToken,

    /// 源代币余额（从 TokenSelectionCubit 同步）
    @Default(null) double? fromBalance,

    /// 可用代币列表（从 TokenSelectionCubit 同步）
    @Default([]) List<BaseTokenEntity> availableTokens,

    /// 原生代币列表（从 TokenSelectionCubit 同步）
    @Default([]) List<BaseTokenEntity> nativeTokens,

    /// 当前报价（从 QuoteCubit 同步）
    @Default(null) QuoteEntity? quote,

    /// 交易金额（从 QuoteCubit 同步）
    @Default('') String amount,

    // ==================== 综合状态 ====================

    /// Swap 整体状态
    @Default(SwapStatus.initial()) SwapStatus swapStatus,

    /// 参数验证状态
    @Default(TradeParamsStatus.initial()) TradeParamsStatus paramsStatus,

    /// 询价状态
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,

    /// 余额状态
    @Default(GetTokenBalanceStatus.initial())
    GetTokenBalanceStatus fromBalanceStatus,

    // ==================== 事件（用于 UI 响应） ====================

    /// 一次性事件（Toast、导航等）
    @Default(null) SwapEvent? event,

    // ==================== Legacy 字段（保持向后兼容） ====================

    /// @deprecated 使用 swapStatus 替代
    @Default(TradeStatusMessage.initial()) TradeStatusMessage status,

    /// @deprecated 使用 amount 替代
    @Default(null) String? toAmount,

    /// @deprecated 询价时间戳
    @Default(null) DateTime? lastQuoteTimestamp,

    /// 滑点设置
    @Default(100) int slippage,

    /// 优先费用
    @Default(0) int priorityFee,
  }) = _SwapState;

  // ==================== Computed Properties ====================

  /// 检查是否可以执行交易
  bool get canTrade =>
      fromToken != null &&
      toToken != null &&
      amount.isNotEmpty &&
      fromBalance != null &&
      fromBalance! > 0 &&
      quote != null;

  /// 检查是否正在交易中
  bool get isTrading => swapStatus is _SwapStatusTrading;

  /// 检查交易是否成功
  bool get isSuccess => swapStatus is _SwapStatusSuccess;

  /// 获取输出金额
  String? get outputAmount => quote?.outAmount;
}

// ==================== UI Config ====================

/// 交易按钮配置
class TradeButtonConfig {
  final bool isEnabled;
  final bool isLoading;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final Widget? icon;
  final VoidCallback? onPressed;

  const TradeButtonConfig({
    required this.isEnabled,
    required this.isLoading,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.iconColor,
    this.icon,
    this.onPressed,
  });
}
