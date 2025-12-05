import 'package:flutter/material.dart';

import '../../themes/button_theme.dart';
import '../../themes/themes.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 20.0,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.borderSide,
    this.padding,
    this.loading,
    this.cutSize = 0,
    this.disabledBackgroundColor = AppColors.quinary,
    this.type = ButtonType.filled,
  });
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget? label;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool? isLoading;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? padding;
  final ButtonType type;
  final Widget? loading;
  final double cutSize;
  final Color? disabledBackgroundColor;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton.icon(
      icon: widget.isLoading ?? false ? widget.loading : widget.icon,
      label: widget.label ?? const SizedBox.shrink(),
      onPressed: widget.onPressed,
      style: CustomButtonTheme.getStyle(
        context: context,
        backgroundColor: widget.backgroundColor ?? AppColors.primary,
        textColor: widget.textColor,
        fontSize: widget.fontSize,
        borderSide: widget.borderSide,
        borderRadius: widget.borderRadius,
        padding: widget.padding,
        type: widget.type,
        disabledBackgroundColor: widget.disabledBackgroundColor,
      ),
    );

    if (widget.width != null || widget.height != null) {
      button = SizedBox(
        width: widget.width,
        height: widget.height,
        child: button,
      );
    }

    if (widget.cutSize > 0) {
      button = ClipPath(
        clipper: CutCornerButtonClipper(cutSize: widget.cutSize),
        child: button,
      );
    }

    return button;
  }
}

class CutCornerButtonClipper extends CustomClipper<Path> {
  final double cutSize;

  CutCornerButtonClipper({this.cutSize = 20.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);

    path.lineTo(cutSize, size.height);

    path.lineTo(0, size.height - cutSize);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
