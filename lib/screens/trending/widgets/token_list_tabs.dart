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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              _buildTab(0, '收藏'),
              SizedBox(width: 31.w),
              _buildTab(1, '最新推荐'),
              SizedBox(width: 31.w),
              _buildTab(2, '热门'),
            ],
          ),
          SizedBox(height: 10.h),
          // 分割线和下划线
          Stack(
            children: [
              // 整条分割线
              Container(
                width: double.infinity,
                height: 2.h,
                color: const Color(0xFFDDE3E1),
              ),
              // 选中标签的下划线
              if (selectedTabIndex == 0)
                Container(
                  width: 28.w,
                  height: 2.h,
                  color: AppColors.black,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'PingFang HK',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? AppColors.black : const Color(0xFF565656),
          height: 1.4,
        ),
      ),
    );
  }
}
