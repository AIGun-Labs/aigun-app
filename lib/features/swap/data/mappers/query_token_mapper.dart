import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/entities/query_token_entity.dart';

extension QueryTokenMapper on QueryTokenEntity {
  BaseTokenEntity toTokenEntity() {
    return BaseTokenEntity(
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
      price: priceUsd ?? '',
      priceChange24h: priceChange24h ?? '',
      balance: balance ?? '',
      rawBalance: rawBalance ?? '',
      liquidity: '',
      volume24h: '',
    );
  }
}
