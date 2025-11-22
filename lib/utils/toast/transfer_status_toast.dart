import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import '../url.dart';

ToastificationItem? tid;

class TransferStatusToast {
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
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.card(context),
                offset: const Offset(0, 2),
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
                    '$amount $symbol ${S.of(context).transfer_sendTokenPadding4}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(txHash);
                    },
                    child: Text(
                      textAlign: TextAlign.left,
                      S.of(context).common_viewTransactionDetails,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.quaternary,
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

    Future.delayed(const Duration(seconds: 2), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }
}
