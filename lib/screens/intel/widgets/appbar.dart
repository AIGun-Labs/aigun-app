import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../themes/themes.dart';

class IntelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IntelAppBar({super.key, this.tabbar, this.openDrawer, this.title});
  final PreferredSizeWidget? tabbar;
  final VoidCallback? openDrawer;

  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 15.w,
      automaticallyImplyLeading: false,
      title: title,
      backgroundColor: AppColors.background(context),
      bottom: tabbar,
    );
  }
}
