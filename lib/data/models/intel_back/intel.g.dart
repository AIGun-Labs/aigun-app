// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntelMessageDataImpl _$$IntelMessageDataImplFromJson(
        Map<String, dynamic> json) =>
    _$IntelMessageDataImpl(
      type: json['type'] as String?,
      data: json['data'] == null
          ? null
          : IntelGroup.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IntelMessageDataImplToJson(
        _$IntelMessageDataImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

_$IntelGroupImpl _$$IntelGroupImplFromJson(Map<String, dynamic> json) =>
    _$IntelGroupImpl(
      groupId: json['group_id'] as String?,
      groupName: json['group_name'] as String?,
      message: json['message'] == null
          ? null
          : IntelMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IntelGroupImplToJson(_$IntelGroupImpl instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'group_name': instance.groupName,
      'message': instance.message,
    };

_$HistoryDataImpl _$$HistoryDataImplFromJson(Map<String, dynamic> json) =>
    _$HistoryDataImpl(
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => IntelMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastCreateAt: (json['last_create_at'] as num?)?.toInt(),
      lastId: json['last_id'] as String?,
    );

Map<String, dynamic> _$$HistoryDataImplToJson(_$HistoryDataImpl instance) =>
    <String, dynamic>{
      'records': instance.records,
      'last_create_at': instance.lastCreateAt,
      'last_id': instance.lastId,
    };

_$IntelMessageImpl _$$IntelMessageImplFromJson(Map<String, dynamic> json) =>
    _$IntelMessageImpl(
      type: json['type'] as String?,
      name: json['name'] as String?,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      createdAt: (json['create_at'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      origin: json['origin'] as String?,
      analyze: json['analyze'] as String?,
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => IntelEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : IntelUser.fromJson(json['user'] as Map<String, dynamic>),
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => IntelMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$IntelMessageImplToJson(_$IntelMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'timestamp': instance.timestamp,
      'create_at': instance.createdAt,
      'title': instance.title,
      'content': instance.content,
      'origin': instance.origin,
      'analyze': instance.analyze,
      'entities': instance.entities,
      'user': instance.user,
      'medias': instance.medias,
    };

_$IntelMediaImpl _$$IntelMediaImplFromJson(Map<String, dynamic> json) =>
    _$IntelMediaImpl(
      type: json['type'] as String?,
      url: json['url'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$IntelMediaImplToJson(_$IntelMediaImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'data': instance.data,
    };

_$IntelEntityImpl _$$IntelEntityImplFromJson(Map<String, dynamic> json) =>
    _$IntelEntityImpl(
      type: json['type'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      network: json['network'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$IntelEntityImplToJson(_$IntelEntityImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'symbol': instance.symbol,
      'network': instance.network,
      'address': instance.address,
    };

_$IntelUserImpl _$$IntelUserImplFromJson(Map<String, dynamic> json) =>
    _$IntelUserImpl(
      name: json['name'] as String?,
      avator: json['avator'] as String?,
      userId: json['user_id'] as String?,
      screenName: json['screen_name'] as String?,
    );

Map<String, dynamic> _$$IntelUserImplToJson(_$IntelUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avator': instance.avator,
      'user_id': instance.userId,
      'screen_name': instance.screenName,
    };
