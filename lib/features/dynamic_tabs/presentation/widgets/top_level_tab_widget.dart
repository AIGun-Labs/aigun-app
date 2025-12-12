import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';

class TopLevelTabWidget extends StatelessWidget implements PreferredSizeWidget {
  TopLevelTabWidget({
    super.key,
    this.controller,
    required this.tabs,
    this.height = kTextTabBarHeight,
    this.scrollController,
  });

  final TabController? controller;
  final List<Tab> tabs;
  final double height;
  final ScrollController? scrollController;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  void _scrollToTop(BuildContext context) {
    final fallback = PrimaryScrollController.maybeOf(context);

    if (scrollController != null && scrollController!.hasClients) {
      scrollController!.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      fallback?.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  static const _doubleTapGap = Duration(milliseconds: 280);
  int? _lastTapIndex;
  DateTime? _lastTapAt;

  @override
  Widget build(BuildContext context) {
    final tabController = controller ?? DefaultTabController.of(context);

    return SizedBox(
      height: height,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () => _scrollToTop(context),
        child: ColoredBox(
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
            // onTap: (index) {
            //   // 只处理“重复点同一个 tab（reselect）”的情况
            //   // 切换 tab 时 indexIsChanging == true，直接忽略
            //   if (tabController.indexIsChanging) return;

            //   final now = DateTime.now();
            //   final isDoubleTap =
            //       _lastTapIndex == index &&
            //       _lastTapAt != null &&
            //       now.difference(_lastTapAt!) <= _doubleTapGap;

            //   _lastTapIndex = index;
            //   _lastTapAt = now;

            //   // 同一个 tab 双击：回到顶部
            //   if (isDoubleTap) {
            //     _scrollToTop(context);
            //   }
            // },
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
