import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget(
      {super.key,
      this.actions,
      this.leading,
      this.centerTitle,
      this.backgroundColor,
      this.foregroundColor,
      required this.title,
      this.onBack});

  final VoidCallback? onBack;
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp),
      ),
      actions: actions,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: onBack ?? () => context.pop(),
          ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? AppColors.background(context),
      foregroundColor: foregroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
