import '../../../../cubits/trade/trade_state.dart';
import '../../../../widgets/token/models/token.dart';
import '../entities/token_info_entity.dart';

extension TokenInfoMapper on TokenInfoEntity {
  TradeToken toTradeToken() {
    return TradeToken(
      chainId: base.chainId,
      chainLogo: base.chainLogo,
      chainName: base.chainName,
      tokenAvatar: base.tokenLogo,
      tokenName: base.tokenName,
      address: base.address,
      decimals: base.decimals,
      symbol: base.symbol,
      tokenPrice: double.tryParse(base.tokenPrice) ?? 0.0,
      isNative: base.isNative,
    );
  }

  Token toToken() {
    return Token(
      chainId: base.chainId,
      chainLogo: base.chainLogo,
      chainName: base.chainName,
      tokenAvatar: base.tokenLogo,
      tokenName: base.tokenName,
      address: base.address,
      tokenPrice: base.tokenPrice,
      rawBalance: base.rawBalance,
      balance: base.balance,
      decimals: base.decimals,
      symbol: base.symbol,
      isNative: base.isNative,
      network: base.network,
      priceChange24h: double.tryParse(base.priceChange24h) ?? 0.0,
      marketCap: double.tryParse(base.marketCap) ?? 0.0,
    );
  }
}
