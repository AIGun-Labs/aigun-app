import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Auth Hint Text - Styled hint/error text for authentication forms
class AuthHintText extends StatelessWidget {
  const AuthHintText({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp, color: color ?? Colors.white),
    );
  }
}
