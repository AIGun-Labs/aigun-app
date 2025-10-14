// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryTokenImpl _$$QueryTokenImplFromJson(Map<String, dynamic> json) =>
    _$QueryTokenImpl(
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      address: json['address'] as String?,
      network: json['network'] as String?,
      isInternal: json['is_internal'] as bool?,
      logo: json['logo'] as String?,
      marketCap: json['market_cap'] as String?,
      priceUsd: json['price_usd'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      chainLogo: json['chain_logo'] as String?,
      volume24h: json['volume_24h'] as String?,
      liquidity: json['liquidity'] as String?,
      priceChange24h: json['price_change_24h'] as String?,
      isNative: json['is_native'] as bool?,
      isMainstream: json['is_mainstream'] as bool?,
      balance: json['balance'] as String?,
      rawBalance: json['raw_balance'] as String?,
      balanceUsd: (json['balance_usd'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$QueryTokenImplToJson(_$QueryTokenImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'address': instance.address,
      'network': instance.network,
      'is_internal': instance.isInternal,
      'logo': instance.logo,
      'market_cap': instance.marketCap,
      'price_usd': instance.priceUsd,
      'decimals': instance.decimals,
      'chain_logo': instance.chainLogo,
      'volume_24h': instance.volume24h,
      'liquidity': instance.liquidity,
      'price_change_24h': instance.priceChange24h,
      'is_native': instance.isNative,
      'is_mainstream': instance.isMainstream,
      'balance': instance.balance,
      'raw_balance': instance.rawBalance,
      'balance_usd': instance.balanceUsd,
    };
