import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/button_theme.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {super.key,
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
      this.disabledBackgroundColor,
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
  final double cutSize;
  final Color? disabledBackgroundColor;
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

    // 如果设置了宽度，用 Container 包装
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

/// 一个自定义的 Clipper，用于在左下角创建一个切角效果。
class CutCornerButtonClipper extends CustomClipper<Path> {
  /// 切角的大小
  final double cutSize;

  CutCornerButtonClipper({this.cutSize = 20.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    // 1. 从左上角开始 (0, 0)
    path.moveTo(0, 0);

    // 2. 画到右上角 (width, 0)
    path.lineTo(size.width, 0);

    // 3. 画到右下角 (width, height)
    path.lineTo(size.width, size.height);

    // 4. 画到底部切角的起始点 (cutSize, height)
    path.lineTo(cutSize, size.height);

    // 5. 画到左边切角的结束点 (0, height - cutSize)
    path.lineTo(0, size.height - cutSize);

    // 6. 闭合路径，自动连接到起点 (0, 0)
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // 如果切角大小是动态变化的，这里应该返回 true
    return false;
  }
}
