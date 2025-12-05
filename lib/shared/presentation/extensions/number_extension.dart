import 'package:flutter/widgets.dart';

import '../formatters/number_fomatter.dart';

extension NumX on num? {
  
  
  
  
  
  
  String comma(BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatter.thousand(this, ctx, fractionDigits: fractionDigits);

  
  
  
  
  
  
  String compact(BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatter.compact(this, ctx, fractionDigits: fractionDigits);

  
  
  
  
  
  
  
  
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  
  
  
  
  
  
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);
}
