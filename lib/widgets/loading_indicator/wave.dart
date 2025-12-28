import 'package:flutter/material.dart';

class WaveLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const WaveLoadingIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  State<WaveLoadingIndicator> createState() => WaveLoadingIndicatorState();
}

class WaveLoadingIndicatorState extends State<WaveLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final int _itemCount = 5;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    for (int i = 0; i < _itemCount; i++) {
      Future.delayed(Duration(milliseconds: i * 120), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemSize = widget.size / 10;
    final spacing = itemSize / 2;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _itemCount,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing),
            child: AnimatedBuilder(
              animation: _controllers[index],
              builder: (context, child) {
                return Container(
                  width: itemSize,
                  height:
                      itemSize + (widget.size / 2) * _controllers[index].value,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(itemSize / 2),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
