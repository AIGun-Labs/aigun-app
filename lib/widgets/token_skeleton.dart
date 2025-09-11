import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
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
    // 使用透明背景而不是灰色背景，避免遮罩效果
    const containerColor = Colors.transparent;

    Widget buildShimmerElement(double width, double height) {
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

    Widget buildAvatar() {
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

class HeaderTokenSkeleton extends StatelessWidget {
  const HeaderTokenSkeleton({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    Widget buildShimmerElement(double width, double height) {
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

    Widget buildAvatar() {
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor(context),
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.shimmerBaseColor(context),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      );
    }

    return Row(
      spacing: 5.w,
      children: List.generate(
        itemCount,
        (index) => Column(
          children: [
            buildAvatar(),
            SizedBox(height: 8.h),
            buildShimmerElement(50.w, 12.h),
          ],
        ),
      ),
    );
  }
}

class IntelSkeleton extends StatelessWidget {
  const IntelSkeleton({
    super.key,
    this.itemCount = 3,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    Widget buildShimmerElement(double width, double height,
        {BorderRadius? borderRadius}) {
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor(context),
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.shimmerHighlightColor(context),
            borderRadius: borderRadius ?? BorderRadius.circular(4.r),
          ),
        ),
      );
    }

    Widget buildAvatar(double radius) {
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor(context),
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: AppColors.shimmerHighlightColor(context),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }

    Widget buildIntelItemSkeleton() {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header 部分
            Row(
              children: [
                Row(
                  children: [
                    buildAvatar(28),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildShimmerElement(80.w, 16.h),
                        SizedBox(height: 4.h),
                        buildShimmerElement(60.w, 14.h),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // const Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(height: 12.h),

            // Token 列表骨架
            const TokenSkeleton(itemCount: 2),
            SizedBox(height: 12.h),

            // Author 信息骨架
            Container(
              decoration: BoxDecoration(
                color: AppColors.shimmerBaseColor(context),
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  buildAvatar(20),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            buildShimmerElement(60.w, 14.h),
                            SizedBox(width: 4.w),
                            buildAvatar(8),
                            SizedBox(width: 4.w),
                            buildShimmerElement(80.w, 14.h),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        buildShimmerElement(120.w, 14.h),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  // const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // 文本内容骨架
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShimmerElement(300.w, 16.h),
                SizedBox(height: 8.h),
                buildShimmerElement(250.w, 16.h),
                SizedBox(height: 8.h),
                buildShimmerElement(280.w, 16.h),
                SizedBox(height: 8.h),
                buildShimmerElement(200.w, 16.h),
              ],
            ),
            SizedBox(height: 12.h),

            // 图片网格骨架
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(3, (index) {
                return buildShimmerElement(
                  double.infinity,
                  100.w,
                  borderRadius: BorderRadius.circular(8.r),
                );
              }),
            ),
            SizedBox(height: 12.h),

            // 底部消息骨架
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShimmerElement(200.w, 14.h),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    buildAvatar(10),
                    SizedBox(width: 5.w),
                    buildShimmerElement(120.w, 14.h),
                    SizedBox(width: 10.w),
                    buildShimmerElement(100.w, 14.h),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(
        itemCount,
        (index) => Column(
          children: [
            buildIntelItemSkeleton(),
            if (index < itemCount - 1)
              Divider(
                color: AppColors.shimmerBaseColor(context),
                thickness: 10,
                height: 10,
              ),
          ],
        ),
      ),
    );
  }
}
