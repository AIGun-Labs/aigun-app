import 'package:intl/intl.dart';

class ProfitFormatter {
  static String formatBuy(double profit) {
    if (profit <= 0) {
      return "<1x";
    } else if (profit > 0 && profit < 1) {
      final format = NumberFormat("0%");

      return format.format(profit);
    } else {
      if (profit.truncateToDouble() == profit) {
        return "${profit.truncate()}x";
      } else {
        return "${double.tryParse(profit.toStringAsFixed(1))}x";
      }
    }
  }

  static String formatSell(double profit) {
    if (profit <= 0) {
      return "<1x";
    } else {
      final format = NumberFormat("0%");

      return format.format(profit);
    }
  }

  static String format(double profit, {bool isBuy = true}) {
    if (isBuy) {
      return formatBuy(profit);
    } else {
      return formatSell(profit);
    }
  }
}
