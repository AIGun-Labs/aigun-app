import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../themes/colors.dart";

class NeonInputField extends StatelessWidget {
  const NeonInputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.inputFormatters,
    this.controller,
    this.onFieldSubmitted,
    this.maxLength,
    this.obscureText,
  });

  final TextEditingController? controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(context),
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      style: TextStyle(color: Colors.white, fontSize: 20.sp),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      fillColor: Colors.black.withValues(alpha: 0.7),
      hintStyle: TextStyle(
        color: AppColors.textTertiary(context),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderTertiary(context),
          width: 3,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF973DFF), width: 3),
      ),
      counterText: "",
    );
  }
}
