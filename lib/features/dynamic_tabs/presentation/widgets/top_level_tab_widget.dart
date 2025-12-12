import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';

class TopLevelTabWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopLevelTabWidget({super.key, this.controller, required this.tabs});

  final TabController? controller;
  final List<Tab> tabs;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background(context),
      child: TabBar(
        controller: controller,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorWeight: 0,
        labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
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
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(36.h);
}
