import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'refresh_controller.dart';

/// 监听“松手”时机：仅在松手时检查是否触发刷新。
class RefreshBinder extends StatelessWidget {
  const RefreshBinder({
    super.key,
    required this.controller,
    required this.child,
  });

  final RefreshController controller;
  final Widget child;

  bool _onNotification(ScrollNotification n) {
    if (n is ScrollEndNotification ||
        (n is UserScrollNotification && n.direction == ScrollDirection.idle)) {
      if (controller.state == RefreshState.armed || controller.pullExtent > 0) {
        controller.release();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: child,
    );
  }
}
