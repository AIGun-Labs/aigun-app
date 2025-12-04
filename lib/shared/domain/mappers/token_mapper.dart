import '../../../widgets/token/models/token.dart';
import '../entities/token_entity.dart';

extension TokenMapper on Token {
  TokenEntity toTokenEntity() {
    return TokenEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenLogo: tokenAvatar,
      tokenName: tokenName,
      tokenPrice: tokenPrice,
      symbol: symbol,
      network: network ?? '',
      address: address,
      rawBalance: rawBalance,
      balance: balance,
      decimals: decimals,
      priceChange24h: priceChange24h.toString(),
      marketCap: marketCap.toString(),
      isNative: isNative,
      liquidity: '',
      volume24h: '',
    );
  }
}
