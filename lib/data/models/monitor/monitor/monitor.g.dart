// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonitorImpl _$$MonitorImplFromJson(Map<String, dynamic> json) =>
    _$MonitorImpl(
      monitorList: (json['subscriptions'] as List<dynamic>?)
          ?.map((e) => MonitorListType.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['total_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MonitorImplToJson(_$MonitorImpl instance) =>
    <String, dynamic>{
      'subscriptions': instance.monitorList,
      'total_count': instance.totalCount,
    };

_$MonitorListTypeImpl _$$MonitorListTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$MonitorListTypeImpl(
      id: json['id'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => MonitorTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      notTags: (json['not_tags'] as List<dynamic>?)
          ?.map((e) => MonitorTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['subscriptions_description'] as String?,
    );

Map<String, dynamic> _$$MonitorListTypeImplToJson(
        _$MonitorListTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'not_tags': instance.notTags,
      'subscriptions_description': instance.description,
    };

_$MonitorTagImpl _$$MonitorTagImplFromJson(Map<String, dynamic> json) =>
    _$MonitorTagImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      meta: json['meta'] == null
          ? null
          : MonitorTagMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MonitorTagImplToJson(_$MonitorTagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'meta': instance.meta,
    };

_$MonitorTagMetaImpl _$$MonitorTagMetaImplFromJson(Map<String, dynamic> json) =>
    _$MonitorTagMetaImpl(
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$MonitorTagMetaImplToJson(
        _$MonitorTagMetaImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
    };
