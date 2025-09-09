import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/sheet/trade.dart';
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
      builder: (context) => TradeSheet(),
    );
  }
}
