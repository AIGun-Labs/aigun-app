// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Multilingual _$MultilingualFromJson(Map<String, dynamic> json) =>
    _Multilingual(
      zh: json['zh'] as String? ?? '',
      en: json['en'] as String? ?? '',
      original: json['original'] as String? ?? '',
      jp: json['jp'] as String? ?? '',
      ko: json['ko'] as String? ?? '',
    );

Map<String, dynamic> _$MultilingualToJson(_Multilingual instance) =>
    <String, dynamic>{
      'zh': instance.zh,
      'en': instance.en,
      'original': instance.original,
      'jp': instance.jp,
      'ko': instance.ko,
    };
