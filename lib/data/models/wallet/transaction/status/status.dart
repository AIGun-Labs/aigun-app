import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../enums/transaction.dart';

part 'status.freezed.dart';
part "status.g.dart";

class TransactionStatusConverter
    implements JsonConverter<TransactionStatusEnum?, String?> {
  const TransactionStatusConverter();

  @override
  TransactionStatusEnum? fromJson(String? json) {
    if (json == null) return null;
    switch (json.toUpperCase()) {
      case 'SUCCESS':
        return TransactionStatusEnum.success;
      case 'PENDING':
        return TransactionStatusEnum.pending;
      case 'FAILED':
        return TransactionStatusEnum.failed;
      default:
        throw ArgumentError("Unknown transaction status: $json");
    }
  }

  @override
  String? toJson(TransactionStatusEnum? object) {
    return object?.value;
  }
}

@freezed
class WalletTransactionStatus with _$WalletTransactionStatus {
  const factory WalletTransactionStatus({
    @JsonKey(name: "status") String? status,
  }) = _WalletTransactionStatus;

  factory WalletTransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionStatusFromJson(json);
}
