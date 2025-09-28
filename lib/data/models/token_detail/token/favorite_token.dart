import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token.freezed.dart';
part 'favorite_token.g.dart';

@freezed
class FavoriteToken with _$FavoriteToken {
  const factory FavoriteToken({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "contract_address") required String contractAddress,
    @JsonKey(name: "logo") required String logo,
    @JsonKey(name: "price_change_24h") required String priceChange24h,
    @JsonKey(name: "price_usd") required String priceUsd,
    @JsonKey(name: "chain_logo") required String chainLogo,
    @JsonKey(name: "balance") required String balance,
    @JsonKey(name: "raw_balance") required String rawBalance,
    @JsonKey(name: "balance_usd") required double balanceUsd,
  }) = _FavoriteToken;

  factory FavoriteToken.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTokenFromJson(json);
}
