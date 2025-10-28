import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class AboutGoldSheet extends StatelessWidget {
  const AboutGoldSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.verticalSpace,
            Center(
              child: Container(
                width: 41.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary(context),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            14.verticalSpace,

            // 标题
            Text(
              S.of(context).aboutGold,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
            ),
            20.verticalSpace,

            // 图片
            Center(
              child: Image.asset(
                'assets/images/mining.png',
                width: 114.w,
                fit: BoxFit.fitWidth,
              ),
            ),

            26.verticalSpace,

            // 说明文字
            Text(
              S.of(context).goldDesc,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),

            30.verticalSpace,
            // 获取方式说明
            Text(
              S.of(context).getGoldWay,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),

            Text(
              S.of(context).getGoldWay1,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
            Text(
              S.of(context).getGoldWay2,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),

            Text(
              S.of(context).getGoldWay3,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),

            32.verticalSpace,

            // 知道了按钮
            SizedBox(
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.foreground(context),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  S.of(context).know,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
