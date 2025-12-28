import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'dialog_action.dart';
import 'dialog_type.dart';

part 'dialog_config.freezed.dart';

@freezed
sealed class DialogConfig with _$DialogConfig {
  const DialogConfig._();

  const factory DialogConfig({
    String? title,
    required String message,
    @Default(DialogType.info) DialogType type,
    @Default(true) bool isDismissible,
    @Default(true) bool useRootNavigator,
    List<DialogAction>? actions,
    Widget? customContent,
    Widget? customIcon,
    @Default(true) bool showIcon,
    Color? backgroundColor,
    Color? titleColor,
    TextStyle? titleStyle,
    Color? messageColor,
    TextStyle? messageStyle,
    @Default(TextAlign.center) TextAlign titleAlign,
    @Default(TextAlign.center) TextAlign messageAlign,
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    double? maxWidth,
    double? titleSpacing,
    double? contentButtonSpacing,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) = _DialogConfig;
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
  factory DialogConfig.info({
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.info,
    actions: [DialogAction.primary(label: '', onPressed: onDismiss)],
  );
  factory DialogConfig.error({
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.error,
    actions: [DialogAction.primary(label: '', onPressed: onDismiss)],
  );
  factory DialogConfig.success({
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) => DialogConfig(
    title: title,
    message: message,
    type: DialogType.success,
    actions: [DialogAction.primary(label: '', onPressed: onDismiss)],
  );
}
