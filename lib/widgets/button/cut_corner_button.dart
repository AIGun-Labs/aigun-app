import 'package:flutter/material.dart';

enum ButtonDecoration {
  none,

  topRight,

  bottomRight,

  topLeft,

  bottomLeft,

  all,

  top,

  bottom,

  left,

  right,
}

///

class CutCornerButton extends StatelessWidget {
  final Widget child;

  final VoidCallback? onPressed;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final double cutDepth;

  final EdgeInsetsGeometry? padding;

  final ButtonDecoration decoration;

  const CutCornerButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.yellow,
    this.foregroundColor = Colors.black,
    this.cutDepth = 15.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.decoration = ButtonDecoration.topRight,
  });

  BorderRadius _createBorderRadius() {
    switch (decoration) {
      case ButtonDecoration.none:
        return BorderRadius.zero;
      case ButtonDecoration.topRight:
        return BorderRadius.only(topRight: Radius.circular(cutDepth));
      case ButtonDecoration.bottomRight:
        return BorderRadius.only(bottomRight: Radius.circular(cutDepth));
      case ButtonDecoration.topLeft:
        return BorderRadius.only(topLeft: Radius.circular(cutDepth));
      case ButtonDecoration.bottomLeft:
        return BorderRadius.only(bottomLeft: Radius.circular(cutDepth));
      case ButtonDecoration.all:
        return BorderRadius.all(Radius.circular(cutDepth));
      case ButtonDecoration.top:
        return BorderRadius.only(
          topLeft: Radius.circular(cutDepth),
          topRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.bottom:
        return BorderRadius.only(
          bottomLeft: Radius.circular(cutDepth),
          bottomRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.left:
        return BorderRadius.only(
          topLeft: Radius.circular(cutDepth),
          bottomLeft: Radius.circular(cutDepth),
        );
      case ButtonDecoration.right:
        return BorderRadius.only(
          topRight: Radius.circular(cutDepth),
          bottomRight: Radius.circular(cutDepth),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,

        elevation: 0,

        padding: padding,

        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

        shape: BeveledRectangleBorder(borderRadius: _createBorderRadius()),
      ),
      child: child,
    );
  }
}
