import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatPriceAdvanced', () {
    test('Small numbers (<= 10000)', () {
      expect(formatPriceAdvanced(9999), equals('9999'));
      expect(formatPriceAdvanced(100), equals('100'));
      expect(formatPriceAdvanced(1.23), equals('1.2300'));
    });

    test('Ten thousand level (10000 - 999999)', () {
      expect(formatPriceAdvanced(15000), equals('1.50W'));
      expect(formatPriceAdvanced(999999), equals('99.99W'));
      expect(formatPriceAdvanced(10000), equals('1.00W'));
    });

    test('Million level (1000000 - 9999999)', () {
      expect(formatPriceAdvanced(1500000), equals('1.50M'));
      expect(formatPriceAdvanced(9999999), equals('9.99M'));
      expect(formatPriceAdvanced(1000000), equals('1.00M'));
    });

    test('Ten million level (10000000 - 99999999)', () {
      expect(formatPriceAdvanced(15000000), equals('1.50千W'));
      expect(formatPriceAdvanced(99999999), equals('9.99千W'));
      expect(formatPriceAdvanced(10000000), equals('1.00千W'));
    });

    test('Billion level (>= 100000000)', () {
      expect(formatPriceAdvanced(150000000), equals('1.50B'));
      expect(formatPriceAdvanced(999999999), equals('9.99B'));
      expect(formatPriceAdvanced(100000000), equals('1.00B'));
    });

    test('Currency symbol support', () {
      expect(formatPriceAdvanced(1500000, currencySymbol: '\$'), equals('\$1.50M'));
      expect(formatPriceAdvanced(15000000, currencySymbol: '¥'), equals('¥1.50千W'));
      expect(formatPriceAdvanced(150000000, currencySymbol: '€'), equals('€1.50B'));
    });

    test('Different decimal places', () {
      expect(formatPriceAdvanced(1500000, decimals: 1), equals('1.5M'));
      expect(formatPriceAdvanced(1500000, decimals: 3), equals('1.500M'));
      expect(formatPriceAdvanced(1500000, decimals: 4), equals('1.5000M'));
    });
  });
}
