import 'package:flutter/material.dart';
import 'refresh_controller.dart';

typedef RefreshHeaderBuilder = Widget Function(
  BuildContext context,
  RefreshState state,
  double pullExtent,
  double triggerDistance,
  double indicatorExtent,
);

class SliverRefreshHeader extends StatelessWidget {
  const SliverRefreshHeader({
    super.key,
    required this.controller,
    this.builder,
  });

  final RefreshController controller;
  final RefreshHeaderBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final h = controller.state == RefreshState.refreshing
              ? controller.indicatorExtent
              : controller.pullExtent.clamp(0.0, controller.indicatorExtent);

          // 即使高度为0，也返回一个Container来保持布局的稳定性
          if (h <= 0) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: h,
            child: Center(
              child: builder?.call(
                    context,
                    controller.state,
                    controller.pullExtent,
                    controller.triggerDistance,
                    controller.indicatorExtent,
                  ) ??
                  _DefaultHeader(
                    state: controller.state,
                    pull: controller.pullExtent,
                    trigger: controller.triggerDistance,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class _DefaultHeader extends StatelessWidget {
  const _DefaultHeader(
      {required this.state, required this.pull, required this.trigger});
  final RefreshState state;
  final double pull;
  final double trigger;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case RefreshState.refreshing:
        return const _Row(indeterminate: true, text: '刷新中...');
      case RefreshState.armed:
        return const _Row(indeterminate: false, progress: 1.0, text: '松手刷新');
      case RefreshState.dragging:
        final p = (pull / trigger).clamp(0.0, 1.0);
        return _Row(
            indeterminate: false, progress: p == 0 ? 0.01 : p, text: '下拉刷新');
      case RefreshState.done:
        return const _Row(indeterminate: true, text: '完成');
      case RefreshState.idle:
      default:
        // idle 状态时，如果有 pull 值，说明正在过渡，显示默认的下拉提示
        if (pull > 0) {
          final p = (pull / trigger).clamp(0.0, 1.0);
          return _Row(
              indeterminate: false, progress: p == 0 ? 0.01 : p, text: '下拉刷新');
        }
        return const SizedBox.shrink();
    }
  }
}

class _Row extends StatelessWidget {
  const _Row({this.progress, this.indeterminate = false, required this.text});
  final double? progress;
  final bool indeterminate;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 18,
        height: 18,
        child: indeterminate
            ? const CircularProgressIndicator(strokeWidth: 2)
            : CircularProgressIndicator(
                strokeWidth: 2, value: progress!.clamp(0.0, 1.0)),
      ),
      const SizedBox(width: 8),
      Text(text, style: const TextStyle(fontSize: 13)),
    ]);
  }
}
