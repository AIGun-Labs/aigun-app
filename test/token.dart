import 'package:aigun/utils/validators/token_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Token Validator', () {
    test('token info is show ', () {
      expect(TokenValidator.shouldShowAddress(true, 'eth'), false);
      expect(TokenValidator.shouldShowAddress(false, 'unknown'), false);
      expect(TokenValidator.shouldShowAddress(false, 'eth'), true);
      expect(
        TokenValidator.shouldShowChainLogo('unknown', 'https://xxssdfsdfa.com'),
        false,
      );
      expect(TokenValidator.shouldShowChainLogo('eth', ''), false);
      expect(
        TokenValidator.shouldShowChainLogo('eth', 'https://xxssdfsdfa.com'),
        true,
      );
    });
  });
}
