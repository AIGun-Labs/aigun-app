// lib/core/domain/mixins/token_mixin.dart

import '../../../utils/validators/token_validator.dart';
import '../../presentation/extensions/string_number_extension.dart';
import '../interfaces/i_token.dart';

///

mixin TokenMixin implements IToken {
  String get uniqueId => '$network:$address';

  String get chainIdentifier => chainId.isNotEmpty ? chainId : network;

  String get displayName => tokenName.isNotEmpty ? tokenName : symbol;

  String get shortDisplayName {
    if (tokenName.isEmpty) return symbol;
    return tokenName.length > 20
        ? '${tokenName.substring(0, 20)}...'
        : tokenName;
  }

  bool get hasBalance {
    if (balance.isEmpty) return false;
    final bal = double.tryParse(balance) ?? 0;
    return bal > 0;
  }

  double get balanceValue => double.tryParse(balance) ?? 0;

  double get rawBalanceValue => double.tryParse(rawBalance) ?? 0;

  bool get hasPrice {
    if (tokenPrice.isEmpty) return false;
    final price = double.tryParse(tokenPrice) ?? 0;
    return price > 0;
  }

  double get priceValue => double.tryParse(tokenPrice) ?? 0;

  String get formattedPrice => tokenPrice.priceSmart();

  double get priceChangePercent => double.tryParse(priceChange24h) ?? 0;

  bool get isPriceUp => priceChangePercent > 0;

  bool get isPriceDown => priceChangePercent < 0;

  bool get isZeroPriceChange => priceChangePercent == 0.0;

  String get formattedPriceChange {
    if (priceChange24h.isEmpty) return '0%';
    return '${priceChangePercent.toStringAsFixed(2)}%';
  }

  double get marketCapValue => double.tryParse(marketCap) ?? 0;

  bool get hasMarketCap => marketCapValue > 0;

  String get formattedMarketCap => marketCap.marketCap();

  bool get isValid {
    return address.isNotEmpty && symbol.isNotEmpty && network.isNotEmpty;
  }

  bool get isNativeByAddress {
    return TokenValidator.isNativeToken(address, network: network);
  }
}
