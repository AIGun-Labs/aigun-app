import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/json_converter/multilingual.dart';
import '../../index.dart';

part 'token_state.freezed.dart';
part 'token_state.g.dart';

class FlexibleStringConverter implements JsonConverter<String?, dynamic> {
  const FlexibleStringConverter();

  @override
  String? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }

  @override
  dynamic toJson(String? value) => value;
}

class FlexibleDoubleConverter implements JsonConverter<double?, dynamic> {
  const FlexibleDoubleConverter();

  @override
  double? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      if (value.isEmpty) return null;
      return double.tryParse(value);
    }
    return null;
  }

  @override
  dynamic toJson(double? value) => value;
}

class FlexibleIntConverter implements JsonConverter<int?, dynamic> {
  const FlexibleIntConverter();

  @override
  int? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      if (value.isEmpty) return null;
      return int.tryParse(value);
    }
    return null;
  }

  @override
  dynamic toJson(int? value) => value;
}

@freezed
sealed class TokenDetailInfo with _$TokenDetailInfo {
  const factory TokenDetailInfo({
    @JsonKey(name: 'price_usd')
    @FlexibleDoubleConverter()
    @Default(0)
    double? priceUsd,
    @JsonKey(name: 'market_cap')
    @FlexibleDoubleConverter()
    @Default(0)
    double? marketCap,
    @JsonKey(name: 'liquidity')
    @FlexibleDoubleConverter()
    @Default(0)
    double? liquidity,
    @JsonKey(name: 'volume_24h')
    @FlexibleDoubleConverter()
    @Default(0)
    double? volume24h,
    @JsonKey(name: 'holders') @FlexibleIntConverter() @Default(0) int? holders,
    @JsonKey(name: 'highest_increase_rate')
    @FlexibleStringConverter()
    String? highestIncreaseRate,
    @MultilingualListConverter()
    @JsonKey(name: 'narrative')
    Multilingual? narrative,
    @JsonKey(name: 'is_native') @Default(false) bool? isNative,
    @JsonKey(name: 'price_change_24h')
    @FlexibleDoubleConverter()
    @Default(0)
    double? priceChange24h,
    @JsonKey(name: 'is_mainstream') @Default(false) bool? isMainStream,
  }) = _TokenDetailInfo;

  factory TokenDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailInfoFromJson(json);

  const TokenDetailInfo._();

  TokenDetailInfo excludePriceUsd(TokenDetailInfo? tokenDetailInfo) => copyWith(
    marketCap: tokenDetailInfo?.marketCap,
    liquidity: tokenDetailInfo?.liquidity,
    volume24h: tokenDetailInfo?.volume24h,
    holders: tokenDetailInfo?.holders,
    highestIncreaseRate: tokenDetailInfo?.highestIncreaseRate,
    narrative: tokenDetailInfo?.narrative,
    isNative: tokenDetailInfo?.isNative,
    priceChange24h: tokenDetailInfo?.priceChange24h,
    isMainStream: tokenDetailInfo?.isMainStream,
  );
}
