import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: LightThemeColors.background, // 设置AppBar颜色为白色
        surfaceTintColor: Colors.transparent, // 防止滚动时颜色变化
        titleTextStyle: TextStyle(
          color: LightThemeColors.textPrimary,
          fontSize: 18.sp,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: LightThemeColors.background, // 设置导航栏颜色为白色
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // 防止选中时跳动
        selectedItemColor: LightThemeColors.primary,
        unselectedItemColor: LightThemeColors.textQuaternary,
        selectedLabelStyle:
            TextStyle(color: LightThemeColors.primary, fontSize: 12.sp),
        unselectedLabelStyle:
            TextStyle(color: LightThemeColors.textQuaternary, fontSize: 12.sp),
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: DarkThemeColors.primary,
      scaffoldBackgroundColor: DarkThemeColors.background, // 设置页面背景颜色为黑色
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
        backgroundColor: DarkThemeColors.background, // 设置AppBar颜色为黑色
        surfaceTintColor: Colors.transparent, // 防止滚动时颜色变化
        titleTextStyle: TextStyle(
            color: DarkThemeColors.textPrimary,
            fontSize: 18.sp), // 设置AppBar标题颜色
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DarkThemeColors.background, // 设置导航栏颜色为黑色
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // 防止选中时跳动
        selectedLabelStyle:
            TextStyle(color: DarkThemeColors.primary, fontSize: 12.sp),

        unselectedLabelStyle:
            TextStyle(color: DarkThemeColors.textQuaternary, fontSize: 12.sp),
      ),
    );
  }
}
