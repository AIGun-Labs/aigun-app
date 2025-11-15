import 'package:flutter/material.dart';
import '../app.dart';
import '../themes/themes.dart';

class SnackBarUtils {
  static void showSimpleSnackBar(BuildContext context, String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(color: AppColors.textPrimary(context))),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.background(context),
      ),
    );
  }
}
