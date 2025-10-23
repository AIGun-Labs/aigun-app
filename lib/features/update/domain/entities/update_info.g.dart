// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateInfoImpl _$$UpdateInfoImplFromJson(Map<String, dynamic> json) =>
    _$UpdateInfoImpl(
      app: json['app'] as String,
      latest: json['latest'] as String,
      build: (json['build'] as num).toInt(),
      minVersion: json['min_version'] as String?,
      url: json['url'] as String,
      sha256: json['sha256'] as String,
      force: json['force'] as bool,
      filename: json['filename'] as String,
      notes: (json['notes'] as List<dynamic>).map((e) => e as String).toList(),
      multilingualNotes:
          (json['multilingual_notes'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                    k, (e as List<dynamic>).map((e) => e as String).toList()),
              ) ??
              {},
    );

Map<String, dynamic> _$$UpdateInfoImplToJson(_$UpdateInfoImpl instance) =>
    <String, dynamic>{
      'app': instance.app,
      'latest': instance.latest,
      'build': instance.build,
      'min_version': instance.minVersion,
      'url': instance.url,
      'sha256': instance.sha256,
      'force': instance.force,
      'filename': instance.filename,
      'notes': instance.notes,
      'multilingual_notes': instance.multilingualNotes,
    };
