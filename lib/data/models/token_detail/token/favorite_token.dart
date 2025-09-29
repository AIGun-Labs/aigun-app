import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token.freezed.dart';
part 'favorite_token.g.dart';

@freezed
class FavoriteToken with _$FavoriteToken {
  const factory FavoriteToken({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "contract_address") required String contractAddress,
    @JsonKey(name: "token_logo") required String tokenAvatar,
    @JsonKey(name: "price_change_24h") required String priceChange24h,
    @JsonKey(name: "price_usd") required String priceUsd,
    @JsonKey(name: "chain_logo") required String chainLogo,
    @JsonKey(name: "chain_lname") required String chainName,
    @JsonKey(name: "token_name") required String tokenName,
    @JsonKey(name: "balance") required String balance,
    @JsonKey(name: "raw_balance") required String rawBalance,
    @JsonKey(name: "balance_usd") required double balanceUsd,
    @JsonKey(name: "chain_id") required String chainId,
    @JsonKey(name: "symbol") required String symbol,
  }) = _FavoriteToken;

  factory FavoriteToken.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTokenFromJson(json);

  factory FavoriteToken.fromCommonToken(Token token) {
    return FavoriteToken(
        network: token.chainName,
        contractAddress: token.address,
        tokenAvatar: token.tokenAvatar,
        priceChange24h: token.tokenPrice,
        priceUsd: token.tokenPrice,
        chainLogo: token.chainLogo,
        chainName: token.chainName,
        tokenName: token.tokenName,
        balance: token.balance,
        rawBalance: token.rawBalance,
        balanceUsd: double.parse(token.balance),
        chainId: token.chainId.toString(),
        symbol: token.symbol);
  }
}
