import "package:flutter_aigun/data/models/transfer/index.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "transaction.freezed.dart";
part "transaction.g.dart";

// 交易响应的数据类型
@freezed
class TransferTransaction with _$TransferTransaction {
  const factory TransferTransaction({
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "captcha") Captcha? captcha,
    @JsonKey(name: "sms") Sms? sms,
    @JsonKey(name: "tx_hash") String? txHash,
    @JsonKey(name: "tx_url") String? txUrl,
    @JsonKey(name: "status") String? status,
  }) = _TransferTransaction;

  factory TransferTransaction.fromJson(Map<String, dynamic> json) =>
      _$TransferTransactionFromJson(json);
}
