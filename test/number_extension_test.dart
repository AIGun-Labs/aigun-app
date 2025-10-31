import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aigun/utils/extensions/number.dart';

void main() {
  group('NumberExtensions - Negative Sign Tests', () {
    test('withNegativeSignIfGreaterThan - 大于等于阈值时添加负号', () {
      expect(10.withNegativeSignIfGreaterThan(5), -10);
      expect(5.withNegativeSignIfGreaterThan(5), -5);
      expect(3.withNegativeSignIfGreaterThan(5), 3);
    });

    test('withNegativeSignIfGreaterThanStrict - 大于阈值时添加负号', () {
      expect(10.withNegativeSignIfGreaterThanStrict(5), -10);
      expect(5.withNegativeSignIfGreaterThanStrict(5), 5);
      expect(3.withNegativeSignIfGreaterThanStrict(5), 3);
    });

    test('withNegativeSignIfLessThan - 小于等于阈值时添加负号', () {
      expect(3.withNegativeSignIfLessThan(5), -3);
      expect(5.withNegativeSignIfLessThan(5), -5);
      expect(10.withNegativeSignIfLessThan(5), 10);
    });

    test('withNegativeSignIfLessThanStrict - 小于阈值时添加负号', () {
      expect(3.withNegativeSignIfLessThanStrict(5), -3);
      expect(5.withNegativeSignIfLessThanStrict(5), 5);
      expect(10.withNegativeSignIfLessThanStrict(5), 10);
    });

    test('处理负数输入', () {
      expect((-10).withNegativeSignIfGreaterThan(5), -10);
      expect((-3).withNegativeSignIfGreaterThan(5), -3);
      expect((-10).withNegativeSignIfLessThan(5), -10);
      expect((-3).withNegativeSignIfLessThan(5), -3);
    });

    test('处理小数', () {
      expect(10.5.withNegativeSignIfGreaterThan(10), -10.5);
      expect(9.5.withNegativeSignIfGreaterThan(10), 9.5);
      expect(10.5.withNegativeSignIfLessThan(10), 10.5);
      expect(9.5.withNegativeSignIfLessThan(10), -9.5);
    });
  });
}


