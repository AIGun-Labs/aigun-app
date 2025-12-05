// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenDetailInfo _$TokenDetailInfoFromJson(Map<String, dynamic> json) =>
    _TokenDetailInfo(
      priceUsd: json['price_usd'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['price_usd']),
      marketCap: json['market_cap'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['market_cap']),
      liquidity: json['liquidity'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['liquidity']),
      volume24h: json['volume_24h'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['volume_24h']),
      holders: json['holders'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['holders']),
      highestIncreaseRate: const FlexibleStringConverter().fromJson(
        json['highest_increase_rate'],
      ),
      narrative: json['narrative'] == null
          ? null
          : Multilingual.fromJson(json['narrative'] as Map<String, dynamic>),
      isNative: json['is_native'] as bool? ?? false,
      priceChange24h: json['price_change_24h'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['price_change_24h']),
      isMainStream: json['is_mainstream'] as bool? ?? false,
    );

Map<String, dynamic> _$TokenDetailInfoToJson(_TokenDetailInfo instance) =>
    <String, dynamic>{
      'price_usd': const FlexibleDoubleConverter().toJson(instance.priceUsd),
      'market_cap': const FlexibleDoubleConverter().toJson(instance.marketCap),
      'liquidity': const FlexibleDoubleConverter().toJson(instance.liquidity),
      'volume_24h': const FlexibleDoubleConverter().toJson(instance.volume24h),
      'holders': const FlexibleIntConverter().toJson(instance.holders),
      'highest_increase_rate': const FlexibleStringConverter().toJson(
        instance.highestIncreaseRate,
      ),
      'narrative': instance.narrative,
      'is_native': instance.isNative,
      'price_change_24h': const FlexibleDoubleConverter().toJson(
        instance.priceChange24h,
      ),
      'is_mainstream': instance.isMainStream,
    };
