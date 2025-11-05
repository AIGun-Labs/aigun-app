import 'package:flutter_aigun/data/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

@freezed
class TokenDetailInfo with _$TokenDetailInfo {
  const factory TokenDetailInfo({
    @JsonKey(name: "price_usd") double? priceUsd,
    @JsonKey(name: "market_cap") double? marketCap,
    @JsonKey(name: "liquidity") double? liquidity,
    @JsonKey(name: "volume_24h") double? volume24h,
    @JsonKey(name: "holders") int? holders,
    @JsonKey(name: "highest_increase_rate")
    @FlexibleStringConverter()
    String? highestIncreaseRate,
    @JsonKey(name: "narrative") Multilingual? narrative,
    @JsonKey(name: "is_native", defaultValue: false) bool? isNative,
    @JsonKey(name: "price_change_24h") double? priceChange24h,
    @JsonKey(name: "is_mainstream", defaultValue: false) bool? isMainStream,
  }) = _TokenDetailInfo;

  factory TokenDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailInfoFromJson(json);
}
