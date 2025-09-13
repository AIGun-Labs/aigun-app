import 'package:flutter/services.dart';

/// 输入格式化器工具类
/// 提供数字输入验证和格式化的功能
class InputFormatters {
  /// 创建数字输入格式化器（支持整数和小数）
  /// [maxDecimalPlaces] 最大小数位数，默认为8位
  static List<TextInputFormatter> numberInputFormatters({
    int maxDecimalPlaces = 8,
  }) {
    return [
      // 允许数字和小数点
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      // 自定义格式化器处理小数点和输入验证
      TextInputFormatter.withFunction((oldValue, newValue) {
        return _formatNumberInput(newValue, oldValue, maxDecimalPlaces);
      }),
    ];
  }

  /// 创建整数输入格式化器
  /// 只允许输入整数
  static List<TextInputFormatter> integerInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
    ];
  }

  /// 创建金额输入格式化器（支持整数和小数）
  /// [maxDecimalPlaces] 最大小数位数，默认为2位
  /// [allowNegative] 是否允许负数，默认为false
  static List<TextInputFormatter> amountInputFormatters({
    int maxDecimalPlaces = 2,
    bool allowNegative = false,
  }) {
    final pattern = allowNegative ? r'^-?\d*\.?\d*$' : r'^\d*\.?\d*$';

    return [
      FilteringTextInputFormatter.allow(
          RegExp(allowNegative ? r'[0-9.-]' : r'[0-9.]')),
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isEmpty) {
          return newValue;
        }

        // 验证基本格式
        if (!RegExp(pattern).hasMatch(newValue.text)) {
          return oldValue;
        }

        // 处理负数和小数点
        final text = newValue.text;
        final parts = text.replaceFirst('-', '').split('.');

        if (parts.length > 2) {
          return oldValue;
        }

        // 限制小数位数
        if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
          final integerPart = text.contains('-') ? '-${parts[0]}' : parts[0];
          final truncated =
              '$integerPart.${parts[1].substring(0, maxDecimalPlaces)}';
          return TextEditingValue(
            text: truncated,
            selection: TextSelection.collapsed(offset: truncated.length),
          );
        }

        return newValue;
      }),
    ];
  }

  /// 创建密码输入格式化器
  /// 只允许字母、数字和常见符号
  static List<TextInputFormatter> passwordInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{}|;:,.<>?]')),
    ];
  }

  /// 创建用户名输入格式化器
  /// 只允许字母、数字、下划线和连字符
  static List<TextInputFormatter> usernameInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),
      // 限制长度
      LengthLimitingTextInputFormatter(50),
    ];
  }

  /// 创建邮箱输入格式化器
  /// 允许邮箱常用的字符
  static List<TextInputFormatter> emailInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
      LengthLimitingTextInputFormatter(254), // RFC 5321 邮箱长度限制
    ];
  }

  /// 内部方法：格式化数字输入
  static TextEditingValue _formatNumberInput(
    TextEditingValue newValue,
    TextEditingValue oldValue,
    int maxDecimalPlaces,
  ) {
    // 空值直接返回
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final text = newValue.text;

    // 处理以小数点开头的情况，自动添加前导零
    if (text == '.') {
      return const TextEditingValue(
        text: '0.',
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    // 防止多个小数点
    final parts = text.split('.');
    if (parts.length > 2) {
      return oldValue;
    }

    // 如果有小数部分，限制小数位数
    if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
      final truncated =
          '${parts[0]}.${parts[1].substring(0, maxDecimalPlaces)}';
      return TextEditingValue(
        text: truncated,
        selection: TextSelection.collapsed(offset: truncated.length),
      );
    }

    // 验证是否为有效数字格式
    // ^\d*\.?\d*$ 表示：可选的数字 + 可选的小数点 + 可选的数字
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}
