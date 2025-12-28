import 'package:aigun/cubits/quick_trade/quick_trade_state.dart';
import 'package:aigun/shared/utils/token_purchase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenPurchaseService.getTradeModeFromAction', () {
    test('super long  buy（）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('super long'),
        QuickTradeMode.buy,
      );
    });

    test('big long  buy（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('big long'),
        QuickTradeMode.buy,
      );
    });

    test('long  buy（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('long'),
        QuickTradeMode.buy,
      );
    });

    test('small long  buy（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('small long'),
        QuickTradeMode.buy,
      );
    });

    test('small short  sell（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('small short'),
        QuickTradeMode.sell,
      );
    });

    test('short  sell（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('short'),
        QuickTradeMode.sell,
      );
    });

    test('big short  sell（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('big short'),
        QuickTradeMode.sell,
      );
    });

    test('super short  sell（，）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('super short'),
        QuickTradeMode.sell,
      );
    });
  });
}
