import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TabActiveIcon extends StatefulWidget {
  const TabActiveIcon(
      {super.key, required this.path, required this.isSelected});
  final String path;
  final bool isSelected;

  @override
  State<TabActiveIcon> createState() => _TabActiveIconState();
}

class _TabActiveIconState extends State<TabActiveIcon>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(TabActiveIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected && !oldWidget.isSelected) {
      _controller?.forward(from: 0.0);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller?.reset();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: DotLottieLoader.fromAsset(widget.path,
          frameBuilder: (context, dotlottie) {
        if (dotlottie != null) {
          return Lottie.memory(dotlottie.animations.values.single,
              width: 24,
              height: 24,
              controller: _controller,
              animate: widget.isSelected, onLoaded: (composition) {
            if (_controller?.duration != composition.duration) {
              _controller?.duration = composition.duration;
            }

            if (widget.isSelected &&
                _controller?.status != AnimationStatus.completed) {
              _controller?.forward();
            }
          });
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
