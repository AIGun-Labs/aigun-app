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
        isNative: isNative);
  }
}
