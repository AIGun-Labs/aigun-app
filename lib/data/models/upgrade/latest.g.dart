// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LatestImpl _$$LatestImplFromJson(Map<String, dynamic> json) => _$LatestImpl(
      app: json['app'] as String,
      build: json['build'] as String,
      latest: json['latest'] as String,
      minVersion: json['min_version'] as String,
      notes: (json['notes'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      sha256: json['sha256'] as String,
      force: json['force'] as bool,
    );

Map<String, dynamic> _$$LatestImplToJson(_$LatestImpl instance) =>
    <String, dynamic>{
      'app': instance.app,
      'build': instance.build,
      'latest': instance.latest,
      'min_version': instance.minVersion,
      'notes': instance.notes,
      'url': instance.url,
      'sha256': instance.sha256,
      'force': instance.force,
    };
