import 'package:flutter/material.dart';
import 'package:flutter_aigun/features/trending/presentation/widgets/search_bar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IntelAppBar({super.key, required this.tabbar});
  final PreferredSizeWidget tabbar;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 49.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20.w,
      automaticallyImplyLeading: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child: TrendingSearchBar(
            openDrawer: () => Scaffold.of(context).openDrawer()),
      ),
      backgroundColor: AppColors.background(context),
      bottom: tabbar,
    );
  }
}
