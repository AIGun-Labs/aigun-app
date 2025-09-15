import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';

class LoadingDialogHeper {
  static void showLoadingDialog(BuildContext context,
      {bool dismissible = false}) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: LoadingIndicator(
              color: AppColors.quinary,
            ),
          );
        });
  }

  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context);
  }
}
