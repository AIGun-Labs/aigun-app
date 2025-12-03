import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';

class FastSelectButton extends StatelessWidget {
  const FastSelectButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.value,
  });

  final String text;
  final Function(String)? onPressed;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 40.h,
      child: TextButton(
        onPressed: () => onPressed?.call(value),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.card(context),
          foregroundColor: AppColors.textPrimary(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
    );
  }
}
