import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class AuthHintText extends StatelessWidget {
  const AuthHintText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
      ),
    );
  }
}
