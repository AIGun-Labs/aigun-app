import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

ToastificationItem? tid;
ToastificationItem? toastUtilsTid;

class ToastUtils {
  static void showCenterToast(BuildContext context, String message) {
    // Ensure only one toast
    if (toastUtilsTid != null) {
      Toastification().dismiss(toastUtilsTid!);
    }

    toastUtilsTid = Toastification().showCustom(
      context: context,
      alignment: Alignment.center,
      autoCloseDuration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      builder: (context, holder) {
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.foreground(context).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.r),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSuccessToast(
    BuildContext context, {
    String? message,
  }) {
    // Ensure only one toast
    if (toastUtilsTid != null) {
      Toastification().dismiss(toastUtilsTid!);
    }

    toastUtilsTid = Toastification().show(
      type: ToastificationType.success,
      icon: SvgPicture.asset('assets/images/icons/check_fill.svg',
          width: 20.w, height: 20.h),
      title: Text(message ?? '',
          style: TextStyle(color: Colors.white, fontSize: 16.sp)),
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
    Logger.info("showFailureToast");

    // Ensure only one toast
    if (toastUtilsTid != null) {
      Toastification().dismiss(toastUtilsTid!);
    }

    toastUtilsTid = Toastification().show(
      type: ToastificationType.error,
      icon: const Icon(Icons.error, color: Colors.white),
      title: Text(message ?? '',
          maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
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

class ToastController {
  final dynamic id;
  final VoidCallback dismiss;

  ToastController({required this.id, required this.dismiss});
}

// 定义一个变量来持有 Dialog 的 context，以便在外部关闭它
BuildContext? _dialogContext;

class NetworkToastUtils {
  static void showNetworkFailed(BuildContext context, String message) {
    // 如果已有弹窗显示，则先关闭它，防止重复显示
    dismiss();

    showDialog(
      context: context,
      // barrierDismissible: false => 点击背景遮罩层不会关闭弹窗
      barrierDismissible: false,
      // barrierColor: Colors.black54 => 设置黑色半透明背景
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext dialogContext) {
        // 保存当前 dialog 的 context
        _dialogContext = dialogContext;

        // 【关键】将您原来的 builder 内容直接放在这里
        // 为了让背景透明，我们需要将弹窗本身包裹在 Dialog Widget 中
        // 并设置其背景色为 Colors.transparent
        return Dialog(
          backgroundColor: Colors.transparent, // Dialog背景透明
          elevation: 0, // 去掉阴影
          child: Container(
            width: 300.w,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            decoration: BoxDecoration(
              // 这里可以稍微调整透明度，因为背景已经有遮罩了
              color: AppColors.foreground(context).withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                  size: 36.sp,
                ),
                SizedBox(height: 12.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // 当弹窗关闭时，清空 context
      _dialogContext = null;
    });
  }

  // 提供一个外部关闭弹窗的方法
  static void dismiss() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
