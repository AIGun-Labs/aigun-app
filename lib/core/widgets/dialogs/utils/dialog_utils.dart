import 'package:flutter/material.dart';

import '../builders/app_dialog_builder.dart';
import '../models/dialog_action.dart';
import '../models/dialog_config.dart';
import '../models/dialog_type.dart';
import '../widgets/base_app_dialog.dart';

/// 对话框工具类
class DialogUtils {
  DialogUtils._();

  /// 显示通用对话框
  static Future<T?> show<T>(BuildContext context, DialogConfig config) {
    return showDialog<T>(
      context: context,
      barrierDismissible: config.isDismissible,
      useRootNavigator: config.useRootNavigator,
      builder: (context) => BaseAppDialog(config: config),
    );
  }

  /// 创建Builder
  static AppDialogBuilder builder() => AppDialogBuilder();

  /// 快捷方法：信息对话框
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

  /// 快捷方法：警告对话框
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
          DialogAction.primary(
            label: buttonText ?? '我知道了',
            onPressed: onDismiss,
          ),
        ],
      ),
    );
  }

  /// 快捷方法：确认对话框
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
            label: cancelText ?? '取消',
            onPressed: () => Navigator.of(context).pop(false),
          ),
          isDestructive
              ? DialogAction.destructive(
                  label: confirmText ?? '确认',
                  onPressed: () => Navigator.of(context).pop(true),
                )
              : DialogAction.primary(
                  label: confirmText ?? '确认',
                  onPressed: () => Navigator.of(context).pop(true),
                ),
        ],
      ),
    );
  }

  /// 快捷方法：错误对话框
  static Future<void> showError(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.error(
        title: title ?? '错误',
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }

  /// 快捷方法：成功对话框
  static Future<void> showSuccess(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    return show(
      context,
      DialogConfig.success(
        title: title ?? '成功',
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }
}
