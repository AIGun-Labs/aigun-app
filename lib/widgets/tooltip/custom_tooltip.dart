import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';

class CustomTooltip extends StatefulWidget {
  const CustomTooltip({super.key, required this.content, required this.child});
  final Widget content;
  final Widget child;

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _widgetKey,
      onLongPress: _showTooltip,
      onTap: _hideTooltip,
      child: widget.child,
    );
  }

  void _showTooltip() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox?;

    final size = renderBox?.size;

    final offset = renderBox?.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
            left: offset?.dx ?? 0,
            top: offset?.dy ?? 0,
            width: size?.width ?? 0,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _hideTooltip,
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.black.withValues(alpha: 0.8)),
                      child: widget.content,
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }
}
