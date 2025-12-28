import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/transaction_entity.dart';
import 'token_card/index.dart';

///
extension TokenConversions on Token {
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

extension BaseTokenEntityConversions on BaseTokenEntity {
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

extension TransactionEntityConversions on TransactionEntity? {
  TokenCardConfig toTokenCardConfig({String? amount, String? dollarValue}) {
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
