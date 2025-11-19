import '../../../../data/models/trending/lastest_token/lastest_token.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';

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
