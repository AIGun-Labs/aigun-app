import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotatingSquareLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const RotatingSquareLoadingIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  State<RotatingSquareLoadingIndicator> createState() =>
      RotatingSquareLoadingIndicatorState();
}

class RotatingSquareLoadingIndicatorState
    extends State<RotatingSquareLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: Container(
              width: widget.size * 0.6,
              height: widget.size * 0.6,
              decoration: BoxDecoration(
                color: widget.color.withAlpha((0.8 * 255).round()),
                borderRadius: BorderRadius.circular(widget.size * 0.1),
              ),
              child: Center(
                child: Container(
                  width: widget.size * 0.3,
                  height: widget.size * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.size * 0.05),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
