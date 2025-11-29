import 'package:freezed_annotation/freezed_annotation.dart';

part 'lastest_token.freezed.dart';
part 'lastest_token.g.dart';

@Deprecated('将废弃，请使用 TopTokenEntity 代替')
@freezed
sealed class LatestToken with _$LatestToken {
  const factory LatestToken({
    required String id,
    @JsonKey(name: 'chain_id', defaultValue: '') required String chainId,
    @JsonKey(name: 'network', defaultValue: '') required String network,
    @JsonKey(name: 'contract_address', defaultValue: '')
    required String contractAddress,
    @JsonKey(name: 'decimals', defaultValue: 0) required int decimals,
    @JsonKey(name: 'name', defaultValue: '') required String name,
    @JsonKey(name: 'symbol', defaultValue: '') required String symbol,
    @JsonKey(name: 'logo', defaultValue: '') required String logo,
    @JsonKey(name: 'type', defaultValue: '') required String type,
    @JsonKey(name: 'volume_24h', defaultValue: 0.0) required double volume24h,
    @JsonKey(name: 'market_cap', defaultValue: 0.0) required double marketCap,
    @JsonKey(name: 'price_usd', defaultValue: 0.0) required double priceUsd,
    @JsonKey(name: 'is_verified', defaultValue: false) required bool isVerified,
    @JsonKey(name: 'description', defaultValue: '') required String description,
    @JsonKey(name: 'price_change_24h', defaultValue: 0.0)
    required double priceChange24h,
    @JsonKey(name: 'standard', defaultValue: '') required String standard,
    @JsonKey(name: 'liquidity', defaultValue: 0.0) required double liquidity,
    @JsonKey(name: 'display_time', defaultValue: '')
    required String displayTime,
  }) = _LatestToken;

  factory LatestToken.fromJson(Map<String, dynamic> json) =>
      _$LatestTokenFromJson(json);
}
