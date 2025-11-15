import "package:freezed_annotation/freezed_annotation.dart";

import "../../transfer/sms/sms.dart";

part "wallet_payment.freezed.dart";
part "wallet_payment.g.dart";

@freezed
class Captcha with _$Captcha {
  const factory Captcha({
    @JsonKey(name: "key") String? key,
    @JsonKey(name: "image_base64") String? imageBase64,
    @JsonKey(name: "thumb_base64") String? thumbBase64,
  }) = _Captcha;

  factory Captcha.fromJson(Map<String, dynamic> json) =>
      _$CaptchaFromJson(json);
}

@freezed
class WalletPayment with _$WalletPayment {
  const factory WalletPayment({
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "captcha") Captcha? captcha,
    @JsonKey(name: "sms") Sms? sms,
    @JsonKey(name: "token") String? token,
  }) = _WalletPayment;

  factory WalletPayment.fromJson(Map<String, dynamic> json) =>
      _$WalletPaymentFromJson(json);
}
