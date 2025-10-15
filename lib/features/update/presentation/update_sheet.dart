import 'package:flutter/material.dart';
import '../domain/entities/update_info.dart';
import 'widget/update.dart';

/// 更新模块的弹窗显示工具
class UpdateSheet {
  /// 显示更新弹窗
  ///
  /// [context] - BuildContext
  /// [info] - 更新信息
  /// [force] - 是否强制更新（强制更新时不允许关闭弹窗）
  static void show(
    BuildContext context, {
    required UpdateInfo info,
    required bool force,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: !force,
      enableDrag: !force,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      builder: (context) => Update(info: info, force: force),
    );
  }
}
