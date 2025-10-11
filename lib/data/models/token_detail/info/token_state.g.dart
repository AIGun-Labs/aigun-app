// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenDetailInfoImpl _$$TokenDetailInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenDetailInfoImpl(
      priceUsd: (json['price_usd'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
      liquidity: (json['liquidity'] as num).toDouble(),
      volume24h: (json['volume_24h'] as num).toDouble(),
      holders: (json['holders'] as num).toDouble(),
      highestIncreaseRate: json['highest_increase_rate'] as String?,
      narrative: json['narrative'] as String? ?? "",
      isNative: json['is_native'] as bool,
      priceChange24h: (json['price_change_24h'] as num).toDouble(),
    );

Map<String, dynamic> _$$TokenDetailInfoImplToJson(
        _$TokenDetailInfoImpl instance) =>
    <String, dynamic>{
      'price_usd': instance.priceUsd,
      'market_cap': instance.marketCap,
      'liquidity': instance.liquidity,
      'volume_24h': instance.volume24h,
      'holders': instance.holders,
      'highest_increase_rate': instance.highestIncreaseRate,
      'narrative': instance.narrative,
      'is_native': instance.isNative,
      'price_change_24h': instance.priceChange24h,
    };
