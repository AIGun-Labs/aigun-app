import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_state.freezed.dart';

@freezed
class TokenDetailInfo with _$TokenDetailInfo {
  const factory TokenDetailInfo({
    @JsonKey(name: "price_usd") required String priceUsd,
    @JsonKey(name: "market_cap") required String symbol,
    @JsonKey(name: "liquidity") required String liquidity,
    @JsonKey(name: "volume_24h") required String volume24h,
    @JsonKey(name: "holders") required String holders,
    @JsonKey(name: "highest_price_usd") required String highestPriceUsd,
  }) = _TokenDetailInfo;

  factory TokenDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailInfoFromJson(json);
}
