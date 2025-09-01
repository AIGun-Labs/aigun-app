import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onPressed;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor,
    this.leadingIcon,
    this.leadingIconColor,
    this.bottom,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(
        title ?? '',
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: theme.textTheme.bodyMedium?.color,
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          leadingIcon ?? Icons.arrow_back_ios,
          color: leadingIconColor ?? theme.textTheme.bodyMedium?.color,
          size: 20.w,
        ),
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
