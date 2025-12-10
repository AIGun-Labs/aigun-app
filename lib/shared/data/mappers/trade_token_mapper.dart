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
