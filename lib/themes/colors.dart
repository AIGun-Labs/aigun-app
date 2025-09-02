import 'package:flutter/material.dart';

class LightThemeColors {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color tertiary = AppColors.tertiary;
  static const Color quaternary = AppColors.quaternary;
  static const Color quinary = AppColors.quinary;
  static const Color background = Color.fromRGBO(255, 255, 255, 1);
  static const Color surface = Color.fromRGBO(245, 245, 245, 1);
  static const Color foreground = Color.fromRGBO(0, 0, 0, 1);
  static const Color border = Color.fromRGBO(224, 224, 224, 1);
  static const Color card = Color.fromRGBO(245, 245, 245, 1);
  static const Color textPrimary = Color.fromRGBO(0, 0, 0, 1);
  static const Color textSecondary = Color.fromRGBO(86, 86, 86, 1);
  static const Color textTertiary = Color.fromRGBO(144, 144, 144, 1);
  static const Color textQuaternary = Color.fromRGBO(169, 169, 169, 1);
  static const Color textQuinary = Color.fromRGBO(222, 222, 222, 1);
  static const Color buttonPrimary = Color.fromRGBO(255, 57, 0, 1);
}

class DarkThemeColors {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color tertiary = AppColors.tertiary;
  static const Color quaternary = AppColors.quaternary;
  static const Color quinary = AppColors.quinary;
  static const Color background = Color.fromRGBO(0, 0, 0, 1); // 修正透明度
  static const Color foreground = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color surface = Color.fromRGBO(42, 42, 42, 1);
  static const Color border = Color.fromRGBO(64, 64, 64, 1); // 深色模式下的边框色
  static const Color card = Color.fromRGBO(42, 42, 42, 1);
  static const Color textPrimary = Color.fromRGBO(255, 255, 255, 1);
  static const Color textSecondary = Color.fromRGBO(222, 222, 222, 1);
  static const Color textTertiary = Color.fromRGBO(169, 169, 169, 1);
  static const Color textQuaternary = Color.fromRGBO(144, 144, 144, 1);
  static const Color textQuinary = Color.fromRGBO(86, 86, 86, 1);
  static const Color buttonPrimary = Color.fromRGBO(255, 57, 0, 1);
}

class AppColors {
  static const Color primary = Color.fromRGBO(255, 57, 0, 1);
  static const Color secondary = Color.fromRGBO(254, 98, 68, 1);
  static const Color tertiary = Color.fromRGBO(255, 240, 0, 1);
  static const Color quaternary = Color.fromRGBO(94, 247, 255, 1);
  static const Color quinary = Color.fromRGBO(16, 153, 251, 1);
  static const Color foregroundBlack = Color.fromRGBO(0, 0, 0, 1);
  static const Color backgroundWhite = Color.fromRGBO(255, 255, 255, 1);

  // static const Color textQuinary = Color.fromRGBO(86, 86, 86, 1);

  static const Color gradientBlueStart = Color.fromRGBO(114, 202, 255, 1);
  static const Color gradientBlueEnd = Color.fromRGBO(24, 94, 255, 1);

  static const Color bgGradientDark = Color.fromRGBO(42, 44, 77, 1);
  static const Color bgGradientDart2 = Color.fromRGBO(161, 161, 161, 1);
  static const Color bgGradientLight = Color.fromRGBO(217, 220, 254, 1);
  static const Color bgGradientLight2 = Color.fromRGBO(250, 250, 250, 1);

  static Color getColor(
    BuildContext context, {
    required Color lightColor,
    required Color darkColor,
  }) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkColor
        : lightColor;
  }

  static Color background(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.background,
        darkColor: DarkThemeColors.background,
      );

  static Color foreground(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.foreground,
        darkColor: DarkThemeColors.foreground,
      );

  static Color surface(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.surface,
        darkColor: DarkThemeColors.surface,
      );

  static Color border(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.border,
        darkColor: DarkThemeColors.border,
      );

  static Color card(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.card,
        darkColor: DarkThemeColors.card,
      );

  static Color textPrimary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.textPrimary,
        darkColor: DarkThemeColors.textPrimary,
      );

  static Color textSecondary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.textSecondary,
        darkColor: DarkThemeColors.textSecondary,
      );

  static Color textTertiary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.textTertiary,
        darkColor: DarkThemeColors.textTertiary,
      );

  static Color textQuaternary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.textQuaternary,
        darkColor: DarkThemeColors.textQuaternary,
      );

  static Color textQuinary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.textQuinary,
        darkColor: DarkThemeColors.textQuinary,
      );

  static Color buttonPrimary(BuildContext context) => getColor(
        context,
        lightColor: LightThemeColors.buttonPrimary,
        darkColor: DarkThemeColors.buttonPrimary,
      );

  static Color bgGradientStart(BuildContext context) => getColor(
        context,
        lightColor: AppColors.bgGradientLight,
        darkColor: AppColors.bgGradientDark,
      );

  static Color bgGradientEnd(BuildContext context) => getColor(
        context,
        lightColor: AppColors.bgGradientLight2,
        darkColor: AppColors.bgGradientDart2,
      );
}
