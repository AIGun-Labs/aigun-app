import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/quote_entity.dart';

part 'quote_state.freezed.dart';

/// 询价状态
@freezed
sealed class QuoteState with _$QuoteState {
  const QuoteState._();

  const factory QuoteState({
    /// 询价状态
    @Default(QuoteStatus.initial()) QuoteStatus status,

    /// 当前报价
    @Default(null) QuoteEntity? quote,

    /// 上次询价时间戳（用于定时刷新）
    @Default(null) DateTime? lastQuoteTimestamp,

    /// 交易金额
    @Default('') String amount,

    /// 滑点设置（单位：基点，100 = 1%）
    @Default(100) int slippage,

    /// 优先费用
    @Default(0) int priorityFee,

    /// 参数验证状态
    @Default(QuoteParamsStatus.initial()) QuoteParamsStatus paramsStatus,
  }) = _QuoteState;

  /// 检查是否有有效报价
  bool get hasValidQuote => quote != null && status is _QuoteSuccess;

  /// 获取输出金额
  String? get outputAmount => quote?.outAmount;
}

/// 询价请求状态
@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(QuoteEntity quote) = _QuoteSuccess;
  const factory QuoteStatus.failure([String? message]) = _QuoteFailure;
}

/// 询价参数验证状态
@freezed
sealed class QuoteParamsStatus with _$QuoteParamsStatus {
  const factory QuoteParamsStatus.initial() = _QuoteParamsInitial;
  const factory QuoteParamsStatus.valid() = _QuoteParamsValid;
  const factory QuoteParamsStatus.invalid([String? reason]) =
      _QuoteParamsInvalid;
}
