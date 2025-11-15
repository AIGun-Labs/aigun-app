import 'package:flutter/material.dart';
import '../themes/themes.dart';

class ColorsHelper {
  /// 根据数字的正负返回对应颜色
  /// 大于 0 返回绿色，等于 0 返回黑色，小于 0 返回红色
  static Color getColorByValueWithZeroColor(dynamic value, {Color? zeroColor}) {
    return ColorsHelper.customGetColorByValue(value, AppColors.septenary,
        AppColors.secondary, zeroColor ?? AppColors.black);
  }

  static Color customGetColorByValue(dynamic value, Color positiveColor,
      Color negativeColor, Color zeroColor) {
    final newValue = double.tryParse(value.toString());

    if (newValue != null && newValue > 0) {
      return positiveColor;
    } else if (newValue != null && newValue < 0) {
      return negativeColor;
    } else {
      return zeroColor;
    }
  }
}
