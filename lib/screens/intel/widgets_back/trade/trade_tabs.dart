import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeTabs extends StatelessWidget {
  final TabController controller;

  const TradeTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TabBar(
        controller: controller,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: AppColors.textPrimary(context),
          borderRadius: BorderRadius.circular(8.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 0,
        dividerColor: Colors.transparent,
        labelColor: AppColors.textPrimary(context),
        unselectedLabelColor: AppColors.textPrimary(context),
        tabs: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(S.of(context).common_buy),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(S.of(context).common_sell),
          ),
        ],
      ),
    );
  }
}
