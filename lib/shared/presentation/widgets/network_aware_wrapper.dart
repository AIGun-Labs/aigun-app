// lib/shared/presentation/widgets/network_aware_wrapper.dart

import 'package:flutter/material.dart';

import '../../../core/network/gatekeeper/gate_keeper_service.dart';
import '../../../core/service_locator.dart';
import 'no_data_widget.dart';

/// 网络感知包装器
/// 当网络服务异常时显示 NoDataWidget，正常时显示 child
class NetworkAwareWrapper extends StatelessWidget {
  const NetworkAwareWrapper({
    super.key,
    required this.child,
    required this.isLoading,
    this.onRetry,
    this.errorText,
    this.loadingWidget,
    this.showOnlyWhenLoading = true,
    this.lock = false,
  });

  final bool lock;

  /// 正常状态下显示的子组件
  final Widget child;

  /// 是否处于加载状态
  final bool isLoading;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 错误提示文本
  final String? errorText;

  /// 自定义加载组件 (可选)
  final Widget? loadingWidget;

  /// true: 只有在加载中且服务异常时显示 NoDataWidget
  /// false: 只要服务异常就显示 NoDataWidget
  final bool showOnlyWhenLoading;

  @override
  Widget build(BuildContext context) {
    final gateKeeper = getIt<GateKeeperService>();

    return ValueListenableBuilder<bool>(
      valueListenable: gateKeeper.isServiceLockedNotifier,
      builder: (context, isServiceLocked, _) {
        // 判断是否应该显示错误状态
        // final shouldShowError = showOnlyWhenLoading
        //     ? (isServiceLocked && isLoading)
        //     : isServiceLocked;

        final shouldShowError = showOnlyWhenLoading
            ? (isServiceLocked && isLoading)
            : isServiceLocked;

        if (shouldShowError) {
          return NoDataWidget(onRetry: onRetry, errorTextDesc: errorText);
        }

        return child;
      },
    );
  }
}
