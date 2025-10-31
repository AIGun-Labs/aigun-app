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
    return isFinite && this > 0;
  }

 
}
