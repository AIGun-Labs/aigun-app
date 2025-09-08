import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class NeonInputField extends StatelessWidget {
  const NeonInputField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.inputFormatters,
      this.controller,
      this.onFieldSubmitted,
      this.maxLength,
      this.obscureText});

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
      style: TextStyle(color: AppColors.white, fontSize: 20.sp),
    );
  }

  /// 如需修改输入内容的字体大小，请在TextFormField的style属性中设置TextStyle的fontSize。
  /// 例如：style: TextStyle(color: AppColors.backgroundWhite, fontSize: 18)
  /// 你可以将fontSize参数作为NeonInputField的可选参数传入，然后在style中使用。
  /// 这里只负责InputDecoration的构建，输入内容字体大小不在InputDecoration中设置。

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      fillColor: AppColors.black.withValues(alpha: 0.7),
      hintStyle: TextStyle(
        color: AppColors.textTertiary(context),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderSecondary(context),
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
