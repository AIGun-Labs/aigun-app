import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_token.freezed.dart';
part 'query_token.g.dart';

@freezed
sealed class QueryToken with _$QueryToken {
  const factory QueryToken({
    String? name,
    String? symbol,
    String? address,
    String? network,
    @JsonKey(name: 'network_id') int? networkId,
    @JsonKey(name: 'network_name') String? networkName,
    @JsonKey(name: 'is_internal') @Default(false) bool? isInternal,
    String? logo,
    @JsonKey(name: 'market_cap') String? marketCap,
    @JsonKey(name: 'price_usd') String? priceUsd,
    int? decimals,
    @JsonKey(name: 'network_logo') String? networkLogo,
    @JsonKey(name: 'volume_24h') String? volume24h,
    String? liquidity,
    @JsonKey(name: 'price_change_24h') String? priceChange24h,
    @JsonKey(name: 'is_native') @Default(false) bool? isNative,
    @JsonKey(name: 'is_mainstream') bool? isMainstream,
    String? balance,
    @JsonKey(name: 'raw_balance') String? rawBalance,
    @JsonKey(name: 'balance_usd') double? balanceUsd,
  }) = _QueryToken;

  factory QueryToken.fromJson(Map<String, dynamic> json) =>
      _$QueryTokenFromJson(json);
}
