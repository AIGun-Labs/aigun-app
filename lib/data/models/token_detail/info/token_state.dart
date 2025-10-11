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
    @JsonKey(name: "price_usd") required double priceUsd,
    @JsonKey(name: "market_cap") required double marketCap,
    @JsonKey(name: "liquidity") required double liquidity,
    @JsonKey(name: "volume_24h") required double volume24h,
    @JsonKey(name: "holders") required double holders,
    @JsonKey(name: "highest_increase_rate")
    @FlexibleStringConverter()
    String? highestIncreaseRate,
    @JsonKey(name: "narrative") @Default("") String? narrative,
    @JsonKey(name: "is_native") required bool isNative,
    @JsonKey(name: "price_change_24h") required double priceChange24h,
  }) = _TokenDetailInfo;

  factory TokenDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailInfoFromJson(json);
}
