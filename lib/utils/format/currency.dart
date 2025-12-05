import 'package:money2/money2.dart';

import '../extensions/double.dart';
import '../numeric_utils.dart';

class CurrencyFormatter {
  static String format(
    double amount, {
    bool showCurrency = false,
    String? currencyCode,
  }) {
    if (amount > 0 && amount < 0.0001) {
      return _formatSmallNumber(amount);
    }

    final decimalPlaces = _getDecimalPlaces(amount);

    if (currencyCode != null) {
      String pattern =
          '${showCurrency ? 'S' : ''}#,###.${List.filled(decimalPlaces, '#').join()}';

      final currency = Currency.create(
        currencyCode,
        decimalPlaces,
        pattern: pattern,
      );

      String formatted;

      formatted = Money.fromNum(
        amount,
        isoCode: currency.isoCode,
        decimalDigits: decimalPlaces,
      ).format(pattern);

      return _removeTrailingZeros(formatted);
    }

    final formattedNumber = amount.toStringAsFixed(decimalPlaces);
    return _removeTrailingZeros(formattedNumber);
  }

  static String _removeTrailingZeros(String number) {
    if (!number.contains('.')) return number;

    return number
        .replaceAll(RegExp(r'\.?0+$'), '')
        .replaceAll(RegExp(r'(\.\d*?)0+$'), '\$1');
  }

  static String _formatSmallNumber(double number) {
    final scientificStr = number.toStringAsFixed(10);
    final parts = scientificStr.split('');

    int leadingZeros = 0;
    bool startCounting = false;

    for (var char in parts) {
      if (char == '0' && !startCounting) {
        continue;
      } else if (char == '.') {
        startCounting = true;
      } else if (startCounting) {
        if (char == '0') {
          leadingZeros++;
        } else {
          break;
        }
      }
    }

    if (leadingZeros >= 4) {
      final significantDigits = scientificStr
          .replaceFirst('0.', '')
          .replaceAll(RegExp('^0+'), '')
          .replaceAll(RegExp('0+\$'), '');

      return '0.0{$leadingZeros}$significantDigits';
    }

    return _removeTrailingZeros(scientificStr);
  }

  static int _getDecimalPlaces(double amount) {
    final absAmount = amount.abs();
    if (absAmount >= 0.0001 && absAmount < 10) {
      return 4;
    } else if (absAmount >= 10) {
      return 2;
    }
    return 10;
  }

  static String formatWithSymbol(double amount, String currencyCode) {
    return format(amount, showCurrency: true, currencyCode: currencyCode);
  }

  static String formatWithFourDecimals(double amount) {
    final pseudoCurrency = Currency.create('XXX', 4);

    final money = Money.fromNumWithCurrency(amount, pseudoCurrency);

    return money.format('#.####');
  }

  static String formatPriceWithSymbol(String amount) {
    return "\$${formatPrice(amount)}";
  }

  static String formatPrice(String amount) {
    return _formatSmallNumber(double.tryParse(amount) ?? 0);
  }

  static String abbreviateTokenPrice(
    double price, {
    String symbol = '',
    int? fixedDecimals,
    int? maxDecimals,
  }) {
    price = price.removeNegativeSign;

    if (price > 0 && price < 0.0001) {
      String priceStr = price.toStringAsFixed(20);
      RegExpMatch? match = RegExp(r'0\.0+').firstMatch(priceStr);

      if (match != null) {
        String zeros = match.group(0)!;
        int zeroCount = zeros.length - 2;

        if (zeroCount >= 4) {
          String remainingDigits = priceStr.substring(zeros.length);
          String significantDigits = '';

          for (int i = 0; i < remainingDigits.length; i++) {
            if (remainingDigits[i] != '0') {
              significantDigits = remainingDigits.substring(i);
              break;
            }
          }

          int sigDigitsCount = fixedDecimals ?? 4;
          if (significantDigits.length > sigDigitsCount) {
            significantDigits = significantDigits.substring(0, sigDigitsCount);
          } else if (fixedDecimals != null) {
            significantDigits = significantDigits.padRight(fixedDecimals, '0');
          }

          if (fixedDecimals == null) {
            significantDigits = significantDigits.replaceAll(
              RegExp(r'0+$'),
              '',
            );
          }

          return '$symbol${'0.0'}${_toSubscript(zeroCount)}$significantDigits';
        }
      }
    }

    if (price < 10000) {
      int decimalDigits = fixedDecimals ?? maxDecimals ?? 4;

      String truncated = NumericUtils.truncateDecimals(price, decimalDigits);

      if (fixedDecimals == null && truncated.contains('.')) {
        truncated = truncated
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');

        if (maxDecimals != null) {
          final parts = truncated.split('.');
          if (parts.length == 2 && parts[1].length > maxDecimals) {
            truncated = '${parts[0]}.${parts[1].substring(0, maxDecimals)}';
          }
        }
      }

      return _addThousandsSeparator(truncated, symbol);
    } else {
      int decimalDigits = fixedDecimals ?? maxDecimals ?? 2;

      String truncated = NumericUtils.truncateDecimals(price, decimalDigits);

      if (fixedDecimals == null && truncated.contains('.')) {
        truncated = truncated
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');

        if (maxDecimals != null) {
          final parts = truncated.split('.');
          if (parts.length == 2 && parts[1].length > maxDecimals) {
            truncated = '${parts[0]}.${parts[1].substring(0, maxDecimals)}';
          }
        }
      }

      return _addThousandsSeparator(truncated, symbol);
    }
  }

  static String _addThousandsSeparator(String number, String symbol) {
    final parts = number.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += ',';
      }
      formattedInteger += integerPart[i];
    }

    final result = decimalPart.isEmpty
        ? formattedInteger
        : '$formattedInteger.$decimalPart';

    return symbol.isEmpty ? result : '$symbol$result';
  }

  static String _toSubscript(int number) {
    const subscripts = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];
    String result = '';
    number.toString().split('').forEach((digit) {
      result += subscripts[int.parse(digit)];
    });
    return result;
  }

  static String abbreviateTokenPriceWithSymbol(
    double price, {
    String symbol = '\$',
  }) {
    return "$symbol${abbreviateTokenPrice(price)}";
  }

  static String formatPriceEnglish(
    num price, {
    int decimals = 2,
    String currencySymbol = '\$',
    lowerCase = false,
  }) {
    if (price < 1000) {
      return formatPrice(price.toString());
    } else if (price >= 1000000000000) {
      double num = price / 1000000000000;
      String result = num.toStringAsFixed(
        decimals,
      ).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 't' : 'T'}';
    } else if (price >= 1000000000) {
      double num = price / 1000000000;
      String result = num.toStringAsFixed(
        decimals,
      ).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'b' : 'B'}';
    } else if (price >= 1000000) {
      double num = price / 1000000;
      String result = num.toStringAsFixed(
        decimals,
      ).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'm' : 'M'}';
    } else if (price >= 1000) {
      double num = price / 1000;
      String result = num.toStringAsFixed(
        decimals,
      ).replaceAll(RegExp(r'\.0+$'), '').replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'k' : 'K'}';
    } else {
      return '$currencySymbol${price.toString()}${lowerCase ? 't' : 'T'}';
    }
  }
}
