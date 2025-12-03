import 'package:decimal/decimal.dart';

class TokenCalculator {
  static double calculateHoldingValue({
    required double price,
    required double amount,
  }) {
    return amount * price;
  }

  static String calculateHoldingValuePrecise({
    required String price,
    required String amount,
    int decimal = 8,
  }) {
    final priceNum = Decimal.parse(price);
    final amountNum = Decimal.parse(amount);
    final result = priceNum * amountNum;
    return result.toStringAsFixed(decimal);
  }
}
