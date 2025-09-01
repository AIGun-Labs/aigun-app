// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaptchaImpl _$$CaptchaImplFromJson(Map<String, dynamic> json) =>
    _$CaptchaImpl(
      key: json['key'] as String?,
      imageBase64: json['image_base64'] as String?,
      thumbBase64: json['thumb_base64'] as String?,
    );

Map<String, dynamic> _$$CaptchaImplToJson(_$CaptchaImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'image_base64': instance.imageBase64,
      'thumb_base64': instance.thumbBase64,
    };

_$WalletPaymentImpl _$$WalletPaymentImplFromJson(Map<String, dynamic> json) =>
    _$WalletPaymentImpl(
      type: json['type'] as String?,
      captcha: json['captcha'] == null
          ? null
          : Captcha.fromJson(json['captcha'] as Map<String, dynamic>),
      sms: json['sms'] == null
          ? null
          : Sms.fromJson(json['sms'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$WalletPaymentImplToJson(_$WalletPaymentImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'captcha': instance.captcha,
      'sms': instance.sms,
      'token': instance.token,
    };
