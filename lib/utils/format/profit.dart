import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';

class ProfitFormatter {
  static String formatBuy(double profit) {
    // 小于 0.01 (即小于 1%) 显示 <1x
    if (profit < 0.01) {
      return "<1x";
    }
    // 0.01 到 1 之间显示百分比
    else if (profit < 1) {
      double percentValue = profit * 100;
      return NumericFormatter.formatPercent(percentValue, keepDecimal: false);
    }
    // 大于等于 1 显示倍数
    else {
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
      // 转换为正数百分比（例如 -0.05 -> 5%）
      double percentValue = profit.abs() * 100;
      // 如果小于 1%，显示 <1x
      if (percentValue < 1) {
        return "<1x";
      }
      return NumericFormatter.formatPercent(percentValue, keepDecimal: false);
    }
  }

  static String format(dynamic profit,
      {QuickTradeMode mode = QuickTradeMode.buy}) {
    // 统一转换为 double
    double profitValue = double.tryParse(profit.toString()) ?? 0;

    if (mode == QuickTradeMode.buy) {
      return formatBuy(profitValue);
    } else {
      return formatSell(profitValue);
    }
  }
}
