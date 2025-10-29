// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChainImpl _$$ChainImplFromJson(Map<String, dynamic> json) => _$ChainImpl(
      chainId: json['chain_id'] as String,
      chainType: json['chain_type'] as String,
      chainName: json['chain_name'] as String,
      logoUrl: json['logo_url'] as String,
      explorer: json['explorer'] as String,
    );

Map<String, dynamic> _$$ChainImplToJson(_$ChainImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_type': instance.chainType,
      'chain_name': instance.chainName,
      'logo_url': instance.logoUrl,
      'explorer': instance.explorer,
    };
