import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/index.dart';
import '../../themes/colors.dart';
import '../../widgets/sheet/quick_swap/swap.dart';
import '../toast/trade_status_toast.dart';

class ShowSheet {
  static void trade(BuildContext context) {
    context.read<QuickTradeCubit>().clear();

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
    context.read<TradeCubit>().clear();

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
