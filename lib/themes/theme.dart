import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: LightThemeColors.primary,
      scaffoldBackgroundColor: LightThemeColors.background,
      colorScheme: const ColorScheme.light(
        primary: LightThemeColors.primary,
        secondary: LightThemeColors.secondary,
        tertiary: LightThemeColors.tertiary,
        surface: LightThemeColors.surface,
      ),
      cardColor: LightThemeColors.card,
      dividerColor: LightThemeColors.border,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: LightThemeColors.background,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: LightThemeColors.textPrimary,
          fontSize: 18.sp,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: LightThemeColors.background,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.black,
        selectedLabelStyle: TextStyle(color: AppColors.black, fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 12.sp,
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.quaternary;
          } else {
            return LightThemeColors.textTertiary;
          }
        }),
        thumbColor: WidgetStateProperty.all(LightThemeColors.background),
        trackOutlineColor: WidgetStateProperty.all(LightThemeColors.background),
      ),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.black.withValues(alpha: 0.8),
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: DarkThemeColors.primary,
      scaffoldBackgroundColor: DarkThemeColors.background,
      colorScheme: const ColorScheme.dark(
        primary: DarkThemeColors.primary,
        secondary: DarkThemeColors.secondary,
      ),
      cardColor: DarkThemeColors.card,
      dividerColor: DarkThemeColors.border,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: DarkThemeColors.background,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: DarkThemeColors.textPrimary,
          fontSize: 18.sp,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DarkThemeColors.background,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: AppColors.black, fontSize: 12.sp),

        unselectedLabelStyle: TextStyle(
          color: DarkThemeColors.textQuaternary,
          fontSize: 12.sp,
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DarkThemeColors.quinary;
          } else {
            return DarkThemeColors.textPrimary;
          }
        }),
        thumbColor: WidgetStateProperty.all(DarkThemeColors.background),
        trackOutlineColor: WidgetStateProperty.all(DarkThemeColors.background),
      ),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.black.withValues(alpha: 0.8),
      ),
    );
  }
}
