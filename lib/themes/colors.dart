import 'package:flutter/material.dart';

class LightThemeColors {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color tertiary = AppColors.tertiary;
  static const Color quaternary = AppColors.quaternary;
  static const Color quinary = AppColors.quinary;
  static const Color senary = AppColors.senary;

  static const Color background = Color.fromRGBO(255, 255, 255, 1);
  static const Color foreground = Color.fromRGBO(0, 0, 0, 1);
  static const Color surface = Color.fromRGBO(243, 243, 243, 1);

  //
  static const Color border = Color.fromRGBO(221, 227, 225, 1);
  static const Color borderSecondary = Color.fromRGBO(235, 235, 235, 1);
  static const Color borderTertiary = Color.fromRGBO(29, 171, 226, 1);
  static const Color card = Color.fromRGBO(245, 245, 245, 1);
  static const Color shimmerBaseColor = Color.fromRGBO(245, 245, 245, 1);
  static const Color shimmerHighlightColor = Color.fromRGBO(221, 227, 225, 1);

  static const Color textPrimary = Color.fromRGBO(0, 0, 0, 1);
  static const Color textSecondary = Color.fromRGBO(86, 86, 86, 1);
  static const Color textTertiary = Color.fromARGB(255, 144, 144, 144);
  static const Color textQuaternary = Color.fromRGBO(183, 183, 183, 1);
  // static const Color textQuinary = Color.fromRGBO(222, 222, 222, 1);
  static const Color buttonPrimary = AppColors.primary;
}

class DarkThemeColors {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color tertiary = AppColors.tertiary;
  static const Color quaternary = AppColors.quaternary;
  static const Color quinary = AppColors.quinary;
  static const Color senary = AppColors.senary;
  static const Color background = Color.fromRGBO(0, 0, 0, 1);
  static const Color foreground = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color shimmerBaseColor = Color.fromRGBO(42, 42, 42, 1);
  static const Color shimmerHighlightColor = Color.fromRGBO(62, 62, 62, 1);

  static const Color surface = Color.fromRGBO(42, 42, 42, 1);

  static const Color border = Color.fromRGBO(221, 227, 225, 1);
  static const Color borderSecondary = Color.fromRGBO(235, 235, 235, 1);
  static const Color borderTertiary = Color.fromRGBO(29, 171, 226, 1);

  static const Color card = Color.fromRGBO(42, 42, 42, 1);

  static const Color textPrimary = Color.fromRGBO(255, 255, 255, 1);
  static const Color textSecondary = Color.fromRGBO(222, 222, 222, 1);
  static const Color textTertiary = Color.fromRGBO(169, 169, 169, 1);
  static const Color textQuaternary = Color.fromRGBO(144, 144, 144, 1);
  // static const Color textQuinary = Color.fromRGBO(86, 86, 86, 1);

  static const Color buttonPrimary = AppColors.primary;
}

class AppColors {
  static const Color primary = Color(0xFF5EF7FF); // #5EF7FF
  static const Color primary2 = Color(0xFF000000); // #000000
  static const Color secondary = Color(0xFFFE6256); // #FE6256
  static const Color tertiary = Color(0xFFFFF000); // #FFF000
  static const Color quaternary = Color(0xFF1099FB); // #1099FB
  static const Color quinary = Color(0xFFE2FDFE); // #E2FDFE
  static const Color senary = Color(0xFFF5F5F5); // #F5F5F5
  static const Color septenary = Color(0xFF52C41A); // #52C41A

  static const Color tipColor = Color.fromRGBO(82, 196, 26, 1); // #FE6256

  static const Color foregroundBlack = Color.fromRGBO(0, 0, 0, 1);
  static const Color backgroundWhite = Color.fromRGBO(255, 255, 255, 1);

  // static const Color textQuinary = Color.fromRGBO(86, 86, 86, 1);

  static const Color gradientBlueStart = Color.fromRGBO(114, 202, 255, 1);
  static const Color gradientBlueEnd = Color.fromRGBO(24, 94, 255, 1);

  static const Color bgGradientDark = Color.fromRGBO(42, 44, 77, 1);
  static const Color bgGradientDart2 = Color.fromRGBO(161, 161, 161, 1);
  static const Color bgGradientLight = Color.fromRGBO(217, 220, 254, 1);
  static const Color bgGradientLight2 = Color.fromRGBO(250, 250, 250, 1);

  static const Color tokenPlaceholderColor = Color.fromRGBO(38, 130, 240, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color buttonGradientStart = Color.fromRGBO(50, 68, 255, 1);
  static const Color buttonGradientEnd = Color.fromRGBO(152, 97, 250, 1);

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

  static Color borderSecondary(BuildContext context) => getColor(
    context,
    lightColor: LightThemeColors.borderSecondary,
    darkColor: DarkThemeColors.borderSecondary,
  );

  static Color borderTertiary(BuildContext context) => getColor(
    context,
    lightColor: LightThemeColors.borderTertiary,
    darkColor: DarkThemeColors.borderTertiary,
  );

  static Color card(BuildContext context) => getColor(
    context,
    lightColor: LightThemeColors.card,
    darkColor: DarkThemeColors.card,
  );

  static Color shimmerBaseColor(BuildContext context) => getColor(
    context,
    lightColor: LightThemeColors.shimmerBaseColor,
    darkColor: DarkThemeColors.shimmerBaseColor,
  );

  static Color shimmerHighlightColor(BuildContext context) => getColor(
    context,
    lightColor: LightThemeColors.shimmerHighlightColor,
    darkColor: DarkThemeColors.shimmerHighlightColor,
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

  // static Color textQuinary(BuildContext context) => getColor(
  //       context,
  //       lightColor: LightThemeColors.textQuinary,
  //       darkColor: DarkThemeColors.textQuinary,
  //     );

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
