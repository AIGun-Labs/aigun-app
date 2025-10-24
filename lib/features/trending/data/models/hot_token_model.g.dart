// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HotTokenModelImpl _$$HotTokenModelImplFromJson(Map<String, dynamic> json) =>
    _$HotTokenModelImpl(
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      logoURL: json['logoURL'] as String? ?? '',
      marketCap: json['marketCap'] as String? ?? '',
      decimals: json['decimals'] as String? ?? '',
      price: json['price'] as String? ?? '',
      chainIndex: json['chainIndex'] as String? ?? '',
      contractAddress: json['contractAddress'] as String? ?? '',
      chainId: json['chainId'] as String? ?? '',
      chainName: json['chainName'] as String? ?? '',
      chainLogoURL: json['chainLogoURL'] as String? ?? '',
      network: json['network'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );

Map<String, dynamic> _$$HotTokenModelImplToJson(_$HotTokenModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'logoURL': instance.logoURL,
      'marketCap': instance.marketCap,
      'decimals': instance.decimals,
      'price': instance.price,
      'chainIndex': instance.chainIndex,
      'contractAddress': instance.contractAddress,
      'chainId': instance.chainId,
      'chainName': instance.chainName,
      'chainLogoURL': instance.chainLogoURL,
      'network': instance.network,
      'slug': instance.slug,
    };

_$HotTokensModelImpl _$$HotTokensModelImplFromJson(Map<String, dynamic> json) =>
    _$HotTokensModelImpl(
      tokens: (json['tokens'] as List<dynamic>?)
              ?.map((e) => HotTokenModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HotTokensModelImplToJson(
        _$HotTokensModelImpl instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
    };
