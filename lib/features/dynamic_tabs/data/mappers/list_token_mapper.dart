import '../../../../shared/domain/entities/base_token_entity.dart';
import '../models/list_token_model.dart';

extension ListTokenMapper on ListTokenModel {
  BaseTokenEntity toEntity() {
    return BaseTokenEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: name,
      tokenLogo: logo,
      tokenName: name,
      tokenPrice: priceUsd.toString(),
      symbol: symbol,
      network: network,
      address: contractAddress,
      rawBalance: '',
      balance: '',
      decimals: decimals,
      priceChange24h: priceChange24h.toString(),
      marketCap: marketCap.toString(),
      isNative: false,
      liquidity: liquidity.toString(),
      volume24h: volume24h.toString(),
    );
  }
}
