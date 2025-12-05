import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';

class ButtonAmountGroup extends StatelessWidget {
  const ButtonAmountGroup({
    super.key,
    required this.amounts,
    required this.onAmountSelected,
  });
  final List<String> amounts;
  final Function(String) onAmountSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 10.w,
      children: amounts.map((amount) {
        return Expanded(
          child: TextButton(
            onPressed: () => onAmountSelected(amount),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.all(10.r)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              )),
              foregroundColor:
                  WidgetStateProperty.all(AppColors.textPrimary(context)),
              textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: 18.sp,
              )),
              backgroundColor: WidgetStateProperty.all(AppColors.card(context)),
            ),
            child: Text(amount),
          ),
        );
      }).toList(),
    );
  }
}
