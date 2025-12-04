import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../widgets/token/models/token.dart';
import '../entities/collect_token_entity.dart';

extension CollectTokenEntityToTokenMapper on CollectTokenEntity {
  Token toToken() {
    return Token(
      chainId: '', // collect token 的 chain id 实际上是 uuid （不需要）
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

  TokenEntity toTokenEntity() {
    return TokenEntity(
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
      liquidity: liquidity,
      volume24h: volume24h,
    );
  }
}
