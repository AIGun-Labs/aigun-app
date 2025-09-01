import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/theme.dart';

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
    ButtonType type = ButtonType.filled,
  }) {
    final isDark = ThemeUtils.isDark(context);

    // 默认样式
    Color defaultBgColor;
    Color defaultTextColor;
    BorderSide? defaultBorderSide;

    switch (type) {
      case ButtonType.filled:
        defaultBgColor = isDark ? AppColors.grey1 : Colors.white;
        defaultTextColor = isDark ? Colors.black : Colors.black;
        defaultBorderSide = null;
        break;
      case ButtonType.outlined:
        defaultBgColor = Colors.transparent;
        defaultTextColor = isDark ? Colors.white : Colors.black;
        defaultBorderSide = BorderSide(
          color: isDark ? Colors.white : Colors.black,
          width: 1.0,
        );
        break;
    }

    // 确定波纹颜色
    Color rippleColor;
    if (backgroundColor == Colors.black) {
      // 黑色按钮使用白色波纹
      rippleColor = Colors.white.withValues(alpha: .3);
    } else {
      // 其他颜色按钮使用深色波纹
      rippleColor = Colors.black.withValues(alpha: .1);
    }

    return ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark ? AppColors.grey4 : const Color(0xFFE2E2E2);
          }
          return backgroundColor ?? defaultBgColor;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark ? AppColors.bodySmallDark : const Color(0xFF888888);
          }
          return textColor ?? defaultTextColor;
        },
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return rippleColor;
          }
          return Colors.transparent;
        },
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: isBottomButton ? 16.sp : fontSize.sp,
          color: textColor,
        ),
      ),
      elevation: WidgetStateProperty.resolveWith<double>(
        (states) => states.contains(WidgetState.pressed)
            ? 0.0
            : (hasShadow ? 2.0 : 0.0),
      ),
      side:
          WidgetStateProperty.all<BorderSide?>(borderSide ?? defaultBorderSide),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(100.r),
        ),
      ),
    );
  }
}

enum ButtonType {
  filled,
  outlined,
}
