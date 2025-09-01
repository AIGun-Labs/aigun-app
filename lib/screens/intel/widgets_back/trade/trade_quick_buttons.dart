import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/button.dart';

class TradeQuickButtons extends StatelessWidget {
  final bool isBuy;
  final Function(String) onAmountSelected;

  const TradeQuickButtons({
    super.key,
    required this.isBuy,
    required this.onAmountSelected,
  });

  @override
  Widget build(BuildContext context) {
    final amounts =
        isBuy ? ['0.2', '0.5', '1', '2'] : ['25', '50', '75', '100'];

    return Row(
      children: amounts.map((amount) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: CustomButton(
              height: 36.h,
              text: isBuy ? amount : '$amount%',
              fontSize: 14.sp,
              backgroundColor: AppColors.pageBg,
              textColor: AppColors.black,
              onPressed: () => onAmountSelected(amount),
            ),
          ),
        );
      }).toList(),
    );
  }
}
