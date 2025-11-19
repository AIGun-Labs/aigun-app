import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/colors.dart';

/// 自定义 AppBar 组件
///
/// 这是一个可复用的 AppBar 组件，支持多种自定义选项
///
/// 使用示例:
/// ```dart
/// CustomAppBar(
///   title: '页面标题',
///   onBackPressed: () => context.pop(),
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 标题文字
  final String? title;

  /// 标题组件（优先级高于 title）
  final Widget? titleWidget;

  /// 返回按钮图标
  final IconData? leadingIcon;

  /// 返回按钮组件（优先级高于 leadingIcon）
  final Widget? leading;

  /// 是否显示返回按钮，默认为 true
  final bool showLeading;

  /// 返回按钮点击回调
  final VoidCallback? onBackPressed;

  /// 右侧操作按钮列表
  final List<Widget>? actions;

  /// 是否标题居中，默认为 true
  final bool centerTitle;

  /// 背景颜色
  final Color? backgroundColor;

  /// 前景色（影响文字和图标颜色）
  final Color? foregroundColor;

  /// 标题文字样式
  final TextStyle? titleStyle;

  /// 返回按钮图标颜色
  final Color? leadingIconColor;

  /// 返回按钮图标大小
  final double? leadingIconSize;

  /// 底部组件（如 TabBar）
  final PreferredSizeWidget? bottom;

  /// AppBar 高度偏移
  final double? elevation;

  /// 标题左侧间距
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
  }) : assert(
          title != null || titleWidget != null,
          '必须提供 title 或 titleWidget',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 构建标题组件
    Widget buildTitle() {
      if (titleWidget != null) {
        return titleWidget!;
      }

      return Text(
        title ?? '',
        style: titleStyle ??
            theme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              color: foregroundColor ?? AppColors.textPrimary(context),
            ),
      );
    }

    // 构建返回按钮
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
          color: leadingIconColor ??
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

/// 简单版本的 AppBar
///
/// 适用于只需要标题和返回按钮的简单场景
///
/// 使用示例:
/// ```dart
/// SimpleAppBar(
///   title: '简单标题',
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

/// 无返回按钮的 AppBar
///
/// 适用于根页面或不需要返回按钮的页面
///
/// 使用示例:
/// ```dart
/// NoBackAppBar(
///   title: '首页',
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
