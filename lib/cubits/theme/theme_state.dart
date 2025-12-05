import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

enum AppThemeMode { system, light, dark }

@freezed
sealed class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default(AppThemeMode.light) AppThemeMode themeMode,
    @Default(false) bool isDark,
  }) = _ThemeState;
}
