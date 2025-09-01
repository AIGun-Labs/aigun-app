import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

enum AppThemeMode {
  system, // 跟随系统
  light, // 浅色模式
  dark, // 深色模式
}

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default(AppThemeMode.light) AppThemeMode themeMode,
    @Default(false) bool isDark, // 当前实际的主题状态
  }) = _ThemeState;
}
