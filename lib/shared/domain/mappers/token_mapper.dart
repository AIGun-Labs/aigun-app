import '../../../widgets/token/models/token.dart';
import '../entities/token_entity.dart';

extension TokenMapper on TokenEntity {
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
        isNative: isNative);
  }
}
