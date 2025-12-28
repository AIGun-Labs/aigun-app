import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';
import '../../data/models/swap/index.dart';
import '../../data/models/swap/target_token/target_token.dart';
import '../../data/models/wallet/token/token.dart';

part 'swap_state.freezed.dart';

@freezed
class TransactionStatus with _$TransactionStatus {
  const factory TransactionStatus.initial() = _TransactionInitial;
  const factory TransactionStatus.loading() = _TransactionLoading;
  const factory TransactionStatus.success(SwapTransaction data) =
      _TransactionSuccess;
  const factory TransactionStatus.error(String message) = _TransactionError;
}

@freezed
class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(SwapQuote quote) = _QuoteSuccess;
  const factory QuoteStatus.error(String message) = _QuoteError;
}

@freezed
sealed class SwapState with _$SwapState {
  const factory SwapState({
    @Default(TransactionStatus.initial()) TransactionStatus transactionStatus,
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
    @Default(56) int fromChainId, //
    @Default('56') String toChainId, //
    @Default('') String inputMint, //
    @Default('0xba2ae424d960c26247dd6c32edc70b295c744c43') String outputMint, //
    @Default('0') String amount, //
    @Default(100) double slippage, //
    @Default('0') String priorityFee, //
    @Default(false) bool isLoading,
    TargetToken? toToken,
    SwapQuote? quote,
    Token? selectedToken,
    Chain? selectedChain,
  }) = _SwapState;

  factory SwapState.initial() => const SwapState(
    transactionStatus: TransactionStatus.initial(),
    quoteStatus: QuoteStatus.initial(),
  );

  factory SwapState.loading() => const SwapState(
    transactionStatus: TransactionStatus.loading(),
    quoteStatus: QuoteStatus.loading(),
  );

  factory SwapState.success(SwapQuote quote, SwapTransaction transaction) =>
      SwapState(
        transactionStatus: TransactionStatus.success(transaction),
        quoteStatus: QuoteStatus.success(quote),
      );

  factory SwapState.error(String message) => SwapState(
    transactionStatus: TransactionStatus.error(message),
    quoteStatus: QuoteStatus.error(message),
  );
}
