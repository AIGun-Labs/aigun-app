// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonitorGroupImpl _$$MonitorGroupImplFromJson(Map<String, dynamic> json) =>
    _$MonitorGroupImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subDescription: json['subscriptions_description'] as String?,
    );

Map<String, dynamic> _$$MonitorGroupImplToJson(_$MonitorGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subscriptions_description': instance.subDescription,
    };
