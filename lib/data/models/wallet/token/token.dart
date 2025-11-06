import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
class Token with _$Token {
  const factory Token({
    @JsonKey(name: "chain_id") required String chainId,
    @JsonKey(name: "chain_name") required String chainName,
    @JsonKey(name: "chain_type") required String chainType,
    @JsonKey(name: "token_address") required String tokenAddress,
    @JsonKey(name: "symbol") required String symbol,
    @JsonKey(name: "balance") required String balance,
    @JsonKey(name: "token_price") required String tokenPrice,
    // @JsonKey(name: "is_risk_token") required bool isRiskToken,
    @JsonKey(name: "decimals") required int decimals,
    @JsonKey(name: "chain_logo") required String chainLogo,
    @JsonKey(name: "token_avatar") required String tokenAvatar,
    @JsonKey(name: "token_name") required String tokenName,
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "is_native") required bool isNative
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
