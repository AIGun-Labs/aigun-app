import 'package:flutter/material.dart';

import '../builders/app_dialog_builder.dart';
import '../models/dialog_action.dart';
import '../models/dialog_config.dart';
import '../models/dialog_type.dart';
import '../widgets/base_app_dialog.dart';

class DialogUtils {
  DialogUtils._();
  static Future<T?> show<T>(BuildContext context, DialogConfig config) {
    return showDialog<T>(
      context: context,
      barrierDismissible: config.isDismissible,
      useRootNavigator: config.useRootNavigator,
      builder: (context) => BaseAppDialog(config: config),
    );
  }

  static AppDialogBuilder builder() => AppDialogBuilder();
  static Future<void> showInfo(
    BuildContext context, {
    String? title,
    required String message,
    String? buttonText,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.info(title: title, message: message, onDismiss: onDismiss),
    );
  }

  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.warning(
        title: title,
        message: message,
        actions: [
          DialogAction.primary(label: buttonText ?? '', onPressed: onDismiss),
        ],
      ),
    );
  }

  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool isDestructive = false,
  }) {
    return show<bool>(
      context,
      DialogConfig(
        title: title,
        message: message,
        type: DialogType.confirm,
        actions: [
          DialogAction.secondary(
            label: cancelText ?? '',
            onPressed: () => Navigator.of(context).pop(false),
          ),
          isDestructive
              ? DialogAction.destructive(
                  label: confirmText ?? '',
                  onPressed: () => Navigator.of(context).pop(true),
                )
              : DialogAction.primary(
                  label: confirmText ?? '',
                  onPressed: () => Navigator.of(context).pop(true),
                ),
        ],
      ),
    );
  }

  static Future<void> showError(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.error(
        title: title ?? '',
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }

  static Future<void> showSuccess(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.success(
        title: title ?? '',
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }
}
