import "package:freezed_annotation/freezed_annotation.dart";

import '../../../../data/models/transfer/index.dart';

part "swap_result_entity.freezed.dart";
part "swap_result_entity.g.dart";

@freezed
sealed class SwapResultEntity with _$SwapResultEntity {
  const factory SwapResultEntity({
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "captcha") Captcha? captcha,
    @JsonKey(name: "sms") Sms? sms,
    @JsonKey(name: "tx_hash") String? txHash,
    @JsonKey(name: "tx_url") String? txUrl,
    @JsonKey(name: "status") String? status,
  }) = _SwapResultEntity;

  factory SwapResultEntity.fromJson(Map<String, dynamic> json) =>
      _$SwapResultEntityFromJson(json);
}
