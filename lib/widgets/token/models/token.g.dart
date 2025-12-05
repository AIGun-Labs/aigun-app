// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Token _$TokenFromJson(Map<String, dynamic> json) => _Token(
  chainId: json['chain_id'] as String,
  chainLogo: json['chain_logo'] as String,
  chainName: json['chain_name'] as String,
  tokenAvatar: json['token_avatar'] as String,
  tokenName: json['token_name'] as String,
  address: json['address'] as String,
  tokenPrice: json['token_price'] as String,
  rawBalance: json['raw_balance'] as String,
  balance: json['balance'] as String,
  decimals: (json['decimals'] as num).toInt(),
  symbol: json['symbol'] as String,
  slug: _readSlugOrNetwork(json, 'slug') as String? ?? '',
  priceChange24h: (json['price_change_24h'] as num?)?.toDouble() ?? 0,
  marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0.0,
  network: _readNetworkOrSlug(json, 'network') as String? ?? '',
  isNative: json['is_native'] as bool,
);

Map<String, dynamic> _$TokenToJson(_Token instance) => <String, dynamic>{
  'chain_id': instance.chainId,
  'chain_logo': instance.chainLogo,
  'chain_name': instance.chainName,
  'token_avatar': instance.tokenAvatar,
  'token_name': instance.tokenName,
  'address': instance.address,
  'token_price': instance.tokenPrice,
  'raw_balance': instance.rawBalance,
  'balance': instance.balance,
  'decimals': instance.decimals,
  'symbol': instance.symbol,
  'slug': instance.slug,
  'price_change_24h': instance.priceChange24h,
  'market_cap': instance.marketCap,
  'network': instance.network,
  'is_native': instance.isNative,
};
