import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/quote_entity.dart';

part 'quote_state.freezed.dart';

@freezed
sealed class QuoteState with _$QuoteState {
  const QuoteState._();

  const factory QuoteState({
    @Default(QuoteStatus.initial()) QuoteStatus status,
    @Default(null) QuoteEntity? quote,
    @Default(null) DateTime? lastQuoteTimestamp,
    @Default('') String amount,
    @Default(100) int slippage,
    @Default(0) int priorityFee,
    @Default(QuoteParamsStatus.initial()) QuoteParamsStatus paramsStatus,
  }) = _QuoteState;
  bool get hasValidQuote => quote != null && status is _QuoteSuccess;
  String? get outputAmount => quote?.outAmount;
}

@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(QuoteEntity quote) = _QuoteSuccess;
  const factory QuoteStatus.failure([String? message]) = _QuoteFailure;
}

@freezed
sealed class QuoteParamsStatus with _$QuoteParamsStatus {
  const factory QuoteParamsStatus.initial() = _QuoteParamsInitial;
  const factory QuoteParamsStatus.valid() = _QuoteParamsValid;
  const factory QuoteParamsStatus.invalid([String? reason]) =
      _QuoteParamsInvalid;
}
