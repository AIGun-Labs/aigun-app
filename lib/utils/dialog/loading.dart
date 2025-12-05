import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../widgets/loading_indicator/index.dart';

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
