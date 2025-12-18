import 'package:flutter/widgets.dart';

import '../formatters/number_fomatter.dart';

extension NumX on num? {
  /// 千分位分隔符
  /// [ctx] 上下文
  /// [fractionDigits] 小数位数
  /// 返回千分位分隔符
  /// 示例：1000 -> "1,000"
  /// 示例：1000.1234567890 -> "1,000.1234"
  String comma(BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatter.thousand(this, ctx, fractionDigits: fractionDigits);

  /// 紧凑型格式
  /// [ctx] 上下文
  /// [fractionDigits] 小数位数
  /// 返回紧凑型格式
  /// 示例：1000 -> "1K"
  /// 示例：1000.1234567890 -> "1.0001K"
  String compact(BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatter.compact(this, ctx, fractionDigits: fractionDigits);

  /// 市场资本格式
  /// [ctx] 上下文
  /// [symbol] 符号
  /// 返回市场资本格式
  /// 示例：1000 -> "$1K"
  /// 示例：1000000 -> "$1M"
  /// 示例：1000000000 -> "$1B"
  /// 示例：1000000000000 -> "$1T"
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  @Deprecated('未完全实现，不可用')
  /// 智能价格格式
  /// [ctx] 上下文
  /// [maxDecimals] 最大小数位数
  /// 返回智能价格格式
  /// 示例：1000 -> "1K"
  /// 示例：1000.1234567890 -> "1.0001K"
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);

  /// 去除尾部多余的 0
  /// [maxDecimals] 最大小数位数
  /// 返回去除尾部多余的 0
  /// 示例：1.0000 -> "1"
  /// 示例：1.00001234567890 -> "1.00001234"
  /// ```dart
  /// 1.0000.removeTrailingZeros(); // 1
  /// ```
  String removeTrailingZeros({int maxDecimals = 4}) =>
      NumberFormatter.removeTrailingZeros(
        this?.toDouble() ?? 0,
        maxDecimals: maxDecimals,
      );
}
