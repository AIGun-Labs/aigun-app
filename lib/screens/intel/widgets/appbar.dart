import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';
import 'intel_search_bar.dart';

class IntelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IntelAppBar({super.key, required this.tabbar});
  final PreferredSizeWidget tabbar;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 49.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // titleSpacing: 12.w,
      automaticallyImplyLeading: false,
      title: Container(
        // padding: EdgeInsets.symmetric(horizontal: 12.h),
        child:
            IntelSearchBar(openDrawer: () => Scaffold.of(context).openDrawer()),
      ),
      backgroundColor: AppColors.background(context),
      bottom: tabbar,
    );
  }
}
