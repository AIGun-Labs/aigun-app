import "package:flutter/material.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";

class DogeXLogo extends StatelessWidget {
  const DogeXLogo({super.key, this.width = 100, this.height = 60});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.w,
      child: SvgPicture.asset("assets/images/logo/logo-text.svg",
          colorFilter:
              ColorFilter.mode(AppColors.backgroundWhite, BlendMode.srcIn)),
    );
  }
}
