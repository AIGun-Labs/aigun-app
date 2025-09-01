import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class DogeXLogo extends StatelessWidget {
  const DogeXLogo({super.key, this.width = 100, this.height = 60});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.w,
      child: Image.asset("assets/images/logo/logo-white.png"),
    );
  }
}
