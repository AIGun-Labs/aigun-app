import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_state.freezed.dart';
part 'token_state.g.dart';

@freezed
class TokenDetailInfo with _$TokenDetailInfo {
  const factory TokenDetailInfo({
    @JsonKey(name: "price_usd") required double priceUsd,
    @JsonKey(name: "market_cap") required double marketCap,
    @JsonKey(name: "liquidity") required double liquidity,
    @JsonKey(name: "volume_24h") required double volume24h,
    @JsonKey(name: "holders") required double holders,
    @JsonKey(name: "highest_increase_rate") required double highestIncreaseRate,
    @JsonKey(name: "narrative") @Default("") String? narrative,
    @JsonKey(name: "is_native") required bool isNative,
    @JsonKey(name: "price_change_24h") required double highestPriceUsd,
  }) = _TokenDetailInfo;

  factory TokenDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailInfoFromJson(json);
}
