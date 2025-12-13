import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/router/routes/token_action_route.dart';
import '../widgets/token_action_widget.dart';

Future<void> showTokenActionsPopover(
  BuildContext itemContext, {
  VoidCallback? onTransfer,
  VoidCallback? onCollect,
  bool isCollected = false,
}) async {
  if (onTransfer == null && onCollect == null) return;

  final renderBox = itemContext.findRenderObject() as RenderBox?;
  if (renderBox == null || !renderBox.attached) return;

  final itemSize = renderBox.size;
  final itemOffset = renderBox.localToGlobal(Offset.zero);
  final mediaQuery = MediaQuery.of(itemContext);
  final screenSize = mediaQuery.size;

  final bubbleWidth = 96.0;
  final bubbleHeight = 44.0;
  const arrowHeight = 8.0;
  const horizontalMargin = 8.0;

  double dx = itemOffset.dx + itemSize.width / 2 - bubbleWidth / 2;
  dx = dx.clamp(
    horizontalMargin,
    screenSize.width - bubbleWidth - horizontalMargin,
  );

  double dy = itemOffset.dy - bubbleHeight - arrowHeight - 4;
  bool showAbove = true;
  if (dy < mediaQuery.padding.top + 8) {
    showAbove = false;
    dy = itemOffset.dy + itemSize.height + arrowHeight + 4;
  }

  void handleOnTransfer() {
    Navigator.of(itemContext).pop();
    onTransfer?.call();
  }

  void handleOnCollect() {
    Navigator.of(itemContext).pop();
    onCollect?.call();
  }

  final arrow = CustomPaint(
    size: Size(16.w, 8.h),
    painter: _TrianglePainter(
      color: Colors.black.withValues(alpha: 0.8),
      pointDown: showAbove,
    ),
  );

  final route = TokenActionRoute(
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.of(itemContext).pop(), // 点空白关闭
      child: Stack(
        children: [
          Positioned(
            left: dx,
            top: dy,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: showAbove
                  ? [
                      TokenActionWidget(
                        onTransfer: onTransfer != null
                            ? handleOnTransfer
                            : null,
                        onCollect: onCollect != null ? handleOnCollect : null,
                        isCollected: isCollected,
                      ),
                      arrow,
                    ]
                  : [
                      arrow,
                      TokenActionWidget(
                        onTransfer: onTransfer != null
                            ? handleOnTransfer
                            : null,
                        onCollect: onCollect != null ? handleOnCollect : null,
                        isCollected: isCollected,
                      ),
                    ],
            ),
          ),
        ],
      ),
    ),
  );

  await Navigator.of(itemContext).push(route);
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
      //  ▼
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    } else {
      //  ▲
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
