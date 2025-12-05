import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../themes/colors.dart';

class SkeletonTokenWidget extends StatelessWidget {
  const SkeletonTokenWidget({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

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
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Row(
        spacing: 16.w,
        children: [
          
          buildAvatarWidget(context),
          
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContainerWidget(context, 100.w, 16.h),
                12.verticalSpace,
                buildContainerWidget(context, 80.w, 14.h),
              ],
            ),
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildContainerWidget(context, 70.w, 16.h),
              12.verticalSpace,
              buildContainerWidget(context, 50.w, 14.h),
            ],
          ),
        ],
      ),
    );
  }
}
