import '../formatters/number_fomatter.dart';

extension StringNumX on String? {
  /// 市值（英文单位，$ + K/M/B/T），字符串也可直接调用
  String marketCap({String symbol = r'$'}) =>
      NumberFormatter.marketCap(this, symbol: symbol);

  /// 智能价格格式
  String priceSmart({int maxDecimals = 4}) =>
      NumberFormatter.priceSmart(this, maxDecimals: maxDecimals);
}
