// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lastest_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LastestTokenImpl _$$LastestTokenImplFromJson(Map<String, dynamic> json) =>
    _$LastestTokenImpl(
      id: json['id'] as String?,
      chainId: json['chain_id'] as String?,
      network: json['network'] as String?,
      contractAddress: json['contract_address'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      logo: json['logo'] as String?,
      type: json['type'] as String? ?? '',
      volume24h: (json['volume_24h'] as num?)?.toDouble() ?? 0,
      marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0,
      priceUsd: (json['price_usd'] as num?)?.toDouble() ?? 0,
      isVerified: json['is_verified'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble() ?? 0,
      standard: json['standard'] as String? ?? '',
      liquidity: (json['liquidity'] as num?)?.toDouble() ?? 0,
      displayTime: json['display_time'] as String? ?? '',
    );

Map<String, dynamic> _$$LastestTokenImplToJson(_$LastestTokenImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chain_id': instance.chainId,
      'network': instance.network,
      'contract_address': instance.contractAddress,
      'decimals': instance.decimals,
      'name': instance.name,
      'symbol': instance.symbol,
      'logo': instance.logo,
      'type': instance.type,
      'volume_24h': instance.volume24h,
      'market_cap': instance.marketCap,
      'price_usd': instance.priceUsd,
      'is_verified': instance.isVerified,
      'description': instance.description,
      'price_change_24h': instance.priceChange24h,
      'standard': instance.standard,
      'liquidity': instance.liquidity,
      'display_time': instance.displayTime,
    };
