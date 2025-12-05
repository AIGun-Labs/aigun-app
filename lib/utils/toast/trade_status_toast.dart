import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import '../../widgets/lotties/index.dart';
import '../toast.dart';

class TradeStatusToastUtils {
  // Track the current toast notification (ID or object) being displayed
  static dynamic _currentToast;

  // Helper to dismiss the current toast if it exists
  static void _dismissCurrent() {
    if (_currentToast != null) {
      Toastification().dismiss(_currentToast!);
      _currentToast = null;
    }
  }

  /// Public method to manually dismiss any active toast
  static void dismissToast() {
    _dismissCurrent();
  }

  /// Show a success toast with transaction details
  static void showSuccessToast({
    String? message,
    String? txHash,
    required String symbol,
    required String amount,
    String? txUrl,
    String operateSymbol = '+',
  }) {
    _dismissCurrent(); // close any existing toast

    final toast = Toastification().showCustom(
      alignment: Alignment.topCenter,
      dismissDirection: DismissDirection.up,
      // Auto-close after 2 seconds using Toastification's built-in feature:contentReference[oaicite:2]{index=2}
      autoCloseDuration: const Duration(seconds: 2),
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.all(15.r),
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 5),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/icons/check-filled.svg',
                width: 45.w,
                height: 45.h,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).transactionSuccess,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Clickable transaction amount and symbol (opens transaction URL if provided)
                  GestureDetector(
                    onTap: () {
                      if (txUrl != null && txUrl.isNotEmpty) {
                        launchUrl(Uri.parse(txUrl));
                      }
                    },
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.quaternary),
                        children: [
                          TextSpan(text: '$operateSymbol $amount '),
                          TextSpan(text: symbol),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    _currentToast = toast;
  }

  /// Show a warning toast for invalid trade parameters
  static void showParamsInvalidToast() {
    _dismissCurrent();

    final toast = Toastification().showCustom(
      alignment: Alignment.topCenter,
      dismissDirection: DismissDirection.up,
      autoCloseDuration: const Duration(seconds: 2),
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 5),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/icons/warning-filled.svg',
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w),
              Text(
                S.of(context).tradeParamsInvalid,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textPrimary(context)),
              ),
              const Expanded(child: SizedBox.shrink()),
              // Close button to allow manual dismissal
              IconButton(
                icon: Icon(Icons.close, color: AppColors.textTertiary(context)),
                onPressed: () {
                  dismissToast();
                },
              ),
            ],
          ),
        );
      },
    );

    _currentToast = toast;
  }

  /// Show a warning toast for unsupported input amount
  static void showNotSupportedInputAmountToast() {
    _dismissCurrent();

    final toast = Toastification().showCustom(
      alignment: Alignment.topCenter,
      dismissDirection: DismissDirection.up,
      autoCloseDuration: const Duration(seconds: 2),
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 5),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/icons/warning-filled.svg',
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w),
              Text(
                S.of(context).notSupportInputReceiveTokenAmount,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textPrimary(context)),
              ),
              const Expanded(child: SizedBox.shrink()),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.textTertiary(context)),
                onPressed: () {
                  dismissToast();
                },
              ),
            ],
          ),
        );
      },
    );

    _currentToast = toast;
  }

  /// Show a "transaction in progress" toast (returns a controller for manual dismissal)
  static ToastController showTrainingToast() {
    _dismissCurrent();

    final toast = Toastification().showCustom(
      alignment: Alignment.topCenter,
      dismissDirection: DismissDirection.up,
      // No autoCloseDuration here – this toast stays until dismissed
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 5),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieAsset(
                'assets/lottie/lightning-filled.lottie',
                config: LottieConfig(
                  repeat: true,
                  animate: true,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                S.of(context).transactionTraing,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        );
      },
    );

    _currentToast = toast;
    // Return a controller to allow manual dismissal of this toast
    return ToastController(
      id: toast,
      dismiss: () {
        Toastification().dismiss(toast);

        if (_currentToast == toast) {
          _currentToast = null;
        }
      },
    );
  }

  /// Show a failure toast (transaction failed)
  static void showFailedToast({String? message}) {
    _dismissCurrent();

    final toast = Toastification().showCustom(
      alignment: Alignment.topCenter,
      dismissDirection: DismissDirection.up,
      autoCloseDuration: const Duration(seconds: 2),
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 5),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icons/emoji-cry-outline.svg',
                width: 43.w,
                height: 40.h,
              ),
              SizedBox(width: 8.w),
              Text(
                message ?? S.of(context).transactionFailed,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        );
      },
    );

    _currentToast = toast;
  }
}
