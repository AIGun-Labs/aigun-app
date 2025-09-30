extension NumberExtensions on num {
  num multiplyBy(int other) {
    return this * other;
  }

  double safeMultiply(String? other) {
    final numOther = double.tryParse(other ?? "0") ?? 0.0;

    return toDouble() * numOther;
  }

  double toPercentage() {
    return toDouble() / 100;
  }

  bool isPositive() {
    // 直接使用 this 比 toDouble() 更高效
    // isFinite 检查确保不是 NaN 或 Infinity
    return isFinite && this > 0;
  }
}
