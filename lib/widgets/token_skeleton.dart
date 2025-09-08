import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenSkeleton extends StatelessWidget {
  const TokenSkeleton({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // 使用透明背景而不是灰色背景，避免遮罩效果
    final containerColor = Colors.transparent;
    final shimmerBaseColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];
    final shimmerHighlightColor =
        isDarkMode ? Colors.grey[600] : Colors.grey[100];

    Widget buildShimmerElement(double width, double height) {
      return Shimmer.fromColors(
        baseColor: shimmerBaseColor!,
        highlightColor: shimmerHighlightColor!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: shimmerBaseColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      );
    }

    Widget buildAvatar() {
      return Shimmer.fromColors(
        baseColor: shimmerBaseColor!,
        highlightColor: shimmerHighlightColor!,
        child: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: shimmerBaseColor,
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        itemCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          color: containerColor,
          child: Row(
            children: [
              // 左侧头像骨架
              buildAvatar(),
              SizedBox(width: 16.w),
              // 中间两行文字
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmerElement(100.w, 16.h),
                    SizedBox(height: 12.h),
                    buildShimmerElement(80.w, 14.h),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // 右侧两行文字
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildShimmerElement(70.w, 16.h),
                  SizedBox(height: 12.h),
                  buildShimmerElement(50.w, 14.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
