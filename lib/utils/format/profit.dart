import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';

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
      return NumericFormatter.formatPercent(profit).removeNegativeSign();
    }
  }

  static String format(dynamic profit,
      {QuickTradeMode mode = QuickTradeMode.buy}) {
    if (mode == QuickTradeMode.buy) {
      return formatBuy(double.tryParse(profit.toString()) ?? 0);
    } else {
      return formatSell(profit);
    }
  }
}
