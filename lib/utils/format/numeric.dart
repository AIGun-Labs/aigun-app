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

  /// 为数字字符串添加千分位分隔符
  static String _formatWithCommas(String numberString) {
    final buffer = StringBuffer();
    final length = numberString.length;

    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(numberString[i]);
    }

    return buffer.toString();
  }
}
