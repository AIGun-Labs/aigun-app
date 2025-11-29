import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';

class IntelTabbar extends StatelessWidget implements PreferredSizeWidget {
  const IntelTabbar({super.key, this.tabController, required this.tabs});
  final TabController? tabController;

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabController,
        // padding: EdgeInsets.symmetric(horizontal: 10.w),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorWeight: 0,
        labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
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
        tabs: tabs);
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}

class IntelTabbarItem extends StatelessWidget {
  const IntelTabbarItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context)),
      ),
    );
  }
}
