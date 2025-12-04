import '../../../../shared/domain/entities/token_entity.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';
import '../entities/top_token_entity.dart';

extension TopTokenEntityToCollectTokenEntityMapper on TopTokenEntity {
  CollectTokenEntity toCollectToken() {
    return CollectTokenEntity(
      chainId: '', // collect token 的 chain id 实际上是 uuid （不需要）
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
      isNative: isNative,
      liquidity: '',
      volume24h: '',
    );
  }

  TokenEntity toTokenEntity() {
    return TokenEntity(
      chainId: '', // collect token 的 chain id 实际上是 uuid （不需要）
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
      isNative: isNative,
      liquidity: '',
      volume24h: '',
    );
  }
}
