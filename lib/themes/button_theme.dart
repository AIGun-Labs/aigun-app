import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class CustomButtonTheme {
  static ButtonStyle getStyle({
    required BuildContext context,
    required double fontSize,
    Color? backgroundColor,
    Color? textColor,
    bool hasShadow = false,
    BorderSide? borderSide,
    bool isBottomButton = false,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    ButtonType type = ButtonType.filled,
    Color? disabledBackgroundColor,
  }) {
    Color defaultBgColor;
    Color defaultTextColor;
    BorderSide? defaultBorderSide;

    switch (type) {
      case ButtonType.filled:
        defaultBgColor = AppColors.background(context);
        defaultTextColor = AppColors.textPrimary(context);
        defaultBorderSide = null;
        break;
      case ButtonType.outlined:
        defaultBgColor = Colors.transparent;
        defaultTextColor = AppColors.textPrimary(context);
        defaultBorderSide = BorderSide(
          color: AppColors.textPrimary(context),
          width: 1.0,
        );
        break;
    }

    Color rippleColor;
    if (backgroundColor == Colors.black) {
      rippleColor = Colors.white.withValues(alpha: .3);
    } else {
      rippleColor = Colors.black.withValues(alpha: .1);
    }

    return ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledBackgroundColor ?? AppColors.textTertiary(context);
        }
        return backgroundColor ?? defaultBgColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        // if (states.contains(WidgetState.disabled)) {
        //   return AppColors.textTertiary(context);
        // }
        // return textColor ?? defaultTextColor;
        return textColor ?? defaultTextColor;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return rippleColor;
        }
        return Colors.transparent;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: isBottomButton ? 16.sp : fontSize.sp,
          color: textColor ?? defaultTextColor,
        ),
      ),
      elevation: WidgetStateProperty.resolveWith<double>(
        (states) => states.contains(WidgetState.pressed)
            ? 0.0
            : (hasShadow ? 2.0 : 0.0),
      ),
      side: WidgetStateProperty.all<BorderSide?>(
        borderSide ?? defaultBorderSide,
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(100.r),
        ),
      ),
    );
  }
}

enum ButtonType { filled, outlined }
