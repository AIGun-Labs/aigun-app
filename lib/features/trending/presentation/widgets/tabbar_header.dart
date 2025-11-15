import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class TabbarHeader extends StatelessWidget {
  final TabController? controller;

  const TabbarHeader({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background(context),
      child: TabBar(
          controller: controller,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
          dividerColor: AppColors.border(context),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.h,
              color: AppColors.textPrimary(context),
            ),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary(context),
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary(context),
            fontWeight: FontWeight.w400,
          ),
          tabs: [
            Tab(text: S.of(context).tracking),
            Tab(text: S.of(context).topPick),
            Tab(text: S.of(context).hot)
          ]),
    );
  }
}

// class TabBarDelegate extends SliverPersistentHeaderDelegate {
//   const TabBarDelegate();

//   // @override
//   // double get minExtent => 40.h;

//   // @override
//   // double get maxExtent => 62.h;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: AppColors.background(context),
//       child: TabBar(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           tabAlignment: TabAlignment.start,
//           isScrollable: true,
//           indicatorWeight: 0,
//           labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
//           dividerColor: AppColors.border(context),
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(
//               width: 2.h,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           indicatorSize: TabBarIndicatorSize.label,
//           labelStyle: TextStyle(
//             fontSize: 16.sp,
//             color: AppColors.textPrimary(context),
//             fontWeight: FontWeight.w700,
//           ),
//           unselectedLabelStyle: TextStyle(
//             fontSize: 16.sp,
//             color: AppColors.textSecondary(context),
//             fontWeight: FontWeight.w400,
//           ),
//           tabs: [
//             Tab(text: S.of(context).tracking),
//             Tab(text: S.of(context).topPick),
//             Tab(text: S.of(context).hot)
//           ]),
//     );
//   }

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
