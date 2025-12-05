import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../themes/themes.dart";

class AIGunLogo extends StatelessWidget {
  const AIGunLogo({super.key, this.width = 100, this.height = 60});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.w,
      child: SvgPicture.asset("assets/images/logo/logo-text.svg",
          width: width.w,
          height: height.w,
          colorFilter:
              const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
    );
  }
}
