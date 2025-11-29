import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'refresh_loading_widget.dart';
import 'refresh_text_widget.dart';

class RefreshHeaderWidget extends StatefulWidget {
  const RefreshHeaderWidget(this.info, {super.key});

  final PullToRefreshScrollNotificationInfo? info;

  @override
  State<RefreshHeaderWidget> createState() => _RefreshHeaderWidgetState();
}

class _RefreshHeaderWidgetState extends State<RefreshHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blinkController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacity = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant RefreshHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 当前/上一次的刷新状态
    final mode = widget.info?.mode;
    final oldMode = oldWidget.info?.mode;

    // ⚠️ 如果你用的是 3.x 版本，枚举名是 PullToRefreshIndicatorMode.refresh
    const refreshMode = PullToRefreshIndicatorMode.refresh;

    if (mode != oldMode) {
      if (mode == refreshMode) {
        // 进入刷新状态：文字开始闪烁
        _blinkController.repeat(reverse: true);
      } else if (oldMode == refreshMode) {
        // 刚从刷新状态退出：停止闪烁并恢复为不透明
        _blinkController.reset();
      }
    }
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    if (info == null) {
      return const SizedBox.shrink();
    }

    final double dragOffset = info.dragOffset ?? 0.0;

    // 1. 拖动的最大参考值（和外面的 refreshOffset 对齐）
    final double maxDrag = 90.h;
    final double top = -90.h + dragOffset;

    // 2. 拖动进度 0 ~ 1
    double t = dragOffset / maxDrag;
    if (t < 0) t = 0;
    if (t > 1) t = 1;

    // 3. 缩放范围：最小 0.2，最大 1.2
    final double scale = 0.2 + 1.0 * t;

    // 是否处在真正的刷新状态
    const refreshMode = PullToRefreshIndicatorMode.refresh;
    final bool isRefreshing = info.mode == refreshMode;

    return SizedBox(
      height: dragOffset, // 高度跟着拖动距离变化
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: top,
            child: Align(
              alignment: Alignment.bottomCenter, // 刷新组件“贴着”列表顶部往下拉
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // 只有刷新时才动的 Lottie
                  Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomCenter,
                    child: RefreshLoadingWidget(isRefreshing: isRefreshing),
                  ),
                  // 刷新时闪烁的文字
                  FadeTransition(
                    opacity: _opacity,
                    child: const RefreshTextWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
