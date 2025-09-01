// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChainImpl _$$ChainImplFromJson(Map<String, dynamic> json) => _$ChainImpl(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      slug: json['slug'] as String,
      rpc: json['rpc'] as String,
      okxChainIndex: json['okx_chain_index'] as String,
      chainId: json['chain_id'] as String,
      logo: json['logo'] as String,
      chainType: json['chain_type'] as String,
      id: json['id'] as String,
      isActive: json['is_active'] as bool,
      mainToken: json['main_token'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$$ChainImplToJson(_$ChainImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'slug': instance.slug,
      'rpc': instance.rpc,
      'okx_chain_index': instance.okxChainIndex,
      'chain_id': instance.chainId,
      'logo': instance.logo,
      'chain_type': instance.chainType,
      'id': instance.id,
      'is_active': instance.isActive,
      'main_token': instance.mainToken,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
