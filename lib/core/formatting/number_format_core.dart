import 'package:intl/intl.dart';

class NumberFormatCore {
  NumberFormatCore._();

  static final Map<String, NumberFormat> _cache = {};

  static String thousand(num? value, {String? locale, int fractionDigits = 0}) {
    if (value == null) return '-';
    final pattern =
        fractionDigits == 0 ? '#,###' : '#,##0.${'#' * fractionDigits}';
    final key = '${locale ?? Intl.getCurrentLocale()}|$pattern';
    final fmt = _cache.putIfAbsent(key, () => NumberFormat(pattern, locale));
    return fmt.format(value);
  }

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

  static void clearLocale(String locale) {
    _cache.removeWhere((key, value) => key.startsWith('$locale|'));
  }
}
