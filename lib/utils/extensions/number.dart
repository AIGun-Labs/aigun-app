import 'package:decimal/decimal.dart';

extension NumberExtensions on num {
  num multiplyBy(int other) {
    return this * other;
  }

  double safeMultiply(String? other) {
    final numOther = double.tryParse(other ?? "0") ?? 0.0;

    return toDouble() * numOther;
  }

  String preciseMultiply(String? other) {
    if (other == null || other.isEmpty) return "0";

    final decimal = Decimal.tryParse(toString()) ?? Decimal.zero;
    final otherDecimal = Decimal.tryParse(other) ?? Decimal.zero;

    return (decimal * otherDecimal).toString();
  }

  double toPercentage() {
    return toDouble() / 100;
  }

  bool isPositive() {
    return isFinite && this > 0;
  }
}
