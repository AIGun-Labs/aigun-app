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
        selectedItemColor: LightThemeColors.foreground,
        unselectedItemColor: LightThemeColors.textQuaternary,
        selectedLabelStyle:
            TextStyle(color: LightThemeColors.foreground, fontSize: 12.sp),
        unselectedLabelStyle:
            TextStyle(color: LightThemeColors.textQuaternary, fontSize: 12.sp),
      ),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((states) {
            // 如果状态包含选中，则返回轨道颜色
            if (states.contains(MaterialState.selected)) {
              // 开启状态的轨道颜色
              return LightThemeColors.quinary;
            } else {
              // 关闭状态的轨道颜色
              return LightThemeColors.textQuinary;
            }
          }),
          thumbColor: MaterialStateProperty.all(LightThemeColors.background),
          trackOutlineColor:
              MaterialStateProperty.all(LightThemeColors.background)),
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
            TextStyle(color: DarkThemeColors.foreground, fontSize: 12.sp),

        unselectedLabelStyle:
            TextStyle(color: DarkThemeColors.textQuaternary, fontSize: 12.sp),
      ),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((states) {
            // 如果状态包含选中，则返回轨道颜色
            if (states.contains(MaterialState.selected)) {
              // 开启状态的轨道颜色
              return DarkThemeColors.quinary;
            } else {
              // 关闭状态的轨道颜色
              return DarkThemeColors.textQuinary;
            }
          }),
          thumbColor: MaterialStateProperty.all(DarkThemeColors.background),
          trackOutlineColor:
              MaterialStateProperty.all(DarkThemeColors.background)),
    );
  }
}
