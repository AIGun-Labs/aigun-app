import 'package:flutter/material.dart';

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
      automaticallyImplyLeading: false,
      title: title,
      backgroundColor: AppColors.background(context),
      bottom: tabbar,
    );
  }
}
