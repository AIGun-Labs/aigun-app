import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../index.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final _platformDispatcher = WidgetsBinding.instance.platformDispatcher;
  static const String _themeModeKey = 'theme_mode';
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(const ThemeState()) {
    _loadSavedTheme();
    _initPlatformBrightnessListener();
  }

  /// 加载保存的主题偏好
  Future<void> _loadSavedTheme() async {
    try {
      final themeModeIndex =
          _prefs.getInt(_themeModeKey) ?? AppThemeMode.system.index;
      final themeMode = AppThemeMode.values[themeModeIndex];

      final isDark = _calculateIsDark(themeMode);
      emit(state.copyWith(themeMode: themeMode, isDark: isDark));
    } catch (e) {
      // 如果加载失败，使用默认设置
      final isDark = _platformDispatcher.platformBrightness == Brightness.dark;
      emit(state.copyWith(themeMode: AppThemeMode.system, isDark: isDark));
    }
  }

  /// 监听系统主题变化
  void _initPlatformBrightnessListener() {
    _platformDispatcher.onPlatformBrightnessChanged = () {
      if (state.themeMode == AppThemeMode.system) {
        final isDark =
            _platformDispatcher.platformBrightness == Brightness.dark;
        emit(state.copyWith(isDark: isDark));
      }
    };
  }

  /// 计算当前是否为深色模式
  bool _calculateIsDark(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.system:
        return _platformDispatcher.platformBrightness == Brightness.dark;
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
    }
  }

  /// 切换主题模式
  Future<void> setThemeMode(AppThemeMode themeMode) async {
    try {
      await _prefs.setInt(_themeModeKey, themeMode.index);

      final isDark = _calculateIsDark(themeMode);
      emit(state.copyWith(themeMode: themeMode, isDark: isDark));
    } catch (e) {
      // 处理保存失败的情况
      debugPrint('Failed to save theme preference: $e');
    }
  }

  /// 快速切换深浅模式（在浅色和深色之间切换）
  Future<void> toggleTheme() async {
    final newThemeMode = state.isDark ? AppThemeMode.light : AppThemeMode.dark;
    await setThemeMode(newThemeMode);
  }

  /// 获取 Flutter ThemeMode
  ThemeMode get flutterThemeMode {
    switch (state.themeMode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  @override
  Future<void> close() {
    _platformDispatcher.onPlatformBrightnessChanged = null;
    return super.close();
  }
}
