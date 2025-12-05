import '../../../../cubits/trade/trade_state.dart';
import '../../../../widgets/token/models/token.dart';
import '../entities/token_info_entity.dart';

extension TokenInfoMapper on TokenInfoEntity {
  TradeToken toTradeToken() {
    return TradeToken(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenLogo,
      tokenName: tokenName,
      address: address,
      decimals: decimals,
      symbol: symbol,
      tokenPrice: double.tryParse(tokenPrice) ?? 0.0,
      isNative: isNative,
    );
  }

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
      isNative: isNative,
      network: network,
      priceChange24h: double.tryParse(priceChange24h) ?? 0.0,
      marketCap: double.tryParse(marketCap) ?? 0.0,
    );
  }
}
