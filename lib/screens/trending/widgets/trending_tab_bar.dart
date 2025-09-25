import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class TrendingTabBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TrendingTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<TrendingTabBar> createState() => _TrendingTabBarState();
}

class _TrendingTabBarState extends State<TrendingTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.foreground(context).withValues(alpha: 0.1),
            offset: const Offset(0, 5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab(
            index: 0,
            title: '热门',
            iconPath: 'assets/images/trending/hot_icon.png',
          ),
          _buildTab(
            index: 1,
            title: 'AI特工',
            iconPath: 'assets/images/trending/ai_agent_icon.png',
          ),
          _buildTab(
            index: 2,
            title: '趋势',
            iconPath: 'assets/images/trending/trend_icon.png',
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required int index,
    required String title,
    required String iconPath,
  }) {
    final bool isSelected = widget.selectedIndex == index;

    return InkWell(
      onTap: () => widget.onTabSelected(index),
      child: Container(
        padding: EdgeInsets.only(bottom: 3.h, top: 5.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color:
              isSelected ? AppColors.quaternary : AppColors.background(context),
          width: 3.w,
        ))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedImage(
              imageUrl: iconPath,
              width: 30.w,
              height: 30.h,
            ),
            SizedBox(height: 3.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.black : const Color(0xFF565656),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
