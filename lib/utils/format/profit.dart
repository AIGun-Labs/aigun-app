import 'package:aigun_app/enums/quick_trade_mode.dart';

import 'numeric.dart';

class ProfitFormatter {
  static String formatBuy(double profit) {
    if (profit < 0.01) {
      return "<1x";
    } else if (profit < 1) {
      double percentValue = profit * 100;
      return NumericFormatter.formatPercent(percentValue, keepDecimal: false);
    } else {
      if (profit.truncateToDouble() == profit) {
        return "${profit.truncate()}x";
      } else {
        return "${double.tryParse(profit.toStringAsFixed(1))}x";
      }
    }
  }

  static String formatSell(double profit) {
    if (profit >= 0) {
      return "<1x";
    } else {
      double percentValue = profit.abs() * 100;

      if (percentValue < 1) {
        return "<1x";
      }
      return NumericFormatter.formatPercent(percentValue, keepDecimal: false);
    }
  }

  static String format(
    dynamic profit, {
    QuickTradeMode mode = QuickTradeMode.buy,
  }) {
    double profitValue = double.tryParse(profit.toString()) ?? 0;

    if (mode == QuickTradeMode.buy) {
      return formatBuy(profitValue);
    } else {
      return formatSell(profitValue);
    }
  }
}
