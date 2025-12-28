import "package:freezed_annotation/freezed_annotation.dart";

import '../../../../data/models/transfer/index.dart';
import '../../domain/entities/swap_result_entity.dart';

part "transaction_model.freezed.dart";
part "transaction_model.g.dart";

@freezed
sealed class TransactionModel with _$TransactionModel {
  const TransactionModel._();
  const factory TransactionModel({
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "captcha") Captcha? captcha,
    @JsonKey(name: "sms") Sms? sms,
    @JsonKey(name: "tx_hash") String? txHash,
    @JsonKey(name: "tx_url") String? txUrl,
    @JsonKey(name: "status") String? status,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  SwapResultEntity toEntity() => SwapResultEntity(
    type: type,
    captcha: captcha,
    sms: sms,
    txHash: txHash,
    txUrl: txUrl,
    status: status,
  );
}
