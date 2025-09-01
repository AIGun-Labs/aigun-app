import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showSuccessButtonSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      return BottomButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5.h),
            Center(
              child: Text(
                S.of(context).tokens_addTokenNow,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            SizedBox(height: 51.h),
            Text(
              "HELLO",
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              "Hello Doge",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 51.h),
            _buildButtonRow(context),
          ],
        ),
      );
    },
  );
}

void showErrorButtonSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      return BottomButton(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5.h),
            Image.asset(
              'assets/images/question.png',
              width: 77.w,
              height: 77.h,
            ),
            SizedBox(height: 20.h),
            Text(
              S.of(context).tokens_contractAddressError,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () => context.pop(),
              backgroundColor: Color(0xff000000),
              textColor: Colors.white,
              text: S.of(context).common_ok,
              fontSize: 16.sp,
              height: 50.h,
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildButtonRow(BuildContext context) {
  return Row(
    children: [
      Flexible(
        child: CustomButton(
          onPressed: () => context.pop(),
          backgroundColor: Color(0xffffffff),
          textColor: Colors.black,
          isBottomButton: true,
          borderSide: BorderSide(color: Color(0xFFB2B2B2)),
          text: S.of(context).common_cancel,
          fontSize: 16.sp,
          height: 50.h,
        ),
      ),
      SizedBox(width: 20.w),
      Flexible(
        child: CustomButton(
          onPressed: () {
            context.go(Routes.home, extra: NavIndex.wallet);
            showAddTokenSuccessToast(context);
          },
          backgroundColor: Color(0xff000000),
          textColor: Colors.white,
          text: S.of(context).common_ok,
          fontSize: 16.sp,
          isBottomButton: true,
          height: 50.h,
        ),
      ),
    ],
  );
}
