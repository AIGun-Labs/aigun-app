import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkLogo extends StatelessWidget {
  final String logoPath;

  const NetworkLogo({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SvgPicture.network(
        logoPath,
        width: 45.w,
        height: 45.w,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => const SizedBox.shrink(),
      ),
    );
  }
}
