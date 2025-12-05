import 'package:flutter/material.dart';

import '../../themes/colors.dart';
import '../../widgets/sheet/trade.dart';
import '../toast/trade_status_toast.dart';

class ShowSheet {
  static void trade(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => const TradeSheet(),
    ).whenComplete(() {
      TradeStatusToastUtils.dismissToast();
    });
  }

  static void common(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => widget,
    );
  }
}
