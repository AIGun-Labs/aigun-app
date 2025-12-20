import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dialog_type.dart';

part 'dialog_action.freezed.dart';

/// 对话框按钮动作配置
@freezed
sealed class DialogAction with _$DialogAction {
  const DialogAction._();

  const factory DialogAction({
    /// 按钮文本
    required String label,

    /// 点击回调
    required VoidCallback? onPressed,

    /// 按钮类型
    @Default(DialogActionType.primary) DialogActionType type,

    /// 是否为危险操作（红色）
    @Default(false) bool isDestructive,

    /// 是否显示加载状态
    @Default(false) bool isLoading,

    /// 点击后是否自动关闭对话框
    @Default(true) bool dismissOnTap,

    /// 自定义文本颜色
    Color? textColor,

    /// 自定义背景色
    Color? backgroundColor,

    /// 图标
    Widget? icon,

    /// 完全自定义的按钮 Widget 优先级最高
    Widget? customWidget,
  }) = _DialogAction;

  /// 主要按钮（蓝色/主题色）
  factory DialogAction.primary({
    required String label,
    VoidCallback? onPressed,
    bool dismissOnTap = true,
  }) => DialogAction(
    label: label,
    onPressed: onPressed,
    type: DialogActionType.primary,
    dismissOnTap: dismissOnTap,
  );

  /// 次要按钮（灰色/边框）
  factory DialogAction.secondary({
    required String label,
    VoidCallback? onPressed,
    bool dismissOnTap = true,
  }) => DialogAction(
    label: label,
    onPressed: onPressed,
    type: DialogActionType.secondary,
    dismissOnTap: dismissOnTap,
  );

  /// 取消按钮
  factory DialogAction.cancel({String? label, VoidCallback? onPressed}) =>
      DialogAction(
        label: label ?? '取消',
        onPressed: onPressed,
        type: DialogActionType.secondary,
        dismissOnTap: true,
      );

  /// 确认按钮
  factory DialogAction.confirm({
    String? label,
    required VoidCallback onPressed,
  }) => DialogAction(
    label: label ?? '确认',
    onPressed: onPressed,
    type: DialogActionType.primary,
    dismissOnTap: true,
  );

  /// 删除/危险按钮（红色）
  factory DialogAction.destructive({
    required String label,
    required VoidCallback onPressed,
  }) => DialogAction(
    label: label,
    onPressed: onPressed,
    type: DialogActionType.primary,
    isDestructive: true,
    dismissOnTap: true,
  );

  factory DialogAction.custom({
    required Widget widget,
    VoidCallback? onPressed,
    bool dismissOnTap = true,
  }) => DialogAction(
    label: '',
    onPressed: onPressed,
    customWidget: widget,
    dismissOnTap: dismissOnTap,
  );
}
