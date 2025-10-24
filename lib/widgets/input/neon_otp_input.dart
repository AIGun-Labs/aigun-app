import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pinput/pinput.dart";

class NeonOTPInput extends StatelessWidget {
  const NeonOTPInput(
      {super.key,
      required this.codeLength,
      required this.onChanged,
      required this.inputWidth,
      required this.inputHeight,
      required this.borderColor,
      required this.focusedBorderColor,
      required this.onCompleted});

  final int codeLength;
  final Function(String) onChanged;
  final double inputWidth;
  final double inputHeight;
  final Color borderColor;
  final Color focusedBorderColor;
  final Function(String) onCompleted;
  PinTheme get defaultPinTheme => PinTheme(
        width: inputWidth,
        height: inputHeight,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            border: Border.all(color: borderColor, width: 3)),
      );

  PinTheme get focusedPinTheme => defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: focusedBorderColor, width: 3),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: codeLength,
      onChanged: onChanged,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      onCompleted: onCompleted,
      keyboardType: TextInputType.number,
    );
  }
}
