import 'package:flutter/material.dart';
import '../themes/button_theme.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final double? width;
  final double height;
  final bool hasShadow;
  final BorderSide? borderSide;
  final bool isBottomButton;
  final BorderRadius? borderRadius;
  final ButtonType type;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.text = '',
    this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 20.0,
    this.width,
    this.height = 60.0,
    this.hasShadow = false,
    this.borderSide,
    this.isBottomButton = false,
    this.borderRadius,
    this.type = ButtonType.filled,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: CustomButtonTheme.getStyle(
        context: context,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize,
        hasShadow: hasShadow,
        borderSide: borderSide,
        isBottomButton: isBottomButton,
        borderRadius: borderRadius,
        type: type,
      ),
      child: child ?? Text(text ?? ''),
    );

    return SizedBox(
      width: width,
      height: isBottomButton ? 50.0 : height,
      child: button,
    );
  }
}
