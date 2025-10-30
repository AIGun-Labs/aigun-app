import 'package:flutter_aigun/cubits/index.dart';

class ProfitFormatter {
  static String formatBuy(double profit) {
    if (profit <= 0 || profit > 0 && profit < 1) {
      return "<1x";
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
      final percentage = (profit.abs() * 100).round();
      return "$percentage%";
    }
  }

  static String format(double profit,
      {QuickTradeMode mode = QuickTradeMode.buy}) {
    if (mode == QuickTradeMode.buy) {
      return formatBuy(profit);
    } else {
      return formatSell(profit);
    }
  }
}
