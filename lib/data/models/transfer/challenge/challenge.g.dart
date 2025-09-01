// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      captcha: json['captcha'] == null
          ? null
          : Captcha.fromJson(json['captcha'] as Map<String, dynamic>),
      sms: json['sms'] == null
          ? null
          : Sms.fromJson(json['sms'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'captcha': instance.captcha,
      'sms': instance.sms,
    };
