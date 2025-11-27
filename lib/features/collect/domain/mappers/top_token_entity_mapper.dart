import '../../../collect/domain/entities/collect_token_entity.dart';
import '../../../trending/domain/entities/top_token_entity.dart';

extension TopTokenEntityToCollectTokenEntityMapper on TopTokenEntity {
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
