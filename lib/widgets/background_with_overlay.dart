import 'package:flutter/material.dart';
import '../utils/theme.dart';

class BackgroundWithOverlay extends StatelessWidget {
  final String? backgroundImage;
  final double? overlayOpacity;
  final Widget child;

  const BackgroundWithOverlay({
    super.key,
    this.backgroundImage,
    required this.child,
    this.overlayOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final overlayOpacity = this.overlayOpacity ?? 0.5;
    final overlayColor = Colors.black.withValues(
      alpha: ThemeUtils.isDark(context) ? overlayOpacity + 0.1 : overlayOpacity,
    );

    return Stack(
      children: [
        Image.asset(
          backgroundImage ?? 'assets/images/login-bg.webp',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
        Container(color: overlayColor),
        SafeArea(child: child),
      ],
    );
  }
}
