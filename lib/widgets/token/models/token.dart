import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart'
    as BalanceTokenModel;

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
class Token with _$Token {
  const factory Token({
    @JsonKey(name: "chain_id") required int chainId,
    // @JsonKey(name: "chain_name") String chainName,
    @JsonKey(name: "chain_logo") required String chainLogo,
    @JsonKey(name: "chain_name") required String chainName,
    @JsonKey(name: "token_avatar") required String tokenAvatar,
    @JsonKey(name: "token_name") required String tokenName,
    @JsonKey(name: "address") required String address,
    @JsonKey(name: "token_price") required String tokenPrice,
    @JsonKey(name: "raw_balance") required String rawBalance,
    @JsonKey(name: "balance") required String balance,
    @JsonKey(name: "decimals") required int decimals,
    @JsonKey(name: "symbol") required String symbol,
    // @JsonKey(name: "amount") required String amount,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

// 将 Entity 转换为 token
  factory Token.fromEntity(Entity entity) {
    try {
      final chainId = int.parse(entity.chain?.networkId ?? "0");

      final token = Token(
          chainId: chainId,
          chainLogo: entity.chain?.logo ?? "",
          chainName: entity.chain?.name ?? "",
          tokenAvatar: entity.logo ?? "",
          tokenName: entity.name ?? "",
          address: entity.contractAddress ?? "",
          tokenPrice: "",
          rawBalance: "",
          balance: "",
          decimals: entity.decimals ?? 0,
          symbol: entity.symbol ?? "");
      return token;
    } catch (e) {
      Logger.error("Error parsing token: $e");
      print("Token.fromEntity 转换失败: $e");
      return Token(
          chainId: 0,
          chainLogo: "",
          chainName: "",
          tokenAvatar: "",
          tokenName: "",
          address: "",
          tokenPrice: "",
          rawBalance: "",
          balance: "",
          decimals: 0,
          symbol: "");
    }
  }

  factory Token.fromBalance(BalanceTokenModel.Token balance) {
    return Token(
      chainId: balance.chainId,
      chainLogo: balance.chainLogo,
      chainName: balance.chainName,
      tokenAvatar: "",
      tokenName: balance.symbol,
      address: balance.tokenAddress,
      tokenPrice: "",
      rawBalance: balance.balance,
      balance: balance.balance,
      decimals: balance.decimals,
      symbol: balance.symbol,
    );
  }
}
