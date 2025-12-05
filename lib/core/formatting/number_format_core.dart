import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class NumberFormatCore {
  NumberFormatCore._();

  static final Map<String, NumberFormat> _cache = {};

  static String thousand(num? value, {String? locale, int fractionDigits = 0}) {
    if (value == null) return '-';
    final pattern = fractionDigits == 0
        ? '#,###'
        : '#,##0.${'#' * fractionDigits}';
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

  static String marketCap(
    dynamic value, {
    String symbol = r'$',
    String? locale,
  }) {
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

  static String priceSmart(
    dynamic value, {
    int maxDecimals = 4,
    String? locale,
  }) {
    Decimal? d;
    if (value is num) {
      d = Decimal.parse(value.toString());
    } else if (value is String) {
      d = Decimal.tryParse(value);
    }

    if (d == null || d.sign <= 0 || d == Decimal.zero) return '0';

    final absD = d.abs();
    late final String res;

    if (absD >= Decimal.parse('100000')) {
      res = d.toStringAsFixed(0);
    } else if (absD >= Decimal.parse('10000')) {
      res = (d.toStringAsFixed(1)).replaceAll(RegExp(r'\.0$'), '');
    } else if (absD >= Decimal.parse('1000')) {
      res = (d.toStringAsFixed(
        2,
      )).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } else if (absD >= Decimal.one) {
      res = (d.toStringAsFixed(
        maxDecimals,
      )).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }

    if (res.isNotEmpty) return res;

    final s = d.toString();
    final parts = s.split('.');
    if (parts.length < 2) return s;
    final decimalPart = parts[1];

    final match = RegExp(r'^(0+)([1-9]\d*)$').firstMatch(decimalPart);
    if (match == null) {
      res = (d.toStringAsFixed(
        maxDecimals,
      )).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }

    final zeroCount = match?.group(1)?.length ?? 0;

    if (zeroCount < 4) {
      res = (d.toStringAsFixed(
        maxDecimals,
      )).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }

    if (res.isNotEmpty) return res;

    final tail = match?.group(2) ?? '';
    final take = tail.length < maxDecimals ? tail.length : maxDecimals;
    var sig = tail.substring(0, take);
    sig = sig.replaceAll(RegExp(r'0+$'), '');

    return '0.0${_toSubscript(zeroCount)}$sig';
  }

  static String _toSubscript(int number) {
    const subscripts = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];
    return number
        .toString()
        .split('')
        .map((d) => subscripts[int.parse(d)])
        .join();
  }

  static void clearLocale(String locale) {
    _cache.removeWhere((key, value) => key.startsWith('$locale|'));
  }
}
