// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaptchaImpl _$$CaptchaImplFromJson(Map<String, dynamic> json) =>
    _$CaptchaImpl(
      key: json['key'] as String,
      masterImage: json['master_image'] as String,
      thumbImage: json['thumb_image'] as String,
    );

Map<String, dynamic> _$$CaptchaImplToJson(_$CaptchaImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'master_image': instance.masterImage,
      'thumb_image': instance.thumbImage,
    };
