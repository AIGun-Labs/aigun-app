import 'package:flutter/widgets.dart';

import '../../../core/formatting/number_format_core.dart';

class NumberFormatter {
  NumberFormatter._();

  /// 千分位分隔符
  static String thousand(num? v, BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatCore.thousand(
        v,
        locale: Localizations.localeOf(ctx).toLanguageTag(),
        fractionDigits: fractionDigits,
      );

  /// 紧凑型格式
  static String compact(num? v, BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatCore.compact(
        v,
        locale: Localizations.localeOf(ctx).toLanguageTag(),
        fractionDigits: fractionDigits,
      );

  /// 市场资本格式
  static String marketCap(dynamic v, {String symbol = r'$'}) =>
      NumberFormatCore.marketCap(v, symbol: symbol);

  @Deprecated('未完全实现，不可用')
  /// 智能价格格式
  static String priceSmart(dynamic v, {int maxDecimals = 4}) =>
      NumberFormatCore.priceSmart(v, maxDecimals: maxDecimals);
}
