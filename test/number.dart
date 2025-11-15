import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/extensions/number.dart';
import 'package:flutter_aigun/utils/format/profit.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("买入", () {
    expect(ProfitFormatter.format(0.9856, mode: QuickTradeMode.buy), "98%");
  });

  // group('ProfitFormatter 测试', () {
  //   group('formatBuy (买入模式)', () {
  //     test('小于 1% (0.01) 显示 <1x', () {
  //       expect(ProfitFormatter.format(99, mode: QuickTradeMode.buy), "99x");
  //       expect(ProfitFormatter.format(0, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.001, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.005, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.009, mode: QuickTradeMode.buy), "<1x");
  //       expect(
  //           ProfitFormatter.format(0.00999, mode: QuickTradeMode.buy), "<1x");
  //     });

  //     test('1% 到 100% 之间显示百分比', () {
  //       expect(ProfitFormatter.format(0.01, mode: QuickTradeMode.buy), "1%");
  //       expect(ProfitFormatter.format(0.04, mode: QuickTradeMode.buy), "4%");
  //       expect(ProfitFormatter.format(0.040138, mode: QuickTradeMode.buy),
  //           "4.01%");
  //       expect(ProfitFormatter.format(0.05, mode: QuickTradeMode.buy), "5%");
  //       expect(ProfitFormatter.format(0.10, mode: QuickTradeMode.buy), "10%");
  //       expect(ProfitFormatter.format(0.5, mode: QuickTradeMode.buy), "50%");
  //       expect(ProfitFormatter.format(0.99, mode: QuickTradeMode.buy), "99%");
  //     });

  //     test('百分比带小数', () {
  //       expect(ProfitFormatter.format(0.045, mode: QuickTradeMode.buy), "4.5%");
  //       expect(
  //           ProfitFormatter.format(0.123, mode: QuickTradeMode.buy), "12.3%");
  //       expect(
  //           ProfitFormatter.format(0.1234, mode: QuickTradeMode.buy), "12.34%");
  //     });

  //     test('大于等于 1 显示倍数', () {
  //       expect(ProfitFormatter.format(1.0, mode: QuickTradeMode.buy), "1x");
  //       expect(ProfitFormatter.format(2.0, mode: QuickTradeMode.buy), "2x");
  //       expect(ProfitFormatter.format(2.5, mode: QuickTradeMode.buy), "2.5x");
  //       expect(ProfitFormatter.format(10.0, mode: QuickTradeMode.buy), "10x");
  //       expect(ProfitFormatter.format(10.5, mode: QuickTradeMode.buy), "10.5x");
  //     });
  //   });

  //   group('formatSell (卖出模式)', () {
  //     test('非负值显示 <1x', () {
  //       expect(ProfitFormatter.format(0, mode: QuickTradeMode.sell), "<1x");
  //       expect(ProfitFormatter.format(0.5, mode: QuickTradeMode.sell), "<1x");
  //       expect(ProfitFormatter.format(1.0, mode: QuickTradeMode.sell), "<1x");
  //     });

  //     test('负值显示百分比（无负号）', () {
  //       expect(ProfitFormatter.format(-0.05, mode: QuickTradeMode.sell), "5%");
  //       expect(ProfitFormatter.format(-0.10, mode: QuickTradeMode.sell), "10%");
  //     });
  //   });
  // });

  group("NumericUtils.multiplyByDecimalPower 测试", () {
    test("精度问题", () {
      expect(
          NumericUtils.multiplyByDecimalPower(
              100
                  .toPercentage()
                  .preciseMultiply("0.8695128994466828")
                  .toString(),
              18),
          BigInt.from(869512899446682800));
    });
  });
}
