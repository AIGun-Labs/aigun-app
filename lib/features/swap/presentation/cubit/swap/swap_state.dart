import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../domain/entities/quote_entity.dart';
import '../../../domain/entities/swap_result_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import 'swap_event.dart';

part 'swap_state.freezed.dart';

// ==================== Default Tokens ====================
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
  decimals: 18,
  network: 'bsc',
  symbol: 'BNB',
);

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
///
@freezed
sealed class SwapState with _$SwapState {
  const factory SwapState({
    @Default(defaultFormTradeToken) TransactionEntity? fromToken,
    @Default(defaultTradeToken) TransactionEntity? toToken,
    @Default(null) double? fromBalance,
    @Default([]) List<BaseTokenEntity> availableTokens,
    @Default([]) List<BaseTokenEntity> nativeTokens,
    @Default(null) QuoteEntity? quote,
    @Default('') String amount,
    @Default(SwapStatus.initial()) SwapStatus swapStatus,
    @Default(TradeParamsStatus.initial()) TradeParamsStatus paramsStatus,
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
    @Default(GetTokenBalanceStatus.initial())
    GetTokenBalanceStatus fromBalanceStatus,
    @Default(null) SwapEvent? event,
    @Default(TradeStatusMessage.initial()) TradeStatusMessage status,
    @Default(null) String? toAmount,
    @Default(null) DateTime? lastQuoteTimestamp,
    @Default(100) int slippage,
    @Default(0) int priorityFee,
  }) = _SwapState;
  const SwapState._();

  // ==================== Computed Properties ====================
  bool get canTrade =>
      fromToken != null &&
      toToken != null &&
      amount.isNotEmpty &&
      fromBalance != null &&
      fromBalance! > 0 &&
      quote != null;
  bool get isTrading => swapStatus is _SwapStatusTrading;
  bool get isSuccess => swapStatus is _SwapStatusSuccess;
  String? get outputAmount => quote?.outAmount;
}

// ==================== UI Config ====================
class TradeButtonConfig {
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
  final bool isEnabled;
  final bool isLoading;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final Widget? icon;
  final VoidCallback? onPressed;
}
