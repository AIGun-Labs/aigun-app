import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'trade_state.freezed.dart';

enum TradeStatus {
  none,
  paramsInvalid,
}

const TradeToken defaultTradeToken = TradeToken(
    chainId: 1151111081099710,
    chainLogo:
        "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg",
    chainName: "Solana",
    tokenAvatar:
        "https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f736f6c616e612d6c6162732f746f6b656e2d6c6973742f6d61696e2f6173736574732f6d61696e6e65742f45506a465764643541756671535371654d32714e31787a7962617043384734774547476b5a777954447431762f6c6f676f2e706e67",
    tokenName: "USDC",
    address: "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v",
    tokenPrice: 0,
    balance: "0",
    decimals: 6,
    symbol: "USDC");

const TradeToken defaultFormTradeToken = TradeToken(
    chainId: 1151111081099710,
    chainLogo:
        "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg",
    chainName: "Solana",
    tokenAvatar:
        "https://static.oklink.com/cdn/web3/currency/token/501-11111111111111111111111111111111-1.png/type=default_350_0?v=1734571825920",
    tokenName: "SOL",
    address: "So11111111111111111111111111111111111111112",
    tokenPrice: 0,
    balance: "0",
    decimals: 9,
    symbol: "SOL");

const TradeToken defaultBNBTradeToken = TradeToken(
    chainId: 56,
    chainLogo: "assets/chain/bsc.png",
    chainName: "BNB Chain",
    tokenAvatar:
        "image/iFE4m6Yk_eFlSyQMfxs3JG63Y77FvV68mwVQOTV9Sb5zEo1BdDm495nIqzsWagZ6FO3Z17ORa-x9dos2k-ebsA==",
    tokenName: "BNB",
    address: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
    tokenPrice: 0,
    balance: "0",
    decimals: 9,
    symbol: "BNB");

@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(TransferQuote quote) = _QuoteSuccess;
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
  const factory TradeStatusMessage.success(TransferTransaction transaction) =
      _TradeStatusSuccess;
  const factory TradeStatusMessage.failure(TradeStatus failure) =
      _TradeStatusFailure;
}

@freezed
sealed class TradeGetBalanceStatus with _$TradeGetBalanceStatus {
  const factory TradeGetBalanceStatus.initial() = _TradeGetBalanceInitial;
  const factory TradeGetBalanceStatus.loading() = _TradeGetBalanceLoading;
  const factory TradeGetBalanceStatus.success(String balance) =
      _TradeGetBalanceSuccess;
  const factory TradeGetBalanceStatus.failure() = _TradeGetBalanceFailure;
}

@freezed
class TradeToken with _$TradeToken {
  const factory TradeToken({
    @JsonKey(name: "chain_id") required int chainId,
    // @JsonKey(name: "chain_name") String chainName,
    @JsonKey(name: "chain_logo") required String chainLogo,
    @JsonKey(name: "token_avatar") required String tokenAvatar,
    @JsonKey(name: "token_name") required String tokenName,
    @JsonKey(name: "address") required String address,
    @JsonKey(name: "decimals") required int decimals,
    @JsonKey(name: "symbol") required String symbol,
    @JsonKey(name: "balance") String? balance,
    @JsonKey(name: "chain_name") required String chainName,
    @JsonKey(name: "token_price") required double tokenPrice,
    // @JsonKey(name: "amount") required String amount,
  }) = _TradeToken;

  factory TradeToken.fromEntity(Entity entity) {
    try {
      final chainId = int.parse(entity.chain?.networkId ?? "0");

      final token = TradeToken(
          chainId: chainId,
          chainLogo: entity.chain?.logo ?? "",
          chainName: entity.chain?.name ?? "",
          tokenAvatar: entity.logo ?? "",
          tokenName: entity.name ?? "",
          address: entity.contractAddress ?? "",
          tokenPrice: 0,
          balance: "",
          decimals: entity.decimals ?? 0,
          symbol: entity.symbol ?? "");
      return token;
    } catch (e) {
      Logger.error("Token.fromEntity 转换失败: $e");
      return const TradeToken(
          chainId: 0,
          chainLogo: "",
          chainName: "",
          tokenAvatar: "",
          tokenName: "",
          address: "",
          tokenPrice: 0,
          balance: "",
          decimals: 0,
          symbol: "");
    }
  }
}

@freezed
class TradeState with _$TradeState {
  const factory TradeState(
      {@Default(TradeStatusMessage.initial()) TradeStatusMessage status,
      @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
      @Default(100) int slippage,
      @Default(0) int priorityFee,
      @Default("0") String amount,
      @Default(1151111081099710) int fromChainId,
      @Default(1151111081099710) int toChainId,
      @Default(null) TransferQuote? quote,
      @Default([]) List<Token> availableTokens,
      @Default(defaultFormTradeToken) TradeToken? fromToken,
      @Default(defaultTradeToken) TradeToken? toToken,
      @Default(null) TextEditingController? amountController,
      @Default(TradeParamsStatus.initial()) TradeParamsStatus paramsStatus,
      @Default([]) List<Token> nativeTokens,
      @Default(null) String? toAmount,
      @Default(0) double fromBalance,
      @Default(null) DateTime? lastQuoteTimestamp}) = _TradeState;

  factory TradeState.initial() => TradeState(
        amountController: TextEditingController(text: "0"),
      );
}

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
