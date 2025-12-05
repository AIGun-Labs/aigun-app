import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/colors.dart';

///

///

/// ```dart
/// CustomAppBar(

///   onBackPressed: () => context.pop(),
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final Widget? titleWidget;

  final IconData? leadingIcon;

  final Widget? leading;

  final bool showLeading;

  final VoidCallback? onBackPressed;

  final List<Widget>? actions;

  final bool centerTitle;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final TextStyle? titleStyle;

  final Color? leadingIconColor;

  final double? leadingIconSize;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final double? titleSpacing;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leadingIcon,
    this.leading,
    this.showLeading = true,
    this.onBackPressed,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.titleStyle,
    this.leadingIconColor,
    this.leadingIconSize,
    this.bottom,
    this.elevation,
    this.titleSpacing,
  }) : assert(title != null || titleWidget != null, ' title  titleWidget');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildTitle() {
      if (titleWidget != null) {
        return titleWidget!;
      }

      return Text(
        title ?? '',
        style:
            titleStyle ??
            theme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              color: foregroundColor ?? AppColors.textPrimary(context),
            ),
      );
    }

    Widget? buildLeading() {
      if (!showLeading) {
        return null;
      }

      if (leading != null) {
        return leading;
      }

      return IconButton(
        icon: Icon(
          leadingIcon ?? Icons.arrow_back_ios,
          color:
              leadingIconColor ??
              foregroundColor ??
              AppColors.textPrimary(context),
          size: leadingIconSize ?? 20.w,
        ),
        onPressed: onBackPressed ?? () => context.pop(),
      );
    }

    return AppBar(
      title: buildTitle(),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.background(context),
      foregroundColor: foregroundColor ?? AppColors.textPrimary(context),
      elevation: elevation ?? 0,
      surfaceTintColor: Colors.transparent,
      leading: buildLeading(),
      automaticallyImplyLeading: false,
      actions: actions,
      bottom: bottom,
      titleSpacing: titleSpacing,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}

///

///

/// ```dart
/// SimpleAppBar(

/// )
/// ```
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      onBackPressed: onBackPressed,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

///

///

/// ```dart
/// NoBackAppBar(

///   actions: [IconButton(...)],
/// )
/// ```
class NoBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  const NoBackAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      showLeading: false,
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
