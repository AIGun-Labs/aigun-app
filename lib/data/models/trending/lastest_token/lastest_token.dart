import 'package:freezed_annotation/freezed_annotation.dart';

part 'lastest_token.freezed.dart';
part 'lastest_token.g.dart';

@freezed
class LatestToken with _$LatestToken {
  const factory LatestToken({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'chain_id') String? chainId,
    @JsonKey(name: 'network') String? network,
    @JsonKey(name: 'contract_address') String? contractAddress,
    @JsonKey(name: 'decimals') int? decimals,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'type', defaultValue: '') String? type,
    @JsonKey(name: 'volume_24h', defaultValue: 0) double? volume24h,
    @JsonKey(name: 'market_cap', defaultValue: 0) double? marketCap,
    @JsonKey(name: 'price_usd', defaultValue: 0) double? priceUsd,
    @JsonKey(name: 'is_verified', defaultValue: false) bool? isVerified,
    @JsonKey(name: 'description', defaultValue: '') String? description,
    @JsonKey(name: 'price_change_24h', defaultValue: 0) double? priceChange24h,
    @JsonKey(name: 'standard', defaultValue: '') String? standard,
    @JsonKey(name: 'liquidity', defaultValue: 0) double? liquidity,
    @JsonKey(name: 'display_time', defaultValue: '') String? displayTime,
  }) = _LatestToken;

  factory LatestToken.fromJson(Map<String, dynamic> json) =>
      _$LatestTokenFromJson(json);
}
