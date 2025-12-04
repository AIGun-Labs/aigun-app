import '../../../../widgets/token/models/token.dart';
import '../entities/collect_token_entity.dart';

extension TokenToCollectTokenEntityMapper on Token {
  CollectTokenEntity toCollectToken() {
    return CollectTokenEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenLogo: tokenAvatar,
      tokenName: tokenName,
      tokenPrice: tokenPrice,
      network: network ?? '',
      address: address,
      rawBalance: rawBalance,
      balance: balance,
      decimals: decimals,
      priceChange24h: priceChange24h.toString(),
      marketCap: marketCap.toString(),
      isNative: isNative,
      symbol: symbol,
      liquidity: '',
      volume24h: '',
    );
  }
}
