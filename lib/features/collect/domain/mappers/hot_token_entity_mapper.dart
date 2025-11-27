import '../../../../features/trending/domain/entities/hot_token_entity.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';

extension HotTokenEntityToCollectTokenMapper on HotTokenEntity {
  CollectTokenEntity toCollectToken({
    String? balance,
    String? rawBalance,
    bool isTop = false,
  }) {
    return CollectTokenEntity(
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
      isTop: isTop,
    );
  }
}
