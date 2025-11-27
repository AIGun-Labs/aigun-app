import '../../domain/entities/hot_token_entity.dart';
import '../models/hot_token_model.dart';

extension HotTokenModelToEntityMapper on HotTokenModel {
  HotTokenEntity toEntity() => HotTokenEntity(
        name: name,
        symbol: symbol,
        logo: logoURL,
        marketCap: marketCap,
        decimals: decimals,
        price: price,
        contractAddress: contractAddress,
        chainId: chainId,
        chainName: chainName,
        chainLogo: chainLogoURL,
        network: network,
        slug: slug,
        chainIndex: chainIndex,
      );
}
