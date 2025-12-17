import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TokenActionRoute extends PopupRoute<void> {
  TokenActionRoute({
    required this.itemRect,
    required this.child,
    Duration duration = const Duration(milliseconds: 150),
  }) : _duration = duration;

  final Duration _duration;
  final Rect itemRect;
  final Widget child;
  final GlobalKey _childKey = GlobalKey();

  double? _top;
  double? _left;
  bool showAbove = true;
  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => _duration;

  @override
  TickerFuture didPush() {
    super.offstage = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final childRect = _getRect(_childKey);
      _calculateChildOffset(childRect);

      super.offstage = false;
    });
    return super.didPush();
  }

  Rect? _getRect(GlobalKey key) {
    final currentContext = key.currentContext;
    final renderBox = currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || currentContext == null) return null;
    final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);
    return offset & renderBox.paintBounds.size;
  }

  void _calculateChildOffset(Rect? childRect) {
    if (childRect == null) return;
    _top = itemRect.top - childRect.top - childRect.height;

    if (itemRect.top - childRect.top < childRect.height) {
      showAbove = false;
      _top = itemRect.bottom - childRect.bottom + childRect.height;
    }

    _left = itemRect.center.dx - childRect.center.dx;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    child = Column(
      key: _childKey,
      mainAxisSize: MainAxisSize.min,
      children: showAbove
          ? [child, _TrianglePainterWidget(showAbove)]
          : [_TrianglePainterWidget(showAbove), child],
    );

    return FadeTransition(
      opacity: animation,
      child: Stack(
        children: [Positioned(left: _left, top: _top, child: child)],
      ),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }
}

class _TrianglePainterWidget extends StatelessWidget {
  const _TrianglePainterWidget(this.showAbove);
  final bool showAbove;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(16.0, 8.0),
      painter: _TrianglePainter(
        color: Colors.black.withValues(alpha: 0.8),
        pointDown: showAbove,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.color, required this.pointDown});

  final Color color;
  final bool pointDown;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (pointDown) {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.pointDown != pointDown;
  }
}
