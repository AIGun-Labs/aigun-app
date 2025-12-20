import 'package:flutter/material.dart';
import '../models/dialog_action.dart';
import '../models/dialog_config.dart';
import '../models/dialog_type.dart';
import '../utils/dialog_utils.dart';

/// 对话框Builder - 提供流式API
class AppDialogBuilder {
  String? _title;
  String? _message;
  DialogType _type = DialogType.info;
  bool _isDismissible = true;
  bool _useRootNavigator = true;
  bool _showIcon = true;
  final List<DialogAction> _actions = [];
  Widget? _customContent;
  Widget? _customIcon;
  Color? _backgroundColor;
  Color? _titleColor;
  TextStyle? _titleStyle;
  Color? _messageColor;
  TextStyle? _messageStyle;
  TextAlign _titleAlign = TextAlign.center;
  TextAlign _messageAlign = TextAlign.center;
  double? _borderRadius;
  EdgeInsetsGeometry? _contentPadding;
  double? _maxWidth;
  double? _titleSpacing;
  double? _contentButtonSpacing;

  /// 设置标题
  AppDialogBuilder title(String title) {
    _title = title;
    return this;
  }

  /// 设置消息内容
  AppDialogBuilder message(String message) {
    _message = message;
    return this;
  }

  /// 设置对话框类型
  AppDialogBuilder type(DialogType type) {
    _type = type;
    return this;
  }

  /// 设置是否可点击外部关闭
  AppDialogBuilder dismissible(bool isDismissible) {
    _isDismissible = isDismissible;
    return this;
  }

  /// 添加主要按钮
  AppDialogBuilder primaryAction(
    String label,
    VoidCallback? onPressed, {
    bool dismissOnTap = true,
  }) {
    _actions.add(
      DialogAction.primary(
        label: label,
        onPressed: onPressed,
        dismissOnTap: dismissOnTap,
      ),
    );
    return this;
  }

  /// 添加次要按钮
  AppDialogBuilder secondaryAction(
    String label,
    VoidCallback? onPressed, {
    bool dismissOnTap = true,
  }) {
    _actions.add(
      DialogAction.secondary(
        label: label,
        onPressed: onPressed,
        dismissOnTap: dismissOnTap,
      ),
    );
    return this;
  }

  /// 添加自定义按钮
  AppDialogBuilder action(DialogAction action) {
    _actions.add(action);
    return this;
  }

  /// 设置自定义内容
  AppDialogBuilder customContent(Widget content) {
    _customContent = content;
    return this;
  }

  /// 设置自定义图标
  AppDialogBuilder icon(Widget icon) {
    _customIcon = icon;
    return this;
  }

  /// 设置背景色
  AppDialogBuilder backgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  /// 设置圆角半径
  AppDialogBuilder borderRadius(double radius) {
    _borderRadius = radius;
    return this;
  }

  /// 设置标题颜色
  AppDialogBuilder titleColor(Color color) {
    _titleColor = color;
    return this;
  }

  /// 设置消息颜色
  AppDialogBuilder messageColor(Color color) {
    _messageColor = color;
    return this;
  }

  /// 设置内容边距
  AppDialogBuilder contentPadding(EdgeInsetsGeometry padding) {
    _contentPadding = padding;
    return this;
  }

  /// 设置标题字体样式
  AppDialogBuilder titleStyle(TextStyle style) {
    _titleStyle = style;
    return this;
  }

  /// 设置消息字体样式
  AppDialogBuilder messageStyle(TextStyle style) {
    _messageStyle = style;
    return this;
  }

  /// 设置标题对齐方式
  AppDialogBuilder titleAlign(TextAlign align) {
    _titleAlign = align;
    return this;
  }

  /// 设置消息对齐方式
  AppDialogBuilder messageAlign(TextAlign align) {
    _messageAlign = align;
    return this;
  }

  /// 设置对话框最大宽度
  AppDialogBuilder maxWidth(double width) {
    _maxWidth = width;
    return this;
  }

  /// 设置标题与内容之间的间距
  AppDialogBuilder titleSpacing(double spacing) {
    _titleSpacing = spacing;
    return this;
  }

  /// 设置内容与按钮之间的间距
  AppDialogBuilder contentButtonSpacing(double spacing) {
    _contentButtonSpacing = spacing;
    return this;
  }

  /// 设置是否显示图标
  AppDialogBuilder showIcon(bool show) {
    _showIcon = show;
    return this;
  }

  /// 隐藏标题（title 设为 null）
  AppDialogBuilder noTitle() {
    _title = null;
    return this;
  }

  /// 构建配置对象
  DialogConfig build() {
    assert(
      _message != null || _customContent != null,
      'Message or customContent is required',
    );

    return DialogConfig(
      title: _title,
      message: _message ?? '',
      type: _type,
      isDismissible: _isDismissible,
      useRootNavigator: _useRootNavigator,
      showIcon: _showIcon,
      actions: _actions.isEmpty ? null : _actions,
      customContent: _customContent,
      customIcon: _customIcon,
      backgroundColor: _backgroundColor,
      titleColor: _titleColor,
      titleStyle: _titleStyle,
      messageColor: _messageColor,
      messageStyle: _messageStyle,
      titleAlign: _titleAlign,
      messageAlign: _messageAlign,
      borderRadius: _borderRadius,
      contentPadding: _contentPadding,
      maxWidth: _maxWidth,
      titleSpacing: _titleSpacing,
      contentButtonSpacing: _contentButtonSpacing,
    );
  }

  /// 显示对话框
  Future<T?> show<T>(BuildContext context) {
    return DialogUtils.show<T>(context, build());
  }
}
