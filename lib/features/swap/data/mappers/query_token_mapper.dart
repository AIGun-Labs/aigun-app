import '../../../../shared/domain/entities/token_entity.dart';
import '../../domain/entities/query_token_entity.dart';

extension QueryTokenMapper on QueryTokenEntity {
  TokenEntity toTokenEntity() {
    return TokenEntity(
      chainId: '',
      chainName: networkName,
      chainLogo: networkLogo,
      tokenName: name,
      symbol: symbol,
      address: address,
      network: network,
      tokenLogo: logo,
      decimals: decimals,
      isNative: isNative,
      marketCap: marketCap ?? '',
      tokenPrice: priceUsd ?? '',
      priceChange24h: priceChange24h ?? '',
      balance: balance ?? '',
      rawBalance: rawBalance ?? '',
    );
  }
}
