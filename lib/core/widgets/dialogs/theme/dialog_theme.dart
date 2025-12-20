import 'package:flutter/material.dart';

/// 对话框主题配置
class AppDialogTheme {
  final Color backgroundColor;
  final Color titleColor;
  final Color messageColor;
  final Color primaryColor;
  final Color warningColor;
  final Color errorColor;
  final Color successColor;
  final Color infoColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;

  const AppDialogTheme({
    required this.backgroundColor,
    required this.titleColor,
    required this.messageColor,
    required this.primaryColor,
    required this.warningColor,
    required this.errorColor,
    required this.successColor,
    required this.infoColor,
    this.borderRadius = 16,
    this.contentPadding = const EdgeInsets.all(24),
  });

  /// 亮色主题
  static AppDialogTheme light() => const AppDialogTheme(
        backgroundColor: Colors.white,
        titleColor: Color(0xFF1A1A1A),
        messageColor: Color(0xFF666666),
        primaryColor: Color(0xFF007AFF),
        warningColor: Color(0xFFFF9500),
        errorColor: Color(0xFFFF3B30),
        successColor: Color(0xFF34C759),
        infoColor: Color(0xFF5856D6),
      );

  /// 暗色主题
  static AppDialogTheme dark() => const AppDialogTheme(
        backgroundColor: Color(0xFF2C2C2E),
        titleColor: Colors.white,
        messageColor: Color(0xFFE5E5EA),
        primaryColor: Color(0xFF0A84FF),
        warningColor: Color(0xFFFF9F0A),
        errorColor: Color(0xFFFF453A),
        successColor: Color(0xFF30D158),
        infoColor: Color(0xFF5E5CE6),
        borderRadius: 16,
      );

  /// 从 context 获取主题
  static AppDialogTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark() : light();
  }
}
