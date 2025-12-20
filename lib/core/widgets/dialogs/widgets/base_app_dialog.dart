import 'package:flutter/material.dart';
import '../models/dialog_config.dart';
import '../models/dialog_type.dart';
import '../models/dialog_action.dart';
import '../theme/dialog_theme.dart';

/// 基础对话框组件
class BaseAppDialog extends StatelessWidget {
  final DialogConfig config;

  const BaseAppDialog({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dialogTheme = AppDialogTheme.of(context);

    return Dialog(
      backgroundColor: config.backgroundColor ?? dialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          config.borderRadius ?? dialogTheme.borderRadius,
        ),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: config.maxWidth ?? 320),
        padding: config.contentPadding ?? dialogTheme.contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标（如果有）
            if (config.showIcon &&
                (config.customIcon != null || _shouldShowDefaultIcon))
              _buildIcon(dialogTheme),

            // 标题
            if (config.title?.isNotEmpty ?? false) ...[
              _buildTitle(theme, dialogTheme),
              SizedBox(height: config.titleSpacing ?? 12),
            ],

            // 内容
            if (config.customContent != null)
              config.customContent!
            else
              _buildMessage(theme, dialogTheme),

            SizedBox(height: config.contentButtonSpacing ?? 24),

            // 按钮
            if (config.actions != null && config.actions!.isNotEmpty)
              _buildActions(context, theme, dialogTheme),
          ],
        ),
      ),
    );
  }

  bool get _shouldShowDefaultIcon {
    return config.type != DialogType.custom && config.type != DialogType.info;
  }

  Widget _buildIcon(AppDialogTheme dialogTheme) {
    if (config.customIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: config.customIcon,
      );
    }

    IconData iconData;
    Color iconColor;

    switch (config.type) {
      case DialogType.warning:
        iconData = Icons.warning_rounded;
        iconColor = dialogTheme.warningColor;
        break;
      case DialogType.error:
        iconData = Icons.error_rounded;
        iconColor = dialogTheme.errorColor;
        break;
      case DialogType.success:
        iconData = Icons.check_circle_rounded;
        iconColor = dialogTheme.successColor;
        break;
      default:
        iconData = Icons.info_rounded;
        iconColor = dialogTheme.infoColor;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Icon(iconData, size: 48, color: iconColor),
    );
  }

  Widget _buildTitle(ThemeData theme, AppDialogTheme dialogTheme) {
    // 使用自定义样式或默认样式
    final textStyle =
        config.titleStyle ??
        theme.textTheme.titleLarge?.copyWith(
          color: config.titleColor ?? dialogTheme.titleColor,
          fontWeight: FontWeight.w600,
        );

    return Text(
      config.title ?? '',
      style: textStyle,
      textAlign: config.titleAlign,
    );
  }

  Widget _buildMessage(ThemeData theme, AppDialogTheme dialogTheme) {
    // 使用自定义样式或默认样式
    final textStyle =
        config.messageStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: config.messageColor ?? dialogTheme.messageColor,
          height: 1.5,
        );

    return Text(
      config.message,
      style: textStyle,
      textAlign: config.messageAlign,
    );
  }

  Widget _buildActions(
    BuildContext context,
    ThemeData theme,
    AppDialogTheme dialogTheme,
  ) {
    final actions = config.actions!;

    // 单按钮：全宽
    if (actions.length == 1) {
      return _buildActionButton(
        context,
        actions[0],
        theme,
        dialogTheme,
        isFullWidth: true,
      );
    }

    // 多按钮：横向排列
    return Row(
      children: actions.map((action) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: action == actions.first ? 0 : 4,
              right: action == actions.last ? 0 : 4,
            ),
            child: _buildActionButton(context, action, theme, dialogTheme),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    DialogAction action,
    ThemeData theme,
    AppDialogTheme dialogTheme, {
    bool isFullWidth = false,
  }) {
    VoidCallback? onPressed = action.onPressed == null
        ? null
        : () {
            if (action.dismissOnTap) {
              Navigator.of(
                context,
                rootNavigator: config.useRootNavigator,
              ).pop();
            }
            action.onPressed?.call();
          };

    if (action.customWidget != null) {
      return GestureDetector(
        onTap: action.onPressed == null
            ? null
            : () {
                if (action.dismissOnTap) {
                  Navigator.of(
                    context,
                    rootNavigator: config.useRootNavigator,
                  ).pop();
                }
                action.onPressed?.call();
              },
        child: action.customWidget,
      );
    }

    // 主要按钮样式
    if (action.type == DialogActionType.primary) {
      final backgroundColor = action.isDestructive
          ? dialogTheme.errorColor
          : (action.backgroundColor ?? theme.primaryColor);

      return SizedBox(
        height: 44,
        width: isFullWidth ? double.infinity : null,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: action.textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: action.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (action.icon != null) ...[
                      action.icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(action.label),
                  ],
                ),
        ),
      );
    }

    // 次要按钮样式（边框按钮）
    if (action.type == DialogActionType.secondary) {
      return SizedBox(
        height: 44,
        width: isFullWidth ? double.infinity : null,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor:
                action.textColor ?? theme.textTheme.bodyLarge?.color,
            side: BorderSide(color: action.textColor ?? theme.dividerColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(action.label),
        ),
      );
    }

    // 文本按钮
    return TextButton(onPressed: onPressed, child: Text(action.label));
  }
}
