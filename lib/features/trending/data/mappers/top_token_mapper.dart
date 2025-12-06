import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/entities/top_token_entity.dart';
import '../models/top_token_model.dart';

extension TopTokenToEntityMapper on TopTokenModel {
  TopTokenEntity toEntity() {
    return TopTokenEntity(
      base: BaseTokenEntity(
        chainId: chainId,
        chainLogo: chainLogo,
        chainName: network,
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
        isNative: isNative,
        liquidity: '',
        volume24h: '',
      ),
      id: id,
      displayTime: displayTime,
    );
  }
}
