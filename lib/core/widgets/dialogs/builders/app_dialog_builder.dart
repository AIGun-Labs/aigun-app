import 'package:flutter/material.dart';

import '../models/dialog_action.dart';
import '../models/dialog_config.dart';
import '../models/dialog_type.dart';
import '../utils/dialog_utils.dart';

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
  AppDialogBuilder title(String title) {
    _title = title;
    return this;
  }

  AppDialogBuilder message(String message) {
    _message = message;
    return this;
  }

  AppDialogBuilder type(DialogType type) {
    _type = type;
    return this;
  }

  AppDialogBuilder dismissible(bool isDismissible) {
    _isDismissible = isDismissible;
    return this;
  }

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

  AppDialogBuilder action(DialogAction action) {
    _actions.add(action);
    return this;
  }

  AppDialogBuilder customContent(Widget content) {
    _customContent = content;
    return this;
  }

  AppDialogBuilder icon(Widget icon) {
    _customIcon = icon;
    return this;
  }

  AppDialogBuilder backgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  AppDialogBuilder borderRadius(double radius) {
    _borderRadius = radius;
    return this;
  }

  AppDialogBuilder titleColor(Color color) {
    _titleColor = color;
    return this;
  }

  AppDialogBuilder messageColor(Color color) {
    _messageColor = color;
    return this;
  }

  AppDialogBuilder contentPadding(EdgeInsetsGeometry padding) {
    _contentPadding = padding;
    return this;
  }

  AppDialogBuilder titleStyle(TextStyle style) {
    _titleStyle = style;
    return this;
  }

  AppDialogBuilder messageStyle(TextStyle style) {
    _messageStyle = style;
    return this;
  }

  AppDialogBuilder titleAlign(TextAlign align) {
    _titleAlign = align;
    return this;
  }

  AppDialogBuilder messageAlign(TextAlign align) {
    _messageAlign = align;
    return this;
  }

  AppDialogBuilder maxWidth(double width) {
    _maxWidth = width;
    return this;
  }

  AppDialogBuilder titleSpacing(double spacing) {
    _titleSpacing = spacing;
    return this;
  }

  AppDialogBuilder contentButtonSpacing(double spacing) {
    _contentButtonSpacing = spacing;
    return this;
  }

  AppDialogBuilder showIcon(bool show) {
    _showIcon = show;
    return this;
  }

  AppDialogBuilder noTitle() {
    _title = null;
    return this;
  }

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

  Future<T?> show<T>(BuildContext context) {
    return DialogUtils.show<T>(context, build());
  }
}
