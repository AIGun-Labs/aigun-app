import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/transaction_entity.dart';
import 'token_card/index.dart';

/// Token 转换扩展方法
///
/// 提供 Token、TransactionEntity、BaseTokenEntity 之间的转换
extension TokenConversions on Token {
  /// 将 Token 转换为 TransactionEntity
  TransactionEntity toTransactionEntity() {
    return TransactionEntity(
      isNative: isNativeToken,
      chainId: chainId,
      chainLogo: chainLogo,
      tokenAvatar: tokenAvatar,
      tokenName: tokenName,
      address: address,
      decimals: decimals,
      symbol: symbol,
      chainName: chainName,
      network: network,
      tokenPrice: double.tryParse(tokenPrice) ?? 0,
      balance: balance,
    );
  }
}

/// BaseTokenEntity 转换扩展
extension BaseTokenEntityConversions on BaseTokenEntity {
  /// 将 BaseTokenEntity 转换为 Token (用于选择器)
  Token toToken() {
    return Token(
      isNative: isNative,
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenLogo,
      tokenName: tokenName,
      address: address,
      tokenPrice: price,
      rawBalance: rawBalance,
      balance: balance,
      decimals: decimals,
      symbol: symbol,
      network: network,
      priceChange24h: double.tryParse(priceChange24h),
      marketCap: double.tryParse(marketCap),
    );
  }
}

/// TransactionEntity 转换扩展
extension TransactionEntityConversions on TransactionEntity? {
  /// 将 TransactionEntity 转换为 TokenCardConfig
  TokenCardConfig toTokenCardConfig({
    String? amount,
    String? dollarValue,
  }) {
    if (this == null) {
      return TokenCardConfig(
        symbol: '',
        tokenName: '',
        tokenAvatar: '',
        chainLogo: '',
        chainName: '',
        dollarValue: dollarValue ?? '',
        amount: amount,
        decimals: 18,
        isNative: false,
      );
    }
    return TokenCardConfig(
      symbol: this!.symbol,
      tokenName: this!.symbol,
      tokenAvatar: this!.tokenAvatar,
      chainLogo: this!.chainLogo,
      chainName: this!.chainName,
      dollarValue: dollarValue ?? '',
      amount: amount,
      decimals: this!.decimals,
      isNative: this!.isNative,
    );
  }
}
