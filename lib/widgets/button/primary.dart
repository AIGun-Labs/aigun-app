import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/button_theme.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  PrimaryButton(
      {Key? key,
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
      this.type = ButtonType.filled});
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
  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
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
        backgroundColor: widget.backgroundColor,
        textColor: widget.textColor,
        fontSize: widget.fontSize,
        borderSide: widget.borderSide,
        borderRadius: widget.borderRadius,
        padding: widget.padding,
        type: widget.type,
      ),
    );

    // 如果设置了宽度，用 Container 包装
    if (widget.width != null || widget.height != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        child: button,
      );
    }

    return button;
  }
}
