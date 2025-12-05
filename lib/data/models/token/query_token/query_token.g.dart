// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryToken _$QueryTokenFromJson(Map<String, dynamic> json) => _QueryToken(
  name: json['name'] as String?,
  symbol: json['symbol'] as String?,
  address: json['address'] as String?,
  network: json['network'] as String?,
  networkId: (json['network_id'] as num?)?.toInt(),
  networkName: json['network_name'] as String?,
  isInternal: json['is_internal'] as bool? ?? false,
  logo: json['logo'] as String?,
  marketCap: json['market_cap'] as String?,
  priceUsd: json['price_usd'] as String?,
  decimals: (json['decimals'] as num?)?.toInt(),
  networkLogo: json['network_logo'] as String?,
  volume24h: json['volume_24h'] as String?,
  liquidity: json['liquidity'] as String?,
  priceChange24h: json['price_change_24h'] as String?,
  isNative: json['is_native'] as bool? ?? false,
  isMainstream: json['is_mainstream'] as bool?,
  balance: json['balance'] as String?,
  rawBalance: json['raw_balance'] as String?,
  balanceUsd: (json['balance_usd'] as num?)?.toDouble(),
);

Map<String, dynamic> _$QueryTokenToJson(_QueryToken instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'address': instance.address,
      'network': instance.network,
      'network_id': instance.networkId,
      'network_name': instance.networkName,
      'is_internal': instance.isInternal,
      'logo': instance.logo,
      'market_cap': instance.marketCap,
      'price_usd': instance.priceUsd,
      'decimals': instance.decimals,
      'network_logo': instance.networkLogo,
      'volume_24h': instance.volume24h,
      'liquidity': instance.liquidity,
      'price_change_24h': instance.priceChange24h,
      'is_native': instance.isNative,
      'is_mainstream': instance.isMainstream,
      'balance': instance.balance,
      'raw_balance': instance.rawBalance,
      'balance_usd': instance.balanceUsd,
    };
