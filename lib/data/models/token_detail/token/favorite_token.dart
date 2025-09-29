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
    @JsonKey(name: "price_change_24h") @Default(0) int? priceChange24h,
    @JsonKey(name: "price_usd") @Default(0) int? priceUsd,
    @JsonKey(name: "chain_logo") @Default("") String? chainLogo,
    @JsonKey(name: "chain_name") @Default("") String? chainName,
    @JsonKey(name: "token_name") @Default("") String? tokenName,
    @JsonKey(name: "balance") @Default("") String? balance,
    @JsonKey(name: "raw_balance") @Default("") String? rawBalance,
    @JsonKey(name: "balance_usd") @Default(0) int? balanceUsd,
    @JsonKey(name: "chain_id") @Default("") String? chainId,
    @JsonKey(name: "symbol") @Default("") String? symbol,
  }) = _FavoriteToken;

  factory FavoriteToken.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTokenFromJson(json);

  factory FavoriteToken.fromCommonToken(Token token) {
    return FavoriteToken(
        network: token.chainName,
        contractAddress: token.address,
        tokenAvatar: token.tokenAvatar,
        priceChange24h: int.parse(token.tokenPrice),
        priceUsd: int.parse(token.tokenPrice),
        chainLogo: token.chainLogo,
        chainName: token.chainName,
        tokenName: token.tokenName,
        balance: token.balance,
        rawBalance: token.rawBalance,
        balanceUsd: int.parse(token.balance),
        chainId: token.chainId.toString(),
        symbol: token.symbol);
  }
}
