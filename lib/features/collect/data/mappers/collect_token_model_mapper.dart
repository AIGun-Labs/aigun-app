import '../../domain/entities/collect_token_entity.dart';
import '../models/collect_token_model.dart';

extension CollectTokenModelToEntityMapper on CollectTokenModel {
  CollectTokenEntity toEntity() {
    return CollectTokenEntity(
      network: network,
      address: contractAddress,
      tokenName: tokenName,
      tokenLogo: tokenLogo,
      tokenPrice: priceUsd,
      chainId: '',
      chainLogo: chainLogo,
      chainName: chainName,
      symbol: symbol,
      rawBalance: rawBalance,
      balance: balance,
      decimals: 0,
      priceChange24h: priceChange24h,
      marketCap: marketCap,
      isNative: isNative,
      isTop: isTop,
      liquidity: '',
      volume24h: '',
    );
  }
}
