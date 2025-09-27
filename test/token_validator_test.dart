import 'package:flutter_aigun/utils/validators/token_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenValidator', () {
    test('should identify native tokens correctly', () {
      // 主币地址测试
      expect(TokenValidator.isNativeToken('0x2::sui::SUI'), true); // SUI
      expect(
          TokenValidator.isNativeToken(
              '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'),
          true); // ETH
      expect(
          TokenValidator.isNativeToken(
              'So11111111111111111111111111111111111111112'),
          true); // SOL
      expect(TokenValidator.isNativeToken('BTC'), true); // BTC
      expect(TokenValidator.isNativeToken(null), true); // null address
      expect(TokenValidator.isNativeToken(''), true); // empty address

      // 非主币地址测试
      expect(
          TokenValidator.isNativeToken(
              '0x1234567890123456789012345678901234567890'),
          false);
      expect(TokenValidator.isNativeToken('some-contract-address'), false);
    });

    test('should identify non-native tokens correctly', () {
      // 主币地址测试
      expect(TokenValidator.isNotNativeToken('0x2::sui::SUI'), false); // SUI
      expect(TokenValidator.isNotNativeToken(null), false); // null address

      // 非主币地址测试
      expect(
          TokenValidator.isNotNativeToken(
              '0x1234567890123456789012345678901234567890'),
          true);
      expect(TokenValidator.isNotNativeToken('some-contract-address'), true);
    });

    test('should return native token addresses', () {
      final addresses = TokenValidator.getNativeTokenAddresses();
      expect(addresses, isA<Set<String>>());
      expect(addresses.contains('0x2::sui::SUI'), true);
      expect(addresses.contains('BTC'), true);
    });
  });
}
