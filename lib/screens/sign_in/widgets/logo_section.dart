import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 180.w,
          height: 62.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo/logo-white.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          S.of(context).branding_cryptoAiFriend,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
