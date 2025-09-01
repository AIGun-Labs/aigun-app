import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/theme.dart';

class TabsTheme {
  static Color bgColor(BuildContext context) {
    return ThemeUtils.isDark(context) ? AppColors.pageBgDark : AppColors.white;
  }
}
