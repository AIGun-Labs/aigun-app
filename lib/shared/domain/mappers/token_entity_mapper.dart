import '../../../cubits/trade/trade_state.dart';
import '../../../features/token_detail/domain/entities/token_info_entity.dart';
import '../../../widgets/token/models/token.dart';
import '../entities/base_token_entity.dart';

extension TokenEntityMapper on BaseTokenEntity {
  Token toToken() {
    return Token(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenLogo,
      tokenName: tokenName,
      address: address,
      tokenPrice: price,
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

  TokenInfoEntity toTokenInfo() {
    return TokenInfoEntity(
      base: this,
      holders: '0',
      highestIncreaseRate: '',
      isMainstream: false,
      narrative: null,
    );
  }

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
      tokenPrice: double.tryParse(price) ?? 0.0,
      isNative: isNative,
    );
  }
}
