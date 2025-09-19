import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter_aigun/utils/logger.dart';

extension StringExtensions on String {
  bool get isNotEmptyAndZeroValue {
    if (isEmpty) return false;

    final trimmed = trim();

    if (trimmed.isEmpty) return false;

    if (trimmed == "0" || trimmed == "-0") return false;

    if (trimmed.startsWith(".") || trimmed.endsWith(".")) return false;

    final numValue = num.tryParse(trimmed);

    if (numValue == null) return false;

    return numValue.abs() > 0;
  }

  String safeMultiply(String? other) {
    final numOther = double.tryParse(other ?? "0") ?? 0.0;
    final numThis = double.tryParse(this) ?? 0.0;
    return (numThis * numOther).toString();
  }

  String toPercentage() {
    final numValue = double.tryParse(this) ?? 0.0;
    return (numValue / 100).toString();
  }

  String truncateWithCharCount(int maxLength, {String? ellipsis = '...'}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// 将当前字符串数值除以10的指定小数位数次方
  ///
  /// 例如：
  /// "1500000".divideByDecimalPower(6) = "1.5" (1500000 ÷ 10^6 = 1.5)
  /// "1000000".divideByDecimalPower(3) = "1000" (1000000 ÷ 10^3 = 1000)
  /// @param decimals 小数位数
  /// @return 计算结果字符串
  String divideByDecimalPower(int decimals) {
    if (isEmpty) {
      return "0";
    }
    final numerator = Decimal.parse(this);
    final result = numerator.toDouble() / pow(10, decimals);
    return result.toString();
  }
}
