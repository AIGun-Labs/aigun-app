import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token.freezed.dart';
part 'favorite_token.g.dart';

@freezed
class FavoriteToken with _$FavoriteToken {
  const factory FavoriteToken({
    @JsonKey(name: "network") @Default("") String? network,
    @JsonKey(name: "contract_address") @Default("") String? contractAddress,
    @JsonKey(name: "token_logo") @Default("") String? tokenAvatar,
    @JsonKey(name: "price_change_24h") @Default(0) double? priceChange24h,
    @JsonKey(name: "price_usd") @Default(0) double? priceUsd,
    @JsonKey(name: "chain_logo") @Default("") String? chainLogo,
    @JsonKey(name: "chain_name") @Default("") String? chainName,
    @JsonKey(name: "token_name") @Default("") String? tokenName,
    @JsonKey(name: "balance") @Default("") String? balance,
    @JsonKey(name: "raw_balance") @Default("") String? rawBalance,
    @JsonKey(name: "balance_usd") @Default(0) double? balanceUsd,
    @JsonKey(name: "chain_id") @Default("") String? chainId,
    @JsonKey(name: "symbol") @Default("") String? symbol,
    @JsonKey(name: "market_cap") @Default(0.0) double? marketCap,
  }) = _FavoriteToken;

  factory FavoriteToken.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTokenFromJson(json);

  factory FavoriteToken.fromCommonToken(Token token) {
    return FavoriteToken(
      network: token.network,
      contractAddress: token.address,
      tokenAvatar: token.tokenAvatar,
      priceChange24h: token.priceChange24h,
      priceUsd: double.tryParse(token.tokenPrice) ?? 0,
      chainLogo: token.chainLogo,
      chainName: token.chainName,
      tokenName: token.tokenName,
      balance: token.balance,
      rawBalance: token.rawBalance,
      balanceUsd: double.tryParse(token.balance) ?? 0,
      chainId: token.chainId.toString(),
      symbol: token.symbol,
      marketCap: token.marketCap,
    );
  }
}
