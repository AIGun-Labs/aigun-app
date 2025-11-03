import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../themes/colors.dart';
import 'card_widget.dart';

class BonusViewSkeleton extends StatelessWidget {
  const BonusViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // InviteCard 骨架
        _buildInviteCardSkeleton(context),
        14.verticalSpace,

        // BindInviteCard 骨架
        _buildBindInviteCardSkeleton(context),
        14.verticalSpace,

        // 四个小卡片骨架
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

        // BonusDetails 骨架
        _buildBonusDetailsSkeleton(context),
      ],
    );
  }

  // InviteCard 骨架屏
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
                    )),
              ],
            ),
            12.verticalSpace,
            Divider(
              height: 1.h,
              color: AppColors.border(context),
            ),
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

  // BindInviteCard 骨架屏
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

  // 小卡片骨架屏 (GetGoldCard, GetFundsCard, InviteeCard, InviteeTradeCard)
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

  // BonusDetails 骨架屏
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
