import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/themes/tabs_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntelTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const IntelTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      color: TabsTheme.bgColor(context),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        indicatorWeight: 0,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        dividerHeight: 0.h,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4.h,
            color: AppColors.pirmary,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        tabs: tabs
            .map((tab) => Tab(
                  height: 44.h,
                  text: tab,
                ))
            .toList(),
      ),
    );
  }
}
