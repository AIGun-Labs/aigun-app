import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/swap_result_entity.dart';

part 'transaction_state.freezed.dart';

@freezed
sealed class TransactionState with _$TransactionState {
  const TransactionState._();

  const factory TransactionState({
    @Default(TransactionStatus.initial()) TransactionStatus status,
    @Default(null) SwapResultEntity? result,
    @Default(null) String? errorMessage,
    @Default(null) String? txHash,
    @Default(null) String? txUrl,
  }) = _TransactionState;
  bool get isTrading =>
      status is _TransactionSubmitting || status is _TransactionPolling;
  bool get isSuccess => status is _TransactionSuccess;
  bool get isFailed => status is _TransactionFailure;
}

@freezed
sealed class TransactionStatus with _$TransactionStatus {
  const factory TransactionStatus.initial() = _TransactionInitial;
  const factory TransactionStatus.submitting() = _TransactionSubmitting;
  const factory TransactionStatus.polling({
    required String txHash,
    String? txUrl,
  }) = _TransactionPolling;
  const factory TransactionStatus.success(SwapResultEntity result) =
      _TransactionSuccess;
  const factory TransactionStatus.failure([String? message]) =
      _TransactionFailure;
}
