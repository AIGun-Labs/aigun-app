import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class NumberFormatCore {
  NumberFormatCore._();

  static final Map<String, NumberFormat> _cache = {};

  /// 千分位分隔符
  /// [value] 值
  /// [locale] 语言
  /// [fractionDigits] 小数位数
  /// 返回千分位分隔符
  /// 示例：1000 -> "1,000"
  /// 示例：1000.1234567890 -> "1,000.1234"
  static String thousand(num? value, {String? locale, int fractionDigits = 0}) {
    if (value == null) return '-';
    final pattern =
        fractionDigits == 0 ? '#,###' : '#,##0.${'#' * fractionDigits}';
    final key = '${locale ?? Intl.getCurrentLocale()}|$pattern';
    final fmt = _cache.putIfAbsent(key, () => NumberFormat(pattern, locale));
    return fmt.format(value);
  }

  /// 紧凑型格式
  /// [value] 值
  /// [locale] 语言
  /// [fractionDigits] 小数位数
  /// 返回紧凑型格式
  /// 示例：1000 -> "1K"
  /// 示例：1000.1234567890 -> "1.0001K"
  /// 示例：1000000 -> "1M"
  /// 示例：1000000000 -> "1B"
  /// 示例：1000000000000 -> "1T"
  static String compact(num? value, {String? locale, int? fractionDigits}) {
    if (value == null) return '-';
    final key =
        '${locale ?? Intl.getCurrentLocale()}|COMPACT|${fractionDigits ?? -1}';
    final fmt = _cache.putIfAbsent(key, () {
      final f = NumberFormat.compact(locale: locale);
      if (fractionDigits != null) {
        f.maximumFractionDigits = fractionDigits;
        f.minimumFractionDigits = 0;
      }
      return f;
    });
    return fmt.format(value);
  }

  static String marketCap(dynamic value,
      {String symbol = r'$', String? locale}) {
    Decimal? d;

    if (value is num) {
      d = Decimal.parse(value.toString());
    } else if (value is String) {
      d = Decimal.tryParse(value);
    }

    if (d == null || d < Decimal.parse('0.001')) return '${symbol}0';

    final thousand = Decimal.parse('1000');
    final million = Decimal.parse('1000000');
    final billion = Decimal.parse('1000000000');
    final trillion = Decimal.parse('1000000000000');

    String suffix = '';
    Decimal divisor = Decimal.one;
    if (d >= trillion) {
      suffix = 'T';
      divisor = trillion;
    } else if (d >= billion) {
      suffix = 'B';
      divisor = billion;
    } else if (d >= million) {
      suffix = 'M';
      divisor = million;
    } else if (d >= thousand) {
      suffix = 'K';
      divisor = thousand;
    }

    final q = ((d / divisor).toDecimal());

    String out;
    if (q < Decimal.one && q >= Decimal.parse('0.001')) {
      out = q.toStringAsFixed(3);
    } else if (q < Decimal.parse('100')) {
      out = q.round(scale: 2).toString();
    } else {
      out = q.round(scale: 1).toString();
    }

    if (out.contains('.')) {
      out = out.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return '$symbol$out$suffix';
  }

  static void clearLocale(String locale) {
    _cache.removeWhere((key, value) => key.startsWith('$locale|'));
  }
}
