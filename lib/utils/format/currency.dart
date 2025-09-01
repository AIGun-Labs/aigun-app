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
}
