import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors.dart';

/// 通用错误重试视图组件
///
/// 在网络错误或其他需要重试操作的场景下使用
///
/// [errorMessage] 错误提示文本
/// [onRetry] 重试按钮点击回调
/// [retryButtonText] 重试按钮文字，默认为"重试"
/// [buttonWidth] 按钮宽度，默认为200.w
/// [buttonHeight] 按钮高度，默认为40.w
/// [textColor] 错误文本颜色，默认为AppColors.grey3
/// [buttonColor] 按钮背景色，默认为AppColors.pirmary
/// [textSize] 错误文本字体大小，默认为14.sp
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
    this.retryButtonText = '重试',
    this.buttonWidth,
    this.buttonHeight,
    this.textColor = AppColors.grey3,
    this.buttonColor = AppColors.pirmary,
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
            style: TextStyle(
              color: textColor,
              fontSize: textSize.sp,
            ),
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
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 8.h,
                ),
              ),
              child: Text(retryButtonText),
            ),
          )
        ],
      ),
    );
  }
}
