import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/swap_result_entity.dart';

part 'transaction_state.freezed.dart';

/// 交易状态
@freezed
sealed class TransactionState with _$TransactionState {
  const TransactionState._();

  const factory TransactionState({
    /// 交易状态
    @Default(TransactionStatus.initial()) TransactionStatus status,

    /// 交易结果
    @Default(null) SwapResultEntity? result,

    /// 错误信息
    @Default(null) String? errorMessage,

    /// 交易哈希
    @Default(null) String? txHash,

    /// 交易 URL
    @Default(null) String? txUrl,
  }) = _TransactionState;

  /// 检查是否正在交易中
  bool get isTrading =>
      status is _TransactionSubmitting || status is _TransactionPolling;

  /// 检查交易是否成功
  bool get isSuccess => status is _TransactionSuccess;

  /// 检查交易是否失败
  bool get isFailed => status is _TransactionFailure;
}

/// 交易执行状态
@freezed
sealed class TransactionStatus with _$TransactionStatus {
  /// 初始状态
  const factory TransactionStatus.initial() = _TransactionInitial;

  /// 提交交易中
  const factory TransactionStatus.submitting() = _TransactionSubmitting;

  /// 轮询交易状态中
  const factory TransactionStatus.polling({
    required String txHash,
    String? txUrl,
  }) = _TransactionPolling;

  /// 交易成功
  const factory TransactionStatus.success(SwapResultEntity result) =
      _TransactionSuccess;

  /// 交易失败
  const factory TransactionStatus.failure([String? message]) =
      _TransactionFailure;
}
