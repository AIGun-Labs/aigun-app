import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

///

///

class ErrorRetryView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String retryButtonText;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color textColor;
  final Color buttonColor;
  final double textSize;

  const ErrorRetryView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.retryButtonText = '',
    this.buttonWidth,
    this.buttonHeight,
    this.textColor = Colors.grey,
    this.buttonColor = AppColors.quinary,
    this.textSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: TextStyle(color: textColor, fontSize: textSize.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: buttonWidth ?? 200.w,
            height: buttonHeight ?? 40.w,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: AppColors.textPrimary(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              ),
              child: Text(retryButtonText),
            ),
          ),
        ],
      ),
    );
  }
}
