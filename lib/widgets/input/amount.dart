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
    this.maxDecimalPlaces = 8,
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

    String cleanValue = value.replaceAll(',', '');

    List<String> dotSplit = cleanValue.split('.');
    if (dotSplit.length > 2) {
      cleanValue = '${dotSplit[0]}.${dotSplit.sublist(1).join('')}';
    }

    if (!RegExp(r'^\d*\.?\d*$').hasMatch(cleanValue)) {
      return value;
    }

    if (cleanValue == '.') return cleanValue;

    List<String> parts = cleanValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    if (widget.maxDecimalPlaces != null &&
        decimalPart.length > widget.maxDecimalPlaces!) {
      decimalPart = decimalPart.substring(0, widget.maxDecimalPlaces!);
    }

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

    if (parts.length > 1) {
      return decimalPart.isEmpty
          ? '$formattedInteger.'
          : '$formattedInteger.$decimalPart';
    } else {
      return formattedInteger;
    }
  }

  String _getRawValue(String formattedValue) {
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

          int cursorPosition = newValue.selection.end;
          int oldCommas =
              oldValue.text
                  .substring(0, oldValue.selection.end)
                  .split(',')
                  .length -
              1;
          int newCommas =
              formatted.substring(0, cursorPosition).split(',').length - 1;

          int adjustedCursorPosition = cursorPosition + (newCommas - oldCommas);

          if (newValue.text.length < oldValue.text.length) {
            String beforeCursor = formatted.substring(
              0,
              adjustedCursorPosition.clamp(0, formatted.length),
            );
            int commasBeforeCursor = beforeCursor.split(',').length - 1;

            String oldBeforeCursor = oldValue.text.substring(
              0,
              oldValue.selection.end,
            );
            int oldCommasBeforeCursor = oldBeforeCursor.split(',').length - 1;

            adjustedCursorPosition =
                cursorPosition + (commasBeforeCursor - oldCommasBeforeCursor);
          }

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
