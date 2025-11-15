// Start of Selection
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import '../themes/input_theme.dart';
import '../utils/theme.dart';

class CustomInput extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final TextEditingController? controller;
  final double? height;
  final Color? hintColor;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final Color? textColor;
  final double? fontSize;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final BorderSide? borderSide;
  final bool isOutline;
  final int maxLines;
  final int? maxLength;
  final String? counterText;
  const CustomInput({
    super.key,
    this.isPassword = false,
    required this.hintText,
    this.controller,
    this.height,
    this.hintColor,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.textColor,
    this.fontSize,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.borderSide,
    this.isOutline = false,
    this.maxLines = 1,
    this.maxLength,
    this.counterText,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;
  late double? _height;

  @override
  void initState() {
    super.initState();
    _height = widget.isOutline ? widget.height?.h ?? 60.h : widget.height?.h;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeUtils.isDark(context);
    return SizedBox(
      height: _height,
      child: TextField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        obscureText: widget.isPassword && _obscureText,
        autofocus: false,
        style: widget.textColor != null || widget.fontSize != null
            ? TextStyle(
                fontSize: widget.fontSize?.sp ?? 20.sp,
                color: widget.textColor ?? AppColors.textPrimary(context))
            : InputTheme.getTextStyle(context),
        decoration: _buildInputDecoration(isDark),
        textAlignVertical: TextAlignVertical.center,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        maxLines: widget.maxLines,
      ),
    );
  }

  InputDecoration _buildInputDecoration(bool isDark) {
    final theme = widget.isOutline
        ? InputTheme.outlinedInputDecorationTheme(context,
            borderRadius: widget.borderRadius, fillColor: widget.fillColor)
        : InputTheme.plainInputDecorationTheme(context,
            borderRadius: widget.borderRadius, fillColor: widget.fillColor);

    return theme.copyWith(
      hintText: widget.hintText,
      hintStyle: TextStyle(
        fontSize: widget.fontSize?.sp ?? 20.sp,
        color: widget.hintColor ??
            InputTheme.getHintColor(context, widget.isOutline),
      ),
      prefixIcon: _buildPrefixIcon(),
      prefixIconConstraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
      suffixIcon: _buildSuffixIcon(),
      suffixIconConstraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
      contentPadding: widget.contentPadding,
      enabledBorder: widget.enabledBorder,
      focusedBorder: widget.focusedBorder,
      errorBorder: widget.errorBorder,
      focusedErrorBorder: widget.focusedErrorBorder,
      counterText: widget.counterText,
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;
    return Transform.translate(
      offset: Offset(5.0.w, 0),
      child: widget.prefixIcon,
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }
    if (widget.suffixIcon == null) return null;
    return Transform.translate(
      offset: Offset(-14.w, 0),
      child: widget.suffixIcon,
    );
  }
}
