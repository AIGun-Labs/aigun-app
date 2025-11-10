import 'package:flutter_aigun/utils/extensions/double.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class CurrencyFormatter {
  static String format(
    double amount, {
    bool showCurrency = false,
    String? currencyCode,
  }) {
    // 处理极小数值
    if (amount > 0 && amount < 0.0001) {
      return _formatSmallNumber(amount);
    }

    // 确定小数位数
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

      // 去除尾部多余的0
      return _removeTrailingZeros(formatted);
    }

    // 无货币格式化，去除尾部多余的0
    final formattedNumber = amount.toStringAsFixed(decimalPlaces);
    return _removeTrailingZeros(formattedNumber);
  }

  /// 去除尾部多余的0
  static String _removeTrailingZeros(String number) {
    if (!number.contains('.')) return number;

    // 移除整数后的.0
    // 移除小数后的0
    return number
        .replaceAll(RegExp(r'\.?0+$'), '')
        .replaceAll(RegExp(r'(\.\d*?)0+$'), '\$1');
  }

  /// 处理极小数值的格式化
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
      // 移除尾部的0
      final significantDigits = scientificStr
          .replaceFirst('0.', '')
          .replaceAll(RegExp('^0+'), '')
          .replaceAll(RegExp('0+\$'), '');

      return '0.0{$leadingZeros}$significantDigits';
    }

    return _removeTrailingZeros(scientificStr);
  }

  /// 根据数值大小确定小数位数
  static int _getDecimalPlaces(double amount) {
    final absAmount = amount.abs();
    if (absAmount >= 0.0001 && absAmount < 10) {
      return 4;
    } else if (absAmount >= 10) {
      return 2;
    }
    return 10; // 对于小于0.0001的数字，使用10位小数以保留精度
  }

  /// 带货币符号的格式化
  static String formatWithSymbol(double amount, String currencyCode) {
    return format(amount, showCurrency: true, currencyCode: currencyCode);
  }

  static String formatWithFourDecimals(double amount) {
    //  创建自定义货币，精度为 4
    final pseudoCurrency = Currency.create('XXX', 4);

    // 2. 使用该货币从数字创建 Money 实例
    final money = Money.fromNumWithCurrency(amount, pseudoCurrency);

    return money.format('#.####');
  }

  static String formatPriceWithSymbol(String amount) {
    return "\$${formatPrice(amount)}";
  }

  static String formatPrice(String amount) {
    return _formatSmallNumber(double.tryParse(amount) ?? 0);
  }

  // 接受一个可选的命名参数 symbol, 默认值为 '$'
  // fixedDecimals: 固定保留的小数位数，null 表示自动去除尾部 0
  // maxDecimals: 最大小数位数限制（当 fixedDecimals 为 null 时生效）
  static String abbreviateTokenPrice(
    double price, {
    String symbol = '',
    int? fixedDecimals,
    int? maxDecimals,
  }) {
    price = price.removeNegativeSign;
    // 缩写判断：当小数点后连续零 ≥ 4
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
            // 固定小数位数，需要补 0
            significantDigits = significantDigits.padRight(fixedDecimals, '0');
          }

          // 如果不是固定小数位数，去掉末尾的无效0
          if (fixedDecimals == null) {
            significantDigits = significantDigits.replaceAll(RegExp(r'0+$'), '');
          }

          // 使用传入的 symbol
          return '$symbol${'0.0'}${_toSubscript(zeroCount)}$significantDigits';
        }
      }
    }

    // 规则 A: 价格 < $10,000
    if (price < 10000) {
      int decimalDigits = fixedDecimals ?? maxDecimals ?? 4;
      final formatter = NumberFormat.currency(
        symbol: symbol,
        decimalDigits: decimalDigits,
      );
      String formatted = formatter.format(price);

      // 如果不是固定小数位数，去除尾部 0
      if (fixedDecimals == null && formatted.contains('.')) {
        formatted = formatted
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');

        // 如果设置了最大小数位数限制，确保不超过
        if (maxDecimals != null) {
          final parts = formatted.split('.');
          if (parts.length == 2 && parts[1].length > maxDecimals) {
            formatted = '${parts[0]}.${parts[1].substring(0, maxDecimals)}';
          }
        }
      }
      return formatted;
    }

    // 规则 B: 价格 ≥ $10,000
    else {
      int decimalDigits = fixedDecimals ?? maxDecimals ?? 2;
      final formatter = NumberFormat.currency(
        symbol: symbol,
        decimalDigits: decimalDigits,
        locale: 'en_US',
      );
      String formatted = formatter.format(price);

      // 如果不是固定小数位数，去除尾部 0
      if (fixedDecimals == null && formatted.contains('.')) {
        formatted = formatted
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');

        // 如果设置了最大小数位数限制，确保不超过
        if (maxDecimals != null) {
          final parts = formatted.split('.');
          if (parts.length == 2 && parts[1].length > maxDecimals) {
            formatted = '${parts[0]}.${parts[1].substring(0, maxDecimals)}';
          }
        }
      }
      return formatted;
    }
  }

  static String _toSubscript(int number) {
    const subscripts = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];
    String result = '';
    number.toString().split('').forEach((digit) {
      result += subscripts[int.parse(digit)];
    });
    return result;
  }

  static String abbreviateTokenPriceWithSymbol(double price,
      {String symbol = '\$'}) {
    return "$symbol${abbreviateTokenPrice(price)}";
  }

  static String formatPriceEnglish(num price,
      {int decimals = 2, String currencySymbol = '\$', lowerCase = false}) {
    if (price < 1000) {
      // 小于1000直接格式化
      return formatPrice(price.toString());
    } else if (price >= 1000000000000) {
      // 万亿（T）
      double num = price / 1000000000000;
      String result = num.toStringAsFixed(decimals)
          .replaceAll(RegExp(r'\.0+$'), '')
          .replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 't' : 'T'}';
    } else if (price >= 1000000000) {
      // 十亿（B）
      double num = price / 1000000000;
      String result = num.toStringAsFixed(decimals)
          .replaceAll(RegExp(r'\.0+$'), '')
          .replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'b' : 'B'}';
    } else if (price >= 1000000) {
      // 百万（M）
      double num = price / 1000000;
      String result = num.toStringAsFixed(decimals)
          .replaceAll(RegExp(r'\.0+$'), '')
          .replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'm' : 'M'}';
    } else if (price >= 1000) {
      // 千（K）
      double num = price / 1000;
      String result = num.toStringAsFixed(decimals)
          .replaceAll(RegExp(r'\.0+$'), '')
          .replaceAll(RegExp(r'\.00$'), '');
      return '$currencySymbol$result${lowerCase ? 'k' : 'K'}';
    } else {
      // 理论不会到这里
      return '$currencySymbol${price.toString()}${lowerCase ? 't' : 'T'}';
    }
  }
}
