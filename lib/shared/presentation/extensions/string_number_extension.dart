import '../formatters/number_fomatter.dart';

extension StringNumX on String? {
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  @Deprecated('，')
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);

  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this ?? defaultValue.toString()) ?? defaultValue;

  String removeTrailingZeros({int maxDecimals = 4}) =>
      NumberFormatter.removeTrailingZeros(toDouble(), maxDecimals: maxDecimals);
}
