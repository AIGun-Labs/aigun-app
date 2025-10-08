import 'dart:math';
import 'package:decimal/decimal.dart';

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

  String divideByDecimalPower(int decimals) {
    if (isEmpty) {
      return "0";
    }
    final numerator = Decimal.parse(this);
    final result = numerator.toDouble() / pow(10, decimals);
    return result.toString();
  }

  String splitStartAndEnd(int start, int end, {String? separator = "..."}) {
    if (isEmpty) {
      return "";
    }

    // If start or end are invalid, return original string
    if (start < 0 || end < 0) {
      return this;
    }

    // If the string is too short to be truncated, return it as is
    if (length <= start + end) {
      return this;
    }

    // Ensure we don't exceed string bounds
    final safeStart = start.clamp(0, length);
    final safeEnd = end.clamp(0, length);

    // If after clamping, the string would be fully shown, return it as is
    if (safeStart + safeEnd >= length) {
      return this;
    }

    return "${substring(0, safeStart)}$separator${substring(length - safeEnd, length)}";
  }

  String capitelize() {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  int toInt() {
    if (isEmpty) return 0;
    return int.tryParse(this) ?? 0;
  }

  bool isPositive() {
    if (isEmpty) return false;
    return toInt() > 0 ? true : false;
  }
}
