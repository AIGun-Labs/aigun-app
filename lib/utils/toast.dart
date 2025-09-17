import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/url.dart';
import 'package:flutter_aigun/widgets/lotties/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

ToastificationItem? tid;

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

class TradeStatusToastUtils {
  static void showSuccessToast(BuildContext context,
      {String? message,
      String? txHash,
      String? symbol,
      String? amount,
      String? txUrl}) {
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
                      '交易成功',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary(context),
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(txUrl ?? "");
                      },
                      child: Text.rich(TextSpan(
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.quaternary),
                          children: [
                            TextSpan(text: '+ $amount '),
                            TextSpan(text: symbol)
                          ])),
                    )
                  ],
                )
              ],
            ),
          );
        });

    Future.delayed(const Duration(seconds: 100), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }

  static void showParamsInvalidToast(BuildContext context) {
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
                  "不支持输入接收代币的数量",
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

  static void showNotSuppertedInputAmountToast(BuildContext context) {
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
                  "不支持输入接收代币的数量",
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

  static ToastController showTrainingToast(BuildContext context) {
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
              "交易中...",
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

  static void showFailed(BuildContext context) {
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
              "交易失败了，没关系，再试一次",
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

class ToastController {
  final dynamic id;
  final VoidCallback dismiss;

  ToastController({required this.id, required this.dismiss});
}
