import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../themes/colors.dart';

class SkeletonTokenWidget extends StatelessWidget {
  const SkeletonTokenWidget({super.key});

  Widget buildAvatarWidget(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(context),
      highlightColor: AppColors.shimmerHighlightColor(context),
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: AppColors.shimmerBaseColor(context),
          borderRadius: BorderRadius.circular(22.r),
        ),
      ),
    );
  }

  Widget buildContainerWidget(
      BuildContext context, double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(context),
      highlightColor: AppColors.shimmerHighlightColor(context),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBaseColor(context),
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 左侧头像骨架
        buildAvatarWidget(context),
        SizedBox(width: 16.w),
        // 中间两行文字
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildContainerWidget(context, 100.w, 16.h),
              SizedBox(height: 12.h),
              buildContainerWidget(context, 80.w, 14.h),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        // 右侧两行文字
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildContainerWidget(context, 70.w, 16.h),
            SizedBox(height: 12.h),
            buildContainerWidget(context, 50.w, 14.h),
          ],
        ),
      ],
    );
  }
}
