import 'package:aigun/utils/validators/token_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Token Validator', () {
    test('token info is show ', () {
      // isNative = true  network = eth 不显示地址
      expect(TokenValidator.shouldShowAddress(true, 'eth'), false);
      // isNative = false  network = unknown 不显示地址
      expect(TokenValidator.shouldShowAddress(false, 'unknown'), false);
      // isNative = false  network = eth 显示地址
      expect(TokenValidator.shouldShowAddress(false, 'eth'), true);

      // network = unknown  不显示链 logo
      expect(
        TokenValidator.shouldShowChainLogo('unknown', 'https://xxssdfsdfa.com'),
        false,
      );
      // network = eth logo = "" 不显示logo
      expect(TokenValidator.shouldShowChainLogo('eth', ''), false);
      // network = eth logo = "https://xxssdfsdfa.com" 显示logo
      expect(
        TokenValidator.shouldShowChainLogo('eth', 'https://xxssdfsdfa.com'),
        true,
      );
    });
  });
}
