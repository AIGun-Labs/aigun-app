import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/lotties/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_aigun/l10n/l10n.dart';

class TradeStatusToastUtils {
  static void showSuccessToast(
      {String? message,
      String? txHash,
      String? symbol,
      String? amount,
      String? txUrl,
      String? operateSymbol = "+"}) {
    // 确保只有一个toast
    if (tid != null) {
      Toastification().dismiss(tid!);
    }

    tid = Toastification().showCustom(
        dismissDirection: DismissDirection.up,
        alignment: Alignment.topCenter,
        builder: (context, transition) {
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
                ]),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/check-filled.svg",
                  width: 45.w,
                  height: 45.h,
                ),
                SizedBox(width: 8.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).transactionSuccess,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary(context),
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(txUrl ?? ""));
                      },
                      child: Text.rich(TextSpan(
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.quaternary),
                          children: [
                            TextSpan(text: '$operateSymbol $amount '),
                            TextSpan(text: symbol)
                          ])),
                    )
                  ],
                )
              ],
            ),
          );
        });

    Future.delayed(const Duration(seconds: 2), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }

  static void dismissToast() {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
  }

  static void showParamsInvalidToast() {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }

    tid = Toastification().showCustom(
        dismissDirection: DismissDirection.up,
        alignment: Alignment.topCenter,
        builder: (context, transition) {
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
                ]),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/warning-filled.svg",
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
                IconButton(
                    onPressed: () {
                      Toastification().dismiss(tid!);
                    },
                    icon: Icon(Icons.close,
                        color: AppColors.textTertiary(context)))
              ],
            ),
          );
        });

    Future.delayed(const Duration(seconds: 2), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }

  static void showNotSuppertedInputAmountToast() {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }

    tid = Toastification().showCustom(
        dismissDirection: DismissDirection.up,
        alignment: Alignment.topCenter,
        builder: (context, transition) {
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
                ]),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/warning-filled.svg",
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
                    onPressed: () {
                      Toastification().dismiss(tid!);
                    },
                    icon: Icon(Icons.close,
                        color: AppColors.textTertiary(context)))
              ],
            ),
          );
        });
    Future.delayed(const Duration(seconds: 2), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }

  static ToastController showTrainingToast() {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }

    tid = Toastification().showCustom(
      dismissDirection: DismissDirection.up,
      alignment: Alignment.topCenter,
      builder: (context, transition) {
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
              ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // CachedImage(
            //     imageUrl: "assets/images/icons/lightning-filled.png",
            //     width: 30.w,
            //     height: 30.h),
            LottieAsset(
              "assets/lottie/lightning-filled.lottie",
              config: LottieConfig(
                  repeat: true, animate: true, width: 30.w, height: 30.h),
            ),
            SizedBox(width: 4.w),
            Text(
              S.of(context).transactionTraing,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context)),
            )
          ]),
        );
      },
    );

    return ToastController(
        id: tid,
        dismiss: () {
          if (tid != null) {
            Toastification().dismiss(tid!);
          }
        });
  }

  static void showFailed() {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }

    tid = Toastification().showCustom(
      dismissDirection: DismissDirection.up,
      alignment: Alignment.topCenter,
      builder: (context, transition) {
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
              ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              "assets/images/icons/emoji-cry-outline.svg",
              width: 43.w,
              height: 40.h,
            ),
            SizedBox(width: 8.w),
            Text(
              S.of(context).transactionFailed,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context)),
            )
          ]),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }
}
