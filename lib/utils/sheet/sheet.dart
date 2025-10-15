import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/sheet/upgrade.dart';
import 'package:flutter_aigun/widgets/sheet/trade.dart';
import 'package:flutter_aigun/features/update/domain/entities/update_info.dart'
    as flutter_aigun;
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSheet {
  static void trade(BuildContext context) {
    // 在打开 trade sheet 之前清除状态
    context.read<QuickTradeCubit>().clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => const TradeSheet(),
    );
  }

  static void common(BuildContext context, Widget widget) {
    context.read<TradeCubit>().clear();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.background(context),
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          maxWidth: double.infinity,
        ),
        builder: (context) => widget);
  }

  static void upgrade(BuildContext context,
      {required flutter_aigun.UpdateInfo info, required bool force}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: !force,
      enableDrag: !force,
      backgroundColor: AppColors.background(context),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => UpgradeSheet(info: info, force: force),
    );
  }
}
