import '../../../data/models/intel/intel.dart';
import '../entities/base_token_entity.dart';

extension EntityMapper on Entity {
  BaseTokenEntity toTokenEntity() {
    return BaseTokenEntity(
      chainId: chain?.networkId ?? '',
      chainLogo: chain?.logo ?? '',
      chainName: chain?.name ?? '',
      tokenLogo: logo ?? '',
      tokenName: name ?? '',
      tokenPrice: stats?.currentPriceUsd ?? '',
      symbol: symbol ?? '',
      network: chain?.slug ?? '',
      address: contractAddress ?? '',
      rawBalance: '',
      balance: '',
      decimals: decimals ?? 0,
      priceChange24h: '',
      marketCap: stats?.currentMarketCap ?? '',
      isNative: isNative ?? isNativeToken,
      liquidity: '',
      volume24h: '',
    );
  }
}
