import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.pirmary,
      scaffoldBackgroundColor: AppColors.white, // 设置页面背景颜色为白色
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        onPrimary: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.black,
        secondary: AppColors.secondary,
      ),
      cardColor: AppColors.white,
      dividerColor: AppColors.grey2,
      textTheme: const TextTheme(
        // 黑色字体颜色
        bodyMedium: TextStyle(color: AppColors.black),
        // 灰色字体颜色
        bodySmall: TextStyle(color: AppColors.bodySmall),
        // 白色标题颜色
        titleMedium: TextStyle(color: AppColors.grey2),
        // 灰色字体颜色
        titleSmall: TextStyle(color: AppColors.bodySmall),
        // 黑色背景白色字体颜色
        headlineSmall: TextStyle(color: AppColors.textOnBlack),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: AppColors.white, // 设置AppBar颜色为白色
        surfaceTintColor: Colors.transparent, // 防止滚动时颜色变化
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 18.sp,
        ), // 设置AppBar标题颜色
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48.w),

          disabledForegroundColor: AppColors.white, // 禁用状态文字颜色
          elevation: 2, // 按钮阴影
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // 圆角
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black, // 设置文本按钮的字体颜色为黑色
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.black, // 设置OutlinedButton的字体颜色为白色
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(
          color: AppColors.grey2,
        ),
        checkColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.white,
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.purple;
            }
            return AppColors.white;
          },
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white, // 设置导航栏颜色为白色
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // 防止选中时跳动
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.black,
        selectedLabelStyle: TextStyle(color: AppColors.white, fontSize: 12.sp),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.white, // 设置BottomSheet背景颜色为白色
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    // return buildLightTheme();

    return ThemeData.dark().copyWith(
      primaryColor: AppColors.pirmary,
      scaffoldBackgroundColor: AppColors.pageBgDark, // 设置页面背景颜色为黑色
      colorScheme: const ColorScheme.dark(
        primary: AppColors.white,
        onPrimary: AppColors.black,
        surface: AppColors.black,
        onSurface: AppColors.white,
      ),
      cardColor: AppColors.grey4,
      dividerColor: AppColors.grey4,
      textTheme: const TextTheme(
        // 黑色字体颜色
        bodyMedium: TextStyle(color: AppColors.white),
        // 灰色字体颜色
        bodySmall: TextStyle(color: AppColors.bodySmallDark),
        // 白色标题颜色
        titleMedium: TextStyle(color: AppColors.white),
        // 灰色字体颜色
        titleSmall: TextStyle(color: AppColors.bodySmall),
        // 黑色背景白色字体颜色
        headlineSmall: TextStyle(color: AppColors.textOnBlack),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: AppColors.black, // 设置AppBar颜色为黑色
        surfaceTintColor: Colors.transparent, // 防止滚动时颜色变化
        titleTextStyle:
            TextStyle(color: AppColors.white, fontSize: 18.sp), // 设置AppBar标题颜色
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48.w),
          disabledBackgroundColor: AppColors.grey4, // 禁用状态背景色
          disabledForegroundColor: AppColors.grey3, // 禁用状态文字颜色
          elevation: 2, // 按钮阴影
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // 圆角
          ),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: const BoxDecoration(
          color: AppColors.indicatorColor,
        ),
        labelColor: AppColors.pirmary,
        unselectedLabelColor: AppColors.white,
        labelStyle: TextStyle(
          color: AppColors.pirmary,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.white,
        ),
        indicatorColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black, // 设置文本按钮的字体颜色为黑色
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white, // 设置OutlinedButton的字体颜色为白色
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(
          color: AppColors.grey4,
        ),
        checkColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.black,
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.purple;
            }
            return AppColors.black;
          },
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.pageBgDark, // 设置导航栏颜色为黑色
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // 防止选中时跳动
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        selectedLabelStyle:
            TextStyle(color: AppColors.bodySmallDark, fontSize: 12.sp),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.grey4, // 设置BottomSheet背景颜色为白色
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.grey4,
      ),
    );
  }

  static Color pageBg2(BuildContext context) {
    return ThemeUtils.isDark(context)
        ? AppColors.pageBg2Dark
        : AppColors.pageBg;
  }
}
