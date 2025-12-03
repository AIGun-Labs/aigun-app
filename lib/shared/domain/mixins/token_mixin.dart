// lib/core/domain/mixins/token_mixin.dart

import '../../../utils/validators/token_validator.dart';
import '../../presentation/extensions/string_number_extension.dart';
import '../../utils/chain_symbol.dart';
import '../interfaces/i_token.dart';

/// Token 核心行为 Mixin
///
/// 提供所有 Token 通用的计算属性和方法
/// 任何实现 IToken 的实体都可以使用这个 mixin
mixin TokenMixin implements IToken {
  // ==================== 标识相关 ====================

  /// 唯一标识符: network:address
  String get uniqueId => '$network:$address';

  /// 链标识符
  String get chainIdentifier => chainId.isNotEmpty ? chainId : network;

  // ==================== 显示相关 ====================

  /// 显示名称 (优先使用 tokenName，否则使用 symbol)
  String get displayName => tokenName.isNotEmpty ? tokenName : symbol;

  /// 简短显示名称 (用于列表等场景)
  String get shortDisplayName {
    if (tokenName.isEmpty) return symbol;
    return tokenName.length > 20
        ? '${tokenName.substring(0, 20)}...'
        : tokenName;
  }

  // ==================== 余额相关 ====================

  /// 是否有余额
  bool get hasBalance {
    if (balance.isEmpty) return false;
    final bal = double.tryParse(balance) ?? 0;
    return bal > 0;
  }

  /// 余额数值
  double get balanceValue => double.tryParse(balance) ?? 0;

  /// 原始余额数值
  double get rawBalanceValue => double.tryParse(rawBalance) ?? 0;

  // ==================== 价格相关 ====================

  /// 是否有价格
  bool get hasPrice {
    if (tokenPrice.isEmpty) return false;
    final price = double.tryParse(tokenPrice) ?? 0;
    return price > 0;
  }

  /// 价格数值
  double get priceValue => double.tryParse(tokenPrice) ?? 0;

  /// 格式化价格显示
  String get formattedPrice => tokenPrice.priceSmart();

  /// 价格变化百分比数值
  double get priceChangePercent => double.tryParse(priceChange24h) ?? 0;

  /// 是否价格上涨
  bool get isPriceUp => priceChangePercent > 0;

  /// 是否价格下跌
  bool get isPriceDown => priceChangePercent < 0;

  /// 是否价格不变
  bool get isZeroPriceChange => priceChangePercent == 0.0;

  /// 格式化价格变化显示
  String get formattedPriceChange {
    if (priceChange24h.isEmpty) return '0%';
    return '${priceChangePercent.toStringAsFixed(2)}%';
  }

  // ==================== 市值相关 ====================

  /// 市值数值
  double get marketCapValue => double.tryParse(marketCap) ?? 0;

  /// 是否有市值
  bool get hasMarketCap => marketCapValue > 0;

  /// 格式化市值显示
  String get formattedMarketCap => marketCap.marketCap();

  // ==================== 验证相关 ====================

  /// 是否是有效的 Token
  bool get isValid {
    return address.isNotEmpty && symbol.isNotEmpty && network.isNotEmpty;
  }

  /// 是否是原生 Token
  bool get isNativeByAddress {
    return TokenValidator.isNativeToken(address, network: network);
  }

  String get nativeSymbol {
    return ChainSymbolUtils.getSymbolByNetwork(network) ?? '';
  }
}
