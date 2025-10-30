class NumericFormatter {
  /// 将数字字符串格式化为带千分位分隔符的格式
  static String formatToWei(String numberString) {
    try {
      // 解析为数字
      final number = double.parse(numberString);

      // 如果数字小于 1000，直接返回原字符串
      if (number < 1000) {
        return numberString;
      }

      // 格式化为带千分位分隔符
      return _formatWithCommas(numberString);
    } catch (e) {
      return numberString;
    }
  }

  static String formatPercent(double value) {
    // 如果是整数，直接返回整数部分 + %
    if (value % 1 == 0) {
      return '${value.toInt()}%';
    } else {
      // 保留最多2位小数，然后去掉末尾无意义的0
      String formatted = value.toStringAsFixed(2);
      // 移除末尾的 .00 或单个 0
      formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');
      return '$formatted%';
    }
  }

  /// 根据数值大小添加正负号
  static String formatWithSign(double value, {suffix = ''}) {
    if (value.toString().startsWith("-")) {
      return "$value$suffix";
    }
    if (value.toString().startsWith("+")) {
      return "$value$suffix";
    }

    if (value > 0) {
      return '+$value$suffix';
    } else if (value < 0) {
      return '-$value$suffix';
    } else {
      return "$value$suffix";
    }
  }

  /// 为数字字符串添加千分位分隔符
  static String _formatWithCommas(String numberString) {
    // 分离整数部分和小数部分
    final parts = numberString.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // 只对整数部分添加千分位分隔符
    final buffer = StringBuffer();
    final length = integerPart.length;

    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
    }

    return buffer.toString() + decimalPart;
  }

  /// 格式化数字，如果是浮点数保留指定的小数位
  /// [amount] 要格式化的数字
  /// [symbol] 符号
  /// [decimalDigits] 小数位数
  /// 返回格式化后的字符串
  /// 例如：
  /// 123345 => 123345
  /// 123345.12345 => 123345.12(这里保留的小数是制定的位数)
  static String formatValuesDecimalDigits(
      num amount, String symbol, int decimalDigits) {
    if (amount % 1 == 0) {
      return amount.toStringAsFixed(0);
    } else {
      return amount.toStringAsFixed(decimalDigits);
    }
  }
}
