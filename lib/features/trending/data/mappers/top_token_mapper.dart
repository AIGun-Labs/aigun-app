import '../../domain/entities/top_token_entity.dart';
import '../models/top_token_model.dart';

extension TopTokenMapper on TopTokenModel {
  TopTokenEntity toEntity() {
    return TopTokenEntity(
      id: id,
      logo: logo,
      symbol: symbol,
      name: name,
      marketCap: marketCap.toString(),
      price: priceUsd.toString(),
      decimals: decimals,
      contractAddress: contractAddress,
      network: network,
      priceChange24h: priceChange24h.toString(),
    );
  }
}
