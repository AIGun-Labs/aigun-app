import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/token/query_token/query_token.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart'
    as balance_token_model;
import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart'
    as lastest_token_model;
import 'package:flutter_aigun/data/models/wallet/token/token.dart'
    as wallet_token;

import '../../../features/trending/domain/entities/hot_token_entity.dart';

part 'token.freezed.dart';
part 'token.g.dart';

// Static helper functions for JSON deserialization
Object? _readSlugOrNetwork(Map json, String key) {
  return json['slug'] ?? json['network'] ?? '';
}

Object? _readNetworkOrSlug(Map json, String key) {
  return json['network'] ?? json['slug'] ?? '';
}

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
    @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)
    @Default("")
    String? slug,
    @JsonKey(name: "price_change_24h") @Default(0) double? priceChange24h,
    @JsonKey(name: "market_cap") @Default(0.0) double? marketCap,
    @JsonKey(name: "network", readValue: _readNetworkOrSlug)
    @Default("")
    String? network,
    // @JsonKey(name: "amount") required String amount,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  factory Token.fromTradeToken(TradeToken tradeToken) {
    return Token(
        chainId: tradeToken.chainId,
        chainLogo: tradeToken.chainLogo,
        chainName: tradeToken.chainName,
        tokenAvatar: tradeToken.tokenAvatar,
        tokenName: tradeToken.tokenName,
        address: tradeToken.address,
        tokenPrice: tradeToken.tokenPrice.toString(),
        rawBalance: tradeToken.balance ?? "",
        balance: tradeToken.balance ?? "",
        decimals: tradeToken.decimals,
        symbol: tradeToken.symbol,
        slug: tradeToken.network,
        network: tradeToken.network);
  }
  factory Token.fromQueryToken(QueryToken queryToken) {
    return Token(
        chainId: queryToken.networkId ?? 0,
        chainLogo: queryToken.networkLogo ?? "",
        chainName: queryToken.networkName ?? "",
        tokenAvatar: queryToken.logo ?? "",
        tokenName: queryToken.name ?? "",
        address: queryToken.address ?? "",
        tokenPrice: queryToken.priceUsd ?? "",
        rawBalance: queryToken.rawBalance ?? "",
        balance: queryToken.balance ?? "",
        decimals: queryToken.decimals ?? 0,
        symbol: queryToken.symbol ?? "");
  }

  factory Token.fromWalletToken(wallet_token.Token token) {
    return Token(
        chainId: token.chainId,
        chainLogo: token.chainLogo,
        chainName: token.chainName,
        tokenAvatar: token.tokenAvatar,
        tokenName: token.tokenName,
        address: token.tokenAddress,
        tokenPrice: token.tokenPrice.toString(),
        rawBalance: token.balance,
        balance: token.balance,
        decimals: token.decimals,
        symbol: token.symbol,
        slug: token.slug,
        network: token.slug);
  }
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
          network: entity.chain?.slug ?? "",
          decimals: entity.decimals ?? 0,
          slug: entity.chain?.slug ?? "",
          symbol: entity.symbol ?? "");
      return token;
    } catch (e) {
      Logger.error("Token.fromEntity 转换失败: $e");
      return const Token(
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

  factory Token.fromBalance(balance_token_model.Token balance) {
    return Token(
      chainId: balance.chainId,
      chainLogo: balance.chainLogo,
      chainName: balance.chainName,
      tokenAvatar: balance.tokenAvatar,
      tokenName: balance.tokenName,
      address: balance.tokenAddress,
      tokenPrice: balance.tokenPrice,
      rawBalance: balance.balance,
      balance: balance.balance,
      decimals: balance.decimals,
      symbol: balance.symbol,
    );
  }

  factory Token.fromLastestToken(lastest_token_model.LatestToken lastestToken) {
    return Token(
      chainId: lastestToken.chainId?.toInt() ?? 0,
      chainLogo: lastestToken.logo ?? "",
      chainName: lastestToken.network ?? "",
      tokenAvatar: lastestToken.logo ?? "",
      tokenName: lastestToken.name ?? "",
      address: lastestToken.contractAddress ?? "",
      tokenPrice: lastestToken.priceUsd?.toString() ?? "",
      rawBalance: lastestToken.liquidity?.toString() ?? "",
      balance: lastestToken.liquidity?.toString() ?? "",
      decimals: lastestToken.decimals ?? 0,
      symbol: lastestToken.symbol ?? "",
      priceChange24h: lastestToken.priceChange24h ?? 0,
      marketCap: lastestToken.marketCap ?? 0.0,
      network: lastestToken.network ?? "",
    );
  }

  factory Token.fromFavoriteToken(FavoriteToken favoriteToken) {
    return Token(
      chainId: 0,
      chainLogo: favoriteToken.chainLogo ?? "",
      chainName: favoriteToken.chainName ?? "",
      tokenAvatar: favoriteToken.tokenAvatar ?? "",
      tokenName: favoriteToken.tokenName ?? "",
      address: favoriteToken.contractAddress ?? "",
      tokenPrice: favoriteToken.priceUsd?.toString() ?? "",
      rawBalance: favoriteToken.rawBalance ?? "",
      balance: favoriteToken.balance ?? "",
      decimals: 0,
      slug: favoriteToken.network,
      symbol: favoriteToken.symbol ?? "",
      priceChange24h: favoriteToken.priceChange24h ?? 0,
      marketCap: favoriteToken.marketCap ?? 0.0,
      network: favoriteToken.network ?? "",
    );
  }

  factory Token.fromHotTokenEntity(HotTokenEntity hotTokenEntity) {
    return Token(
      chainId: int.tryParse(hotTokenEntity.chainIndex) ?? 0,
      chainLogo: hotTokenEntity.chainLogo,
      chainName: hotTokenEntity.chainName,
      tokenAvatar: hotTokenEntity.logo,
      tokenName: hotTokenEntity.name,
      address: hotTokenEntity.contractAddress,
      tokenPrice: hotTokenEntity.price,
      rawBalance: '',
      balance: '',
      decimals: int.parse(hotTokenEntity.decimals),
      symbol: hotTokenEntity.symbol,
      network: hotTokenEntity.network,
      slug: hotTokenEntity.slug,
    );
  }
  // factory Token.fromQueryToken(QueryToken queryToken ) {
  //   return Token(chainId: queryToken.chainId, chainLogo: chainLogo, chainName: chainName, tokenAvatar: tokenAvatar, tokenName: tokenName, address: address, tokenPrice: tokenPrice, rawBalance: rawBalance, balance: balance, decimals: decimals, symbol: symbol)
  // }
}
