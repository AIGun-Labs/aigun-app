import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../../../../widgets/skeleton/widgets/text.dart';

class TokenInfoSkeleton extends StatelessWidget {
  const TokenInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 85.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSkeleton(
                        width: 120.w,
                        height: 24.h,
                        borderRadius: 12,
                      ),
                      TextSkeleton(width: 80.w, height: 24.h, borderRadius: 12),
                      Row(
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.shimmerBaseColor(context),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          TextSkeleton(
                            width: 30.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          SizedBox(width: 4.w),
                          TextSkeleton(
                            width: 35.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          SizedBox(width: 12.w),
                          TextSkeleton(
                            width: 35.w,
                            height: 16.h,
                            borderRadius: 8,
                          ),
                          TextSkeleton(
                            width: 15.w,
                            height: 12.h,
                            borderRadius: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
