import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        color: AppColors.grey2,
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
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.red),
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
        color: AppColors.grey2,
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
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  static Color getBorderColor(BuildContext context) {
    return ThemeUtils.isDark(context)
        ? AppColors.grey4
        : AppColors.outlineLight;
  }

  static Color getFocusedBorderColor(BuildContext context) {
    return ThemeUtils.isDark(context)
        ? AppColors.outlineLight
        : AppColors.outlineFocusedLight;
  }

  static Color getPrefixIconTheme(BuildContext context) {
    return ThemeUtils.isDark(context) ? AppColors.grey2 : AppColors.iconGrey;
  }

  static TextStyle getTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 20.sp,
      color: isDark ? AppColors.white : AppColors.black,
    );
  }

  static Color getHintColor(bool isDark, bool isOutline) {
    if (isOutline) {
      return isDark ? AppColors.grey2 : AppColors.grey2;
    }
    return isDark ? AppColors.bodySmallDark : AppColors.grey2;
  }
}
