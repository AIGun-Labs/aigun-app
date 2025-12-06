import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';
import '../entities/hot_token_entity.dart';

extension HotTokenEntityToCollectTokenEntityMapper on HotTokenEntity {
  CollectTokenEntity toCollectToken({
    String? balance,
    String? rawBalance,
    bool isTop = false,
  }) {
    return CollectTokenEntity(
      base: BaseTokenEntity(
        chainId: chainId,
        chainLogo: chainLogo,
        chainName: chainName,
        tokenLogo: logo,
        tokenName: name,
        tokenPrice: price,
        symbol: symbol,
        network: network,
        address: contractAddress,
        rawBalance: rawBalance ?? '0',
        balance: balance ?? '0',
        decimals: int.tryParse(decimals) ?? 18,
        priceChange24h: '0', // HotToken 没有此字段，设为默认
        marketCap: marketCap,
        isNative: false, // HotToken 通常是代币而非原生币
        liquidity: '',
        volume24h: '',
      ),
      isTop: isTop,
    );
  }

  BaseTokenEntity toTokenEntity() {
    return BaseTokenEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenLogo: logo,
      tokenName: name,
      tokenPrice: price,
      symbol: symbol,
      network: network,
      address: contractAddress,
      rawBalance: '',
      balance: '',
      decimals: int.tryParse(decimals) ?? 18,
      priceChange24h: '', // HotToken 没有此字段，设为默认
      marketCap: marketCap,
      isNative: false, // HotToken 通常是代币而非原生币
      liquidity: '',
      volume24h: '',
    );
  }
}
