import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class TrendingHeader extends StatelessWidget {
  const TrendingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            // 头像
            Container(
              width: 35.w,
              height: 35.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000.r),
                child: Image.asset(
                  'assets/images/trending/user_avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // 搜索框
            Expanded(
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border(context)),
                  borderRadius: BorderRadius.circular(1000.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 11.w),
                    Icon(
                      Icons.search,
                      size: 24.sp,
                      color: AppColors.textQuaternary(context),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        'Search name or CA',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textQuaternary(context),
                        ),
                      ),
                    ),
                    // 粘贴图标
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        Icons.content_paste,
                        size: 18.sp,
                        color: AppColors.textTertiary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
