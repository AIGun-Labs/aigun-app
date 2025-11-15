import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme.dart';
import 'colors.dart';

class InputTheme {
  static InputDecoration plainInputDecorationTheme(BuildContext context,
      {BorderRadius? borderRadius, Color? fillColor}) {
    final radius = borderRadius ?? BorderRadius.circular(100.r);
    final isDark = ThemeUtils.isDark(context);

    final color = fillColor ??
        (isDark
            ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.6)
            : Theme.of(context).colorScheme.surface);

    return InputDecoration(
      filled: true,
      fillColor: color,
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h),
      hintStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textTertiary(context),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  static InputDecoration outlinedInputDecorationTheme(BuildContext context,
      {BorderRadius? borderRadius, Color? fillColor}) {
    final radius = borderRadius ?? BorderRadius.circular(100.r);

    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
      hintStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textTertiary(context),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: getBorderColor(context),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: getFocusedBorderColor(context),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  static Color getBorderColor(BuildContext context) {
    return AppColors.border(context);
  }

  static Color getFocusedBorderColor(BuildContext context) {
    return AppColors.border(context);
  }

  static Color getPrefixIconTheme(BuildContext context) {
    return AppColors.textTertiary(context);
  }

  static TextStyle getTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 20.sp,
      color: AppColors.textPrimary(context),
    );
  }

  static Color getHintColor(BuildContext context, bool isOutline) {
    if (isOutline) {
      return AppColors.textTertiary(context);
    }
    return AppColors.textTertiary(context);
  }
}
