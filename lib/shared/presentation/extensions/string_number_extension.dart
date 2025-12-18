import '../formatters/number_fomatter.dart';

extension StringNumX on String? {
  /// 市值（英文单位，$ + K/M/B/T），字符串也可直接调用
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  @Deprecated('未完全实现，不可用')
  /// 智能价格格式
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);

  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this ?? defaultValue.toString()) ?? defaultValue;

  String removeTrailingZeros({int maxDecimals = 4}) =>
      NumberFormatter.removeTrailingZeros(toDouble(), maxDecimals: maxDecimals);
}
