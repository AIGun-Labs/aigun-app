import '../../../features/collect/domain/entities/collect_token_entity.dart';
import '../../../widgets/token/models/token.dart';
import '../entities/token_entity.dart';

extension TokenEntityMapper on TokenEntity {
  Token toToken() {
    return Token(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenLogo,
      tokenName: tokenName,
      address: address,
      tokenPrice: tokenPrice,
      rawBalance: rawBalance,
      balance: balance,
      decimals: decimals,
      symbol: symbol,
      network: network,
      priceChange24h: priceChangePercent,
      marketCap: marketCapValue,
      isNative: isNative,
    );
  }

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
      isNative: isNative,
      liquidity: '',
      volume24h: '',
    );
  }
}
