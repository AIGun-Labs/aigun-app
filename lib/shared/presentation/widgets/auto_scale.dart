import 'package:flutter/material.dart';

class AutoScale extends StatelessWidget {
  const AutoScale(
      {super.key,
      required this.child,
      this.fit = BoxFit.scaleDown,
      this.alignment = Alignment.center});

  final Widget child;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: fit,
      alignment: alignment,
      child: child,
    );
  }
}
