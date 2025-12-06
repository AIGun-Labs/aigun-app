import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/entities/collect_token_entity.dart';
import '../models/collect_token_model.dart';

extension CollectTokenModelToEntityMapper on CollectTokenModel {
  CollectTokenEntity toEntity() {
    return CollectTokenEntity(
      base: BaseTokenEntity(
        chainId: '',
        chainLogo: chainLogo,
        chainName: chainName,
        tokenLogo: tokenLogo,
        tokenName: tokenName,
        tokenPrice: priceUsd,
        symbol: symbol,
        network: network,
        address: contractAddress,
        rawBalance: rawBalance,
        balance: balance,
        decimals: 0,
        priceChange24h: priceChange24h,
        marketCap: marketCap,
        isNative: isNative,
        liquidity: '',
        volume24h: '',
      ),
      isTop: isTop,
    );
  }
}
