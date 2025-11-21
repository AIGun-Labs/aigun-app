import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';
import 'intel_search_bar.dart';

class IntelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IntelAppBar(
      {super.key, required this.tabbar, this.openDrawer, this.title});
  final PreferredSizeWidget tabbar;
  final VoidCallback? openDrawer;

  final Widget? title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 49.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // titleSpacing: 12.w,
      automaticallyImplyLeading: false,
      title: title,
      backgroundColor: AppColors.background(context),
      bottom: tabbar,
    );
  }
}
