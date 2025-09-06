import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/sheet/trade.dart';

class ShowSheet {
  static void trade(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => TradeSheet(),
    );
  }
}
