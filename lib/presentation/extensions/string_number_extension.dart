import 'package:flutter/material.dart';

import '../formatters/number_fomatter.dart';

extension StringNumX on String? {
  /// 市值（英文单位，$ + K/M/B/T），字符串也可直接调用
  String marketCap(BuildContext ctx, {String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, ctx, symbol: symbol);

  /// 智能价格格式
  String priceSmart(BuildContext ctx, {int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, ctx, maxDecimals: maxDecimals);
}
