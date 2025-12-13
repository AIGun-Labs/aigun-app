import '../../../data/models/token/query_token/query_token.dart';
import '../entities/base_token_entity.dart';

extension QueryTokenMapper on QueryToken {
  BaseTokenEntity toTokenEntity() {
    return BaseTokenEntity(
      chainId: networkId?.toString() ?? '',
      chainLogo: networkLogo ?? '',
      chainName: networkName ?? '',
      tokenLogo: logo ?? '',
      tokenName: name ?? '',
      price: priceUsd ?? '',
      symbol: symbol ?? '',
      network: network ?? '',
      address: address ?? '',
      rawBalance: rawBalance ?? '',
      balance: balance ?? '',
      decimals: decimals ?? 0,
      priceChange24h: priceChange24h ?? '',
      marketCap: marketCap ?? '0  ',
      isNative: isNative ?? false,
      liquidity: liquidity ?? '',
      volume24h: volume24h ?? '',
    );
  }
}
