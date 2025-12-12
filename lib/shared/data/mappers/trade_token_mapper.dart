import '../../domain/entities/base_token_entity.dart';
import '../models/trade_token_model.dart';

extension TradeTokenMapper on TradeTokenModel {
  BaseTokenEntity toBaseTokenEntity() {
    return BaseTokenEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenLogo: logo,
      tokenName: name,
      price: priceUsd,
      symbol: symbol,
      network: network,
      address: contractAddress,
      rawBalance: rawBalance,
      balance: balance,
      decimals: decimals,
      priceChange24h: priceChange24h,
      marketCap: marketCap,
      isNative: isNative,
      liquidity: liquidity,
      volume24h: volume24h,
      type: type,
      isTop: isTop ?? false,
      isVerified: isVerified ?? false,
      standard: standard,
      description: description,
      displayTime: displayTime,
      balanceUsd: balanceUsd,
    );
  }
}

extension BaseTokenEntityToTradeTokenMapper on BaseTokenEntity {
  TradeTokenModel toTradeTokenModel() {
    return TradeTokenModel(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      id: '',
      network: network,
      logo: tokenLogo,
      name: tokenName,
      symbol: symbol,
      contractAddress: address,
      decimals: decimals,
      isNative: isNative,
      priceUsd: price,
      priceChange24h: priceChange24h,
      marketCap: marketCap,
      liquidity: liquidity,
      volume24h: volume24h,
      rawBalance: rawBalance,
      balance: balance,
      type: type,
      isTop: isTop,
      isVerified: isVerified,
      standard: standard,
      description: description,
      displayTime: displayTime,
      balanceUsd: balanceUsd,
    );
  }
}
