import 'package:flutter/widgets.dart';
import 'refresh_controller.dart';

/// 在顶部向下拖拽时，拦截用户位移，转化为头部拉距；其余交给父类。
class RefreshPhysics extends BouncingScrollPhysics {
  const RefreshPhysics({
    required this.controller,
    ScrollPhysics? parent,
    this.damping = 0.5, // 0~1，越小越“紧”
  }) : super(parent: parent);

  final RefreshController controller;
  final double damping;

  @override
  RefreshPhysics applyTo(ScrollPhysics? ancestor) {
    return RefreshPhysics(
      controller: controller,
      parent: buildParent(ancestor),
      damping: damping,
    );
  }

  bool _atTop(ScrollMetrics m) {
    // 使用绝对位置判断，而不是相对于 minScrollExtent
    // 这样可以避免 header 高度变化时判断失效
    return m.pixels <= 0.5 || m.extentBefore <= 0.5;
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // offset < 0 表示向下拉
    if (_atTop(position) && offset < 0) {
      final consumed = -offset * damping; // 转为“拉距”
      controller.accumulatePull(consumed);
      // 告诉系统这段位移被吃掉，不让内容继续往下走
      return 0.0;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    return super.applyBoundaryConditions(position, value);
  }
}
