import '../formatters/number_fomatter.dart';

extension StringNumX on String? {
  
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);
}
