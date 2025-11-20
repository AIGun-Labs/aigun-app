import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';

class IntelTabbarHeader extends StatelessWidget {
  final TabController? controller;

  const IntelTabbarHeader({super.key, this.controller, this.tabs});

  final List<Tab>? tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background(context),
      child: TabBar(
          controller: controller,
          // padding: EdgeInsets.symmetric(horizontal: 10.w),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
          dividerColor: Colors.transparent,
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
          tabs: tabs ?? []),
    );
  }
}
