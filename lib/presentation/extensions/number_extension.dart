import 'package:flutter/widgets.dart';

import '../formatters/number_fomatter.dart';

extension NumX on num? {
  // 千分位分隔符
  String comma(BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatter.thousand(this, ctx, fractionDigits: fractionDigits);

  // 紧凑型格式
  String compact(BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatter.compact(this, ctx, fractionDigits: fractionDigits);
}
