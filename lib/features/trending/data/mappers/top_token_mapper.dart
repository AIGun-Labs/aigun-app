import '../../domain/entities/top_token_entity.dart';
import '../models/top_token_model.dart';

extension TopTokenMapper on TopTokenModel {
  TopTokenEntity toEntity() {
    return TopTokenEntity(
      id: id,
      logo: logo,
      symbol: symbol,
      name: name,
      marketCap: '',
      price: '',
      decimals: '',
      contractAddress: '',
      network: '',
      priceChange24h: '',
    );
  }
}
