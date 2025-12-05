// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkStatus _$NetworkStatusFromJson(Map<String, dynamic> json) =>
    _NetworkStatus(
      status: $enumDecodeNullable(_$ServerHealthyStatusEnumMap, json['status']),
      details: json['details'] as String?,
      responseTime: (json['response_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NetworkStatusToJson(_NetworkStatus instance) =>
    <String, dynamic>{
      'status': _$ServerHealthyStatusEnumMap[instance.status],
      'details': instance.details,
      'response_time': instance.responseTime,
    };

const _$ServerHealthyStatusEnumMap = {
  ServerHealthyStatus.healthy: 'healthy',
  ServerHealthyStatus.unhealthy: 'unhealthy',
};

_NetworkResult _$NetworkResultFromJson(Map<String, dynamic> json) =>
    _NetworkResult(
      status: $enumDecodeNullable(_$ServerHealthyStatusEnumMap, json['status']),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      database: json['database'] == null
          ? null
          : NetworkStatus.fromJson(json['database'] as Map<String, dynamic>),
      redis: json['redis'] == null
          ? null
          : NetworkStatus.fromJson(json['redis'] as Map<String, dynamic>),
      rabbitmq: json['rabbitmq'] == null
          ? null
          : NetworkStatus.fromJson(json['rabbitmq'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkResultToJson(_NetworkResult instance) =>
    <String, dynamic>{
      'status': _$ServerHealthyStatusEnumMap[instance.status],
      'timestamp': instance.timestamp,
      'database': instance.database,
      'redis': instance.redis,
      'rabbitmq': instance.rabbitmq,
    };
