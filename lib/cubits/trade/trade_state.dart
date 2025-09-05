import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'trade_state.freezed.dart';

enum TradeStatus {
  none,
  paramsInvalid,
}

@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(TransferQuote quote) = _QuoteSuccess;
  const factory QuoteStatus.failure() = _QuoteFailure;
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
    // @JsonKey(name: "amount") required String amount,
  }) = _TradeToken;
}

const List<Token> defaultToTokens = [
  Token(
    chainId: 56,
    chainLogo:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenAvatar:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenName: "Binance Coin",
    address: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    tokenPrice: "1",
    rawBalance: "1",
    balance: "1",
    decimals: 18,
    symbol: "BNB",
  ),
  Token(
    chainId: 56,
    chainLogo:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenAvatar:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenName: "Binance Coin",
    address: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    tokenPrice: "1",
    rawBalance: "1",
    balance: "1",
    decimals: 18,
    symbol: "BNB",
  ),
  Token(
    chainId: 56,
    chainLogo:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenAvatar:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenName: "Binance Coin",
    address: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    tokenPrice: "1",
    rawBalance: "1",
    balance: "1",
    decimals: 18,
    symbol: "BNB",
  ),
  Token(
    chainId: 56,
    chainLogo:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenAvatar:
        "https://assets.coingecko.com/coins/images/825/large/binancecoin.png?1696501628",
    tokenName: "Binance Coin",
    address: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    tokenPrice: "1",
    rawBalance: "1",
    balance: "1",
    decimals: 18,
    symbol: "BNB",
  ),
];

@freezed
class TradeState with _$TradeState {
  const factory TradeState({
    @Default(TradeStatusMessage.initial()) TradeStatusMessage status,
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
    @Default(100) int slippage,
    @Default(0) int priorityFee,
    @Default("0") String amount,
    @Default(56) int fromChainId,
    @Default(56) int toChainId,
    @Default(null) TransferQuote? quote,
    @Default([]) List<Token> availableTokens,
    @Default(null) TradeToken? fromToken,
    @Default(null) TradeToken? toToken,
    @Default(null) TextEditingController? amountController,
    @Default(defaultToTokens) List<Token> toTokens, // 目标代币
    @Default([]) List<Token> nativeTokens,
  }) = _TradeState;

  factory TradeState.initial() => TradeState(
        amountController: TextEditingController(text: "0"),
      );
}
