import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.title,
    this.titleSpacing,
    this.onBack,
    this.automaticallyImplyLeading = true,
    this.bottom,
  });

  final VoidCallback? onBack;
  final Object? title;
  final List<Widget>? actions;
  final Widget? leading;

  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    Widget buildTitle() {
      if (title is Widget) {
        return title as Widget;
      }

      if (title is String) {
        return Text((title as String), style: TextStyle(fontSize: 16.sp));
      }
      return const SizedBox.shrink();
    }

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.background(context),
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      title: buildTitle(),
      titleSpacing: titleSpacing,
      leadingWidth: 42.w,
      leading:
          leading ??
          IconButton(
            padding: EdgeInsets.only(left: 15.w),
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 22.sp,
            onPressed:
                onBack ??
                () {
                  if (automaticallyImplyLeading) {
                    context.pop();
                  }
                },
          ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
