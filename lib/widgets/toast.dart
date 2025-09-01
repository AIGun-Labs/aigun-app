import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

ToastificationItem? tid;
void showToast(BuildContext context) {
  if (tid != null) {
    Toastification().dismiss(tid!);
  }
  tid = Toastification().showCustom(
    dismissDirection: DismissDirection.up,
    builder: (context, transition) {
      return Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
             BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.21),
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/icons/send-checked.svg',
              width: 24.w,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2334.33B FLAGDOGE has been sent',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Go to the browser to view',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF282AF0),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
  });
}

void showAddTokenSuccessToast(BuildContext context) {
  if (tid != null) {
    Toastification().dismiss(tid!);
  }
  tid = Toastification().showCustom(
    dismissDirection: DismissDirection.up,
    builder: (context, transition) {
      return Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.21),
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icons/send-checked.svg',
              width: 24.w,
            ),
            SizedBox(width: 8.w),
            Text(
              '2334.33B FLAGDOGE has been sent',
              style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            ),
          ],
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
  });
}

void showTransferSuccessToast(
    BuildContext context, String amount, String symbol, String txHash) {
  if (tid != null) {
    Toastification().dismiss(tid!);
  }

  tid = Toastification().showCustom(
    dismissDirection: DismissDirection.up,
    builder: (context, transition) {
      return Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.21),
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icons/send-checked.svg',
              width: 24.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$amount $symbol has been sent',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(txHash);
                  },
                  child: Text(
                    textAlign: TextAlign.left,
                    'Go to the browser to view',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.deepBlue,
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
  });
}

void showSwapSuccessToast(BuildContext context, String txHash) {
  if (tid != null) {
    Toastification().dismiss(tid!);
  }

  tid = Toastification().showCustom(
    dismissDirection: DismissDirection.up,
    builder: (context, transition) {
      return Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.21),
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icons/send-checked.svg',
              width: 24.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '交易成功',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("txHash: $txHash");
                    launchUrl(txHash);
                  },
                  child: Text(
                    textAlign: TextAlign.left,
                    '点击查看交易详情',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.deepBlue,
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
  });
}

void showSimpleToast(
  String message, {
  Duration? duration,
  ToastificationType? type,
  ToastificationStyle? style,
  Alignment? alignment,
  EdgeInsets? margin,
  BuildContext? context,
}) {
  Toastification().show(
    context: context,
    type: type ?? ToastificationType.error,
    title: Text(message),
    autoCloseDuration: duration ?? Duration(seconds: 3),
    style: style ?? ToastificationStyle.simple,
    alignment: alignment ?? Alignment.topCenter,
  );
}
