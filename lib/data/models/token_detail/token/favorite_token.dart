import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token.freezed.dart';
part 'favorite_token.g.dart';

@freezed
sealed class FavoriteToken with _$FavoriteToken {
  const factory FavoriteToken({
    @JsonKey(name: 'network') @Default('') String network,
    @JsonKey(name: 'contract_address') @Default('') String contractAddress,
    @JsonKey(name: 'token_logo') @Default('') String tokenAvatar,
    @JsonKey(name: 'price_change_24h') @Default('') String priceChange24h,
    @JsonKey(name: 'price_usd') @Default('') String priceUsd,
    @JsonKey(name: 'chain_logo') @Default('') String chainLogo,
    @JsonKey(name: 'chain_name') @Default('') String chainName,
    @JsonKey(name: 'token_name') @Default('') String tokenName,
    @JsonKey(name: 'balance') @Default('') String balance,
    @JsonKey(name: 'raw_balance') @Default('') String rawBalance,
    @JsonKey(name: 'balance_usd') @Default('') String balanceUsd,
    @JsonKey(name: 'chain_slug') @Default('') String chainSlug,
    @JsonKey(name: 'symbol') @Default('') String symbol,
    @JsonKey(name: 'market_cap') @Default('') String marketCap,
    @JsonKey(name: 'is_top') @Default(false) bool isTop,
  }) = _FavoriteToken;

  factory FavoriteToken.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTokenFromJson(json);
}
