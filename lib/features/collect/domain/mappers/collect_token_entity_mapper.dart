import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../widgets/token/models/token.dart';
import '../entities/collect_token_entity.dart';

extension CollectTokenEntityToTokenMapper on CollectTokenEntity {
  Token toToken() {
    return Token(
      chainId: '', // collect token 的 chain id 实际上是 uuid （不需要）
      chainLogo: base.chainLogo,
      chainName: base.chainName,
      tokenAvatar: base.tokenLogo,
      tokenName: base.tokenName,
      address: base.address,
      tokenPrice: base.price,
      rawBalance: base.rawBalance,
      balance: base.balance,
      decimals: base.decimals,
      symbol: base.symbol,
      network: base.network,
      priceChange24h: double.tryParse(base.priceChange24h) ?? 0.0,
      marketCap: double.tryParse(base.marketCap) ?? 0.0,
      isNative: base.isNative,
    );
  }

  BaseTokenEntity toTokenEntity() {
    return base;
  }
}
