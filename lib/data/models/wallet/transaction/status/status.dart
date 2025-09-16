import 'package:flutter_aigun/enums/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';
part "status.g.dart";

@freezed
class WalletTransactionStatus with _$WalletTransactionStatus {
  const factory WalletTransactionStatus({
    @JsonKey(name: "status") TransactionStatusEnum? status,
  }) = _WalletTransactionStatus;

  factory WalletTransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionStatusFromJson(json);
}
