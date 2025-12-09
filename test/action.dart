import 'package:aigun/cubits/quick_trade/quick_trade_state.dart';
import 'package:aigun/shared/utils/token_purchase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenPurchaseService.getTradeModeFromAction', () {
    test('super long 应该返回 buy（超大利好）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('super long'),
        QuickTradeMode.buy,
      );
    });

    test('big long 应该返回 buy（大利好，完全超越了用户预期）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('big long'),
        QuickTradeMode.buy,
      );
    });

    test('long 应该返回 buy（普通利好，推荐购买）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('long'),
        QuickTradeMode.buy,
      );
    });

    test('small long 应该返回 buy（小利好，用户预期范围内的）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('small long'),
        QuickTradeMode.buy,
      );
    });

    test('small short 应该返回 sell（小利空，没带来特别多曝光）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('small short'),
        QuickTradeMode.sell,
      );
    });

    test('short 应该返回 sell（普通利空，被抨击有重大缺陷）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('short'),
        QuickTradeMode.sell,
      );
    });

    test('big short 应该返回 sell（大利空，威胁到了项目的生存）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('big short'),
        QuickTradeMode.sell,
      );
    });

    test('super short 应该返回 sell（超级大利空，利空程度大大地超过了用户预期）', () {
      expect(
        TokenPurchaseService.getTradeModeFromAction('super short'),
        QuickTradeMode.sell,
      );
    });
  });
}
