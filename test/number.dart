import 'package:aigun/shared/presentation/extensions/number_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('remove 0', () {
    expect(10000.removeTrailingZeros(), '10000');
    expect(10.000.removeTrailingZeros(), '10');
  });
  //       expect(ProfitFormatter.format(99, mode: QuickTradeMode.buy), "99x");
  //       expect(ProfitFormatter.format(0, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.001, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.005, mode: QuickTradeMode.buy), "<1x");
  //       expect(ProfitFormatter.format(0.009, mode: QuickTradeMode.buy), "<1x");
  //       expect(
  //           ProfitFormatter.format(0.00999, mode: QuickTradeMode.buy), "<1x");
  //     });
  //       expect(ProfitFormatter.format(0.01, mode: QuickTradeMode.buy), "1%");
  //       expect(ProfitFormatter.format(0.04, mode: QuickTradeMode.buy), "4%");
  //       expect(ProfitFormatter.format(0.040138, mode: QuickTradeMode.buy),
  //           "4.01%");
  //       expect(ProfitFormatter.format(0.05, mode: QuickTradeMode.buy), "5%");
  //       expect(ProfitFormatter.format(0.10, mode: QuickTradeMode.buy), "10%");
  //       expect(ProfitFormatter.format(0.5, mode: QuickTradeMode.buy), "50%");
  //       expect(ProfitFormatter.format(0.99, mode: QuickTradeMode.buy), "99%");
  //     });
  //       expect(ProfitFormatter.format(0.045, mode: QuickTradeMode.buy), "4.5%");
  //       expect(
  //           ProfitFormatter.format(0.123, mode: QuickTradeMode.buy), "12.3%");
  //       expect(
  //           ProfitFormatter.format(0.1234, mode: QuickTradeMode.buy), "12.34%");
  //     });
  //       expect(ProfitFormatter.format(1.0, mode: QuickTradeMode.buy), "1x");
  //       expect(ProfitFormatter.format(2.0, mode: QuickTradeMode.buy), "2x");
  //       expect(ProfitFormatter.format(2.5, mode: QuickTradeMode.buy), "2.5x");
  //       expect(ProfitFormatter.format(10.0, mode: QuickTradeMode.buy), "10x");
  //       expect(ProfitFormatter.format(10.5, mode: QuickTradeMode.buy), "10.5x");
  //     });
  //   });
  //       expect(ProfitFormatter.format(0, mode: QuickTradeMode.sell), "<1x");
  //       expect(ProfitFormatter.format(0.5, mode: QuickTradeMode.sell), "<1x");
  //       expect(ProfitFormatter.format(1.0, mode: QuickTradeMode.sell), "<1x");
  //     });
  //       expect(ProfitFormatter.format(-0.05, mode: QuickTradeMode.sell), "5%");
  //       expect(ProfitFormatter.format(-0.10, mode: QuickTradeMode.sell), "10%");
  //     });
  //   });
  // });
}
