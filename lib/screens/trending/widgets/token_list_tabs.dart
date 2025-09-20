import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class TokenListTabs extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const TokenListTabs({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border(context),
            width: 1.h,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildTab(context, 0, '收藏'),
          SizedBox(width: 25.w),
          _buildTab(context, 1, '最新推荐'),
          SizedBox(width: 25.w),
          _buildTab(context, 2, '热门'),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, String title) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        transform: Matrix4.translationValues(0, 1.h, 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? AppColors.foreground(context)
                  : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'PingFang HK',
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected
                  ? AppColors.black
                  : AppColors.textSecondary(context),
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
