import 'package:flutter/material.dart';

class PulseLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const PulseLoadingIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  State<PulseLoadingIndicator> createState() => PulseLoadingIndicatorState();
}

class PulseLoadingIndicatorState extends State<PulseLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withAlpha((0.2 * 255).round()),
            boxShadow: [
              BoxShadow(
                color: widget.color.withAlpha(
                  (0.3 * _controller.value * 255).round(),
                ),
                spreadRadius: widget.size * 0.5 * _controller.value,
                blurRadius: widget.size * 0.5 * _controller.value,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: widget.size * 0.5,
              height: widget.size * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
