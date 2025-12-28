import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../themes/colors.dart';
import 'card_widget.dart';
import 'invite_header.dart';

class BonusViewSkeleton extends StatelessWidget {
  const BonusViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        InviteHeader(),
        20.verticalSpace,
        _buildInviteCardSkeleton(context),
        14.verticalSpace,
        _buildBindInviteCardSkeleton(context),
        14.verticalSpace,
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80.h,
                    child: _buildSmallCardSkeleton(context),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: SizedBox(
                    height: 80.h,
                    child: _buildSmallCardSkeleton(context),
                  ),
                ),
              ],
            ),
            14.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80.h,
                    child: _buildSmallCardSkeleton(context),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: SizedBox(
                    height: 80.h,
                    child: _buildSmallCardSkeleton(context),
                  ),
                ),
              ],
            ),
          ],
        ),
        35.verticalSpace,
        _buildBonusDetailsSkeleton(context),
      ],
    );
  }

  Widget _buildInviteCardSkeleton(BuildContext context) {
    return CardWidget(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            Divider(height: 1.h, color: AppColors.border(context)),
            20.verticalSpace,
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            12.verticalSpace,
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBindInviteCardSkeleton(BuildContext context) {
    return CardWidget(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCardSkeleton(BuildContext context) {
    return CardWidget(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: AppColors.shimmerHighlightColor(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            8.verticalSpace,
            Container(
              width: double.infinity,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusDetailsSkeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor(context),
          highlightColor: AppColors.shimmerHighlightColor(context),
          child: Container(
            width: 120.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
        16.verticalSpace,
        ...List.generate(
          2,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor(context),
              highlightColor: AppColors.shimmerHighlightColor(context),
              child: Container(
                width: double.infinity,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
