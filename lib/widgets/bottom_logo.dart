import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomLogo extends StatelessWidget {
  const BottomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo/logo-white.png',
        width: 86.w,
        height: 40.h,
      ),
    );
  }
}
