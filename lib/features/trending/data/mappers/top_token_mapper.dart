import '../../domain/entities/top_token_entity.dart';
import '../models/top_token_model.dart';

extension TopTokenMapper on TopTokenModel {
  TopTokenEntity toEntity() {
    return TopTokenEntity(
        chainId: chainId,
        chainLogo: chainLogo,
        chainName: '',
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
        displayTime: displayTime);
  }
}
