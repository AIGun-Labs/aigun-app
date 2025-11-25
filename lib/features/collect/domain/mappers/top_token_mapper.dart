import '../../../../data/models/trending/lastest_token/lastest_token.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';
import '../../../trending/domain/entities/top_token_entity.dart';

extension TopTokenMapper on LatestToken {
  CollectTokenEntity toCollectToken() {
    return CollectTokenEntity(
        chainId: chainId,
        chainLogo: '',
        chainName: '',
        tokenLogo: logo,
        tokenName: name,
        tokenPrice: priceUsd.toString(),
        symbol: symbol,
        network: network,
        address: contractAddress,
        rawBalance: '0',
        balance: '0',
        decimals: decimals,
        priceChange24h: priceChange24h.toString(),
        marketCap: marketCap.toString(),
        isNative: false);
  }
}

extension TopTokenEntityMapper on TopTokenEntity {
  CollectTokenEntity toCollectToken() {
    return CollectTokenEntity(
        chainId: chainId,
        chainLogo: chainLogo,
        chainName: chainName,
        tokenLogo: tokenLogo,
        tokenName: tokenName,
        tokenPrice: tokenPrice,
        symbol: symbol,
        network: network,
        address: address,
        rawBalance: rawBalance,
        balance: balance,
        decimals: decimals,
        priceChange24h: priceChange24h,
        marketCap: marketCap,
        isNative: isNative);
  }
}
