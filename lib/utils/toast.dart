import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(
    BuildContext context, {
    String? message,
  }) {
    Toastification().show(
      type: ToastificationType.success,
      icon: SvgPicture.asset('assets/images/icons/check_fill.svg',
          width: 20.w, height: 20.h),
      title: Text(message ?? '',
          style: TextStyle(color: AppColors.white, fontSize: 16.sp)),
      alignment: Alignment.topCenter,
      backgroundColor: AppColors.quaternary,
      showProgressBar: false, // 关闭进度条
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      borderSide: const BorderSide(color: AppColors.quaternary),
      autoCloseDuration: const Duration(seconds: 3),
      closeButtonShowType: CloseButtonShowType.none,
    );
  }

  static void showFailureToast(
    BuildContext context, {
    String? message,
  }) {
    Toastification().show(
      type: ToastificationType.error,
      icon: const Icon(Icons.error, color: AppColors.white),
      title: Text(message ?? '',
          style: TextStyle(color: AppColors.white, fontSize: 16.sp)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      alignment: Alignment.topCenter,
      backgroundColor: AppColors.quaternary,
      showProgressBar: false, // 关闭进度条
      borderSide: const BorderSide(color: AppColors.quaternary),
      autoCloseDuration: const Duration(seconds: 3),
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
