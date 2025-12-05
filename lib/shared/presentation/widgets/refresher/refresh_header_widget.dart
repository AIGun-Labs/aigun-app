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

    
    final mode = widget.info?.mode;
    final oldMode = oldWidget.info?.mode;

    
    const refreshMode = PullToRefreshIndicatorMode.refresh;

    if (mode != oldMode) {
      if (mode == refreshMode) {
        
        _blinkController.repeat(reverse: true);
      } else if (oldMode == refreshMode) {
        
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

    
    final double maxDrag = 90.h;
    final double top = -90.h + dragOffset;

    
    double t = dragOffset / maxDrag;
    if (t < 0) t = 0;
    if (t > 1) t = 1;

    
    final double scale = 0.2 + 1.0 * t;

    
    const refreshMode = PullToRefreshIndicatorMode.refresh;
    final bool isRefreshing = info.mode == refreshMode;

    return SizedBox(
      height: dragOffset, 
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: top,
            child: Align(
              alignment: Alignment.bottomCenter, 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  
                  Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomCenter,
                    child: RefreshLoadingWidget(isRefreshing: isRefreshing),
                  ),
                  
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
