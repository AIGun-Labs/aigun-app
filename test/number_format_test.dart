import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatPriceAdvanced', () {
    test('Small numbers (<= 10000)', () {
      expect(CurrencyFormatter.abbreviateTokenPrice(0.001000000), "0.0010");
    });
  });
}
