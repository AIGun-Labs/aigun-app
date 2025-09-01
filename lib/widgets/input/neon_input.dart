import "package:flutter/material.dart";
import "package:flutter_aigun/themes/colors.dart";

class NeonInputField extends StatelessWidget {
  const NeonInputField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.controller,
      this.onFieldSubmitted,
      this.maxLength,
      this.obscureText});

  final TextEditingController? controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(context),
      onChanged: onChanged,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      style: const TextStyle(color: AppColors.backgroundWhite),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      fillColor: Colors.black.withValues(alpha: 0.7),
      hintStyle: TextStyle(
          color: AppColors.textQuinary(context),
          fontSize: 20,
          fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF29ABE2),
          width: 3,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF973DFF),
          width: 3,
        ),
      ),
      counterText: "",
    );
  }
}
