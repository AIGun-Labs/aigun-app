import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';

class SnackBarUtils {
  static void showSimpleSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(color: AppColors.textPrimary(context))),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.background(context),
      ),
    );
  }
}
