import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class CurrencyFormatter {
  /// 格式化数字，规则如下：
  /// 1. 如果数字小于0.0001，显示科学计数法（如：0.0000123 => 0.0{4}123）
  /// 2. 个位数保留4位小数
  /// 3. 十位及以上保留2位小数
  /// 4. 去除尾部多余的0
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
  static String abbreviateTokenPrice(double price, {String symbol = ''}) {
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

          if (significantDigits.length > 4) {
            // 四舍五入到4位有效数字
            // (此处逻辑简化，直接截取前四位进行演示。如需精确四舍五入，逻辑会更复杂)
            significantDigits = significantDigits.substring(0, 4);
          }

          // 去掉末尾的无效0
          significantDigits = significantDigits.replaceAll(RegExp(r'0+$'), '');

          // 使用传入的 symbol
          return '$symbol${'0.0'}${_toSubscript(zeroCount)}$significantDigits';
        }
      }
    }

    // 规则 A: 价格 < $10,000
    if (price < 10000) {
      final formatter = NumberFormat.currency(
        symbol: symbol, // 使用传入的 symbol
        decimalDigits: 4,
      );
      String formatted = formatter.format(price);
      if (formatted.contains('.')) {
        formatted = formatted
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
      return formatted;
    }

    // 规则 B: 价格 ≥ $10,000
    else {
      final formatter = NumberFormat.currency(
        symbol: symbol, // 使用传入的 symbol
        decimalDigits: 2,
        locale: 'en_US',
      );
      String formatted = formatter.format(price);
      if (formatted.contains('.')) {
        formatted = formatted
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
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
