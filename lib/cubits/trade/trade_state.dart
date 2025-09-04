import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    // @JsonKey(name: "amount") required String amount,
  }) = _TradeToken;
}

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
  }) = _TradeState;
}
