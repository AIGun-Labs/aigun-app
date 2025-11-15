import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../image.dart';

class AvatarDefaultUser extends StatelessWidget {
  const AvatarDefaultUser(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.borderRadius});

  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedImage(
        key: key,
        imageUrl: url,
        width: width ?? 60.w,
        height: height ?? 60.w,
        borderRadius: borderRadius ?? BorderRadius.circular(30.w));
  }
}
