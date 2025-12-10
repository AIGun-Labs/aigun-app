import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/entities/token_info_entity.dart';
import '../models/detail_info_model.dart';

extension DetailInfoToEntityMapper on DetailInfoModel {
  TokenInfoEntity toEntity() {
    return TokenInfoEntity(
      base: BaseTokenEntity(
        chainId: '',
        chainLogo: chainLogo,
        chainName: '',
        tokenLogo: logo,
        tokenName: name,
        price: priceUsd,
        symbol: symbol,
        network: network,
        address: contractAddress,
        rawBalance: '',
        balance: '',
        decimals: 0,
        priceChange24h: priceChange24h,
        marketCap: marketCap,
        isNative: isNative,
        liquidity: liquidity,
        volume24h: volume24h,
      ),
      holders: holders,
      highestIncreaseRate: highestIncreaseRate,
      isMainstream: isMainStream,
      narrative: narrative,
    );
  }
}
