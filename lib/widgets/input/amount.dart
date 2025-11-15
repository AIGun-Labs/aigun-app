import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../themes/themes.dart';

class InputAmount extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxDecimalPlaces;
  final Function(String)? onChanged;
  final bool enabled;

  const InputAmount({
    super.key,
    this.controller,
    this.hintText,
    this.maxDecimalPlaces = 8, // 默认最多8位小数
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<InputAmount> createState() => _InputAmountState();
}

class _InputAmountState extends State<InputAmount> {
  late TextEditingController _amountController;
  final NumberFormat _numberFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _amountController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _amountController.dispose();
    }
    super.dispose();
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return '';

    // 移除所有逗号
    String cleanValue = value.replaceAll(',', '');

    // 防止多个小数点
    List<String> dotSplit = cleanValue.split('.');
    if (dotSplit.length > 2) {
      // 如果有多个小数点，只保留第一个
      cleanValue = '${dotSplit[0]}.${dotSplit.sublist(1).join('')}';
    }

    // 检查是否为有效数字格式
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(cleanValue)) {
      return value;
    }

    // 如果只是小数点开头，保持原样
    if (cleanValue == '.') return cleanValue;

    // 分离整数和小数部分
    List<String> parts = cleanValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // 限制小数位数
    if (widget.maxDecimalPlaces != null &&
        decimalPart.length > widget.maxDecimalPlaces!) {
      decimalPart = decimalPart.substring(0, widget.maxDecimalPlaces!);
    }

    // 格式化整数部分（添加千位分隔符）
    String formattedInteger = '';
    if (integerPart.isNotEmpty && integerPart != '0') {
      int? number = int.tryParse(integerPart);
      if (number != null) {
        formattedInteger = _numberFormat.format(number);
      } else {
        formattedInteger = integerPart;
      }
    } else {
      formattedInteger = integerPart.isEmpty ? '0' : integerPart;
    }

    // 组合结果
    if (parts.length > 1) {
      // 有小数点的情况
      return decimalPart.isEmpty
          ? '$formattedInteger.'
          : '$formattedInteger.$decimalPart';
    } else {
      return formattedInteger;
    }
  }

  String _getRawValue(String formattedValue) {
    // 移除千位分隔符，返回纯数字字符串
    return formattedValue.replaceAll(',', '');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      enabled: widget.enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) {
            widget.onChanged?.call('');
            return newValue;
          }

          String formatted = _formatNumber(newValue.text);

          // 计算新的光标位置
          int cursorPosition = newValue.selection.end;
          int oldCommas = oldValue.text
                  .substring(0, oldValue.selection.end)
                  .split(',')
                  .length -
              1;
          int newCommas =
              formatted.substring(0, cursorPosition).split(',').length - 1;

          // 调整光标位置以适应新增或删除的逗号
          int adjustedCursorPosition = cursorPosition + (newCommas - oldCommas);

          // 如果用户在删除内容，需要特殊处理光标位置
          if (newValue.text.length < oldValue.text.length) {
            // 计算删除位置前的逗号数量差异
            String beforeCursor = formatted.substring(
                0, adjustedCursorPosition.clamp(0, formatted.length));
            int commasBeforeCursor = beforeCursor.split(',').length - 1;

            String oldBeforeCursor =
                oldValue.text.substring(0, oldValue.selection.end);
            int oldCommasBeforeCursor = oldBeforeCursor.split(',').length - 1;

            adjustedCursorPosition =
                cursorPosition + (commasBeforeCursor - oldCommasBeforeCursor);
          }

          // 通知父组件数值变化
          widget.onChanged?.call(_getRawValue(formatted));

          return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(
              offset: adjustedCursorPosition.clamp(0, formatted.length),
            ),
          );
        }),
      ],
      style: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: widget.enabled ? null : AppColors.textTertiary(context),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText ?? '0.00',
        hintStyle: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textTertiary(context),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
