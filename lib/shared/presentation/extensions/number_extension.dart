import 'package:flutter/widgets.dart';

import '../formatters/number_fomatter.dart';

extension NumX on num? {
  String comma(BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatter.thousand(this, ctx, fractionDigits: fractionDigits);
  String compact(BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatter.compact(this, ctx, fractionDigits: fractionDigits);
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  @Deprecated('，')
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);

  /// ```dart
  /// 1.0000.removeTrailingZeros(); // 1
  /// ```
  String removeTrailingZeros({int maxDecimals = 4}) =>
      NumberFormatter.removeTrailingZeros(
        this?.toDouble() ?? 0,
        maxDecimals: maxDecimals,
      );
}
