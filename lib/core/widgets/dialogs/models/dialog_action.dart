import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'dialog_type.dart';

part 'dialog_action.freezed.dart';

@freezed
sealed class DialogAction with _$DialogAction {
  const DialogAction._();

  const factory DialogAction({
    required String label,
    required VoidCallback? onPressed,
    @Default(DialogActionType.primary) DialogActionType type,
    @Default(false) bool isDestructive,
    @Default(false) bool isLoading,
    @Default(true) bool dismissOnTap,
    Color? textColor,
    Color? backgroundColor,
    Widget? icon,
    Widget? customWidget,
  }) = _DialogAction;
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
  factory DialogAction.cancel({String? label, VoidCallback? onPressed}) =>
      DialogAction(
        label: label ?? '',
        onPressed: onPressed,
        type: DialogActionType.secondary,
        dismissOnTap: true,
      );
  factory DialogAction.confirm({
    String? label,
    required VoidCallback onPressed,
  }) => DialogAction(
    label: label ?? '',
    onPressed: onPressed,
    type: DialogActionType.primary,
    dismissOnTap: true,
  );
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
