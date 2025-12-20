import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dialog_action.dart';
import 'dialog_type.dart';

part 'dialog_config.freezed.dart';

/// 对话框配置模型
@freezed
sealed class DialogConfig with _$DialogConfig {
  const DialogConfig._();

  const factory DialogConfig({
    /// 标题（可选，null 则不显示标题）
    String? title,

    /// 消息内容
    required String message,

    /// 对话框类型
    @Default(DialogType.info) DialogType type,

    /// 是否可点击外部关闭
    @Default(true) bool isDismissible,

    /// 是否使用根导航器
    @Default(true) bool useRootNavigator,

    /// 按钮动作列表
    List<DialogAction>? actions,

    /// 自定义内容（替代 message）
    Widget? customContent,

    /// 自定义图标（null 使用默认图标，如需隐藏设为 SizedBox.shrink()）
    Widget? customIcon,

    /// 是否显示默认图标
    @Default(true) bool showIcon,

    /// 自定义背景色
    Color? backgroundColor,

    /// 自定义标题颜色
    Color? titleColor,

    /// 自定义标题字体样式
    TextStyle? titleStyle,

    /// 自定义消息颜色
    Color? messageColor,

    /// 自定义消息字体样式
    TextStyle? messageStyle,

    /// 标题对齐方式
    @Default(TextAlign.center) TextAlign titleAlign,

    /// 消息对齐方式
    @Default(TextAlign.center) TextAlign messageAlign,

    /// 自定义圆角半径
    double? borderRadius,

    /// 自定义内容边距
    EdgeInsetsGeometry? contentPadding,

    /// 对话框最大宽度
    double? maxWidth,

    /// 标题与内容之间的间距
    double? titleSpacing,

    /// 内容与按钮之间的间距
    double? contentButtonSpacing,

    /// 过渡动画时长
    Duration? transitionDuration,

    /// 过渡动画曲线
    Curve? transitionCurve,
  }) = _DialogConfig;

  /// 工厂方法：警告对话框
  factory DialogConfig.warning({
    required String title,
    required String message,
    List<DialogAction>? actions,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.warning,
    actions: actions,
  );

  /// 工厂方法：确认对话框
  factory DialogConfig.confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.confirm,
    actions: [
      if (onCancel != null) DialogAction.cancel(onPressed: onCancel),
      DialogAction.confirm(onPressed: onConfirm),
    ],
  );

  /// 工厂方法：信息对话框（单按钮）
  factory DialogConfig.info({
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.info,
    actions: [DialogAction.primary(label: '我知道了', onPressed: onDismiss)],
  );

  /// 工厂方法：错误对话框
  factory DialogConfig.error({
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.error,
    actions: [DialogAction.primary(label: '我知道了', onPressed: onDismiss)],
  );

  /// 工厂方法：成功对话框
  factory DialogConfig.success({
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.success,
    actions: [DialogAction.primary(label: '我知道了', onPressed: onDismiss)],
  );
}
