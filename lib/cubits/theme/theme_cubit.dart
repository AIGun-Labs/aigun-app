import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final _platformDispatcher = WidgetsBinding.instance.platformDispatcher;

  // ThemeCubit()
  //     : super(ThemeState(
  //           isDark:
  //               WidgetsBinding.instance.platformDispatcher.platformBrightness ==
  //                   Brightness.dark)) {
  //   _initPlatformBrightnessListener();
  // }

  ThemeCubit() : super(const ThemeState(isDark: true)) {
    _initPlatformBrightnessListener();
  }

  void _initPlatformBrightnessListener() {
    _platformDispatcher.onPlatformBrightnessChanged = () {
      final isDark = _platformDispatcher.platformBrightness == Brightness.dark;
      changeTheme(isDark);
    };
  }

  void changeTheme(bool isDark) {
    emit(state.copyWith(isDark: isDark));
  }

  @override
  Future<void> close() {
    _platformDispatcher.onPlatformBrightnessChanged = null;
    return super.close();
  }
}
