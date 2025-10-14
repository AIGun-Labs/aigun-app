// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteTokenImpl _$$FavoriteTokenImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteTokenImpl(
      network: json['network'] as String? ?? "",
      contractAddress: json['contract_address'] as String? ?? "",
      tokenAvatar: json['token_logo'] as String? ?? "",
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble() ?? 0,
      priceUsd: (json['price_usd'] as num?)?.toDouble() ?? 0,
      chainLogo: json['chain_logo'] as String? ?? "",
      chainName: json['chain_name'] as String? ?? "",
      tokenName: json['token_name'] as String? ?? "",
      balance: json['balance'] as String? ?? "",
      rawBalance: json['raw_balance'] as String? ?? "",
      balanceUsd: (json['balance_usd'] as num?)?.toDouble() ?? 0,
      chainSlug: json['chain_slug'] as String? ?? "",
      symbol: json['symbol'] as String? ?? "",
      marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0.0,
      isTop: json['is_top'] as bool? ?? false,
    );

Map<String, dynamic> _$$FavoriteTokenImplToJson(_$FavoriteTokenImpl instance) =>
    <String, dynamic>{
      'network': instance.network,
      'contract_address': instance.contractAddress,
      'token_logo': instance.tokenAvatar,
      'price_change_24h': instance.priceChange24h,
      'price_usd': instance.priceUsd,
      'chain_logo': instance.chainLogo,
      'chain_name': instance.chainName,
      'token_name': instance.tokenName,
      'balance': instance.balance,
      'raw_balance': instance.rawBalance,
      'balance_usd': instance.balanceUsd,
      'chain_slug': instance.chainSlug,
      'symbol': instance.symbol,
      'market_cap': instance.marketCap,
      'is_top': instance.isTop,
    };
