// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'networks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NetworksModelImpl _$$NetworksModelImplFromJson(Map<String, dynamic> json) =>
    _$NetworksModelImpl(
      networks: (json['networks'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$NetworksModelImplToJson(_$NetworksModelImpl instance) =>
    <String, dynamic>{
      'networks': instance.networks,
    };
