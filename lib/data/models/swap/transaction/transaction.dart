import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
sealed class SwapTransaction with _$SwapTransaction {
  const factory SwapTransaction({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'tx_hash') String? txHash,
    @JsonKey(name: 'tx_url') String? txUrl,
    @JsonKey(name: 'status') String? status,
  }) = _SwapTransaction;

  factory SwapTransaction.fromJson(Map<String, dynamic> json) =>
      _$SwapTransactionFromJson(json);
}
