import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      childWidget: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/welcome.webp',
              width: 260.w,
              height: 260.h,
            ),
            SizedBox(height: 20.h),
            Image.asset(
              'assets/images/logo/logo-black.png',
              width: 200.w,
              height: 70.h,
            ),
            SizedBox(height: 30.h),
            Text(
              S.of(context).branding_cryptoAiFriend,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: AppColors.black,
      backgroundColor: AppColors.background(context),
      onEnd: () {
        // context.go(Routes.login);
        context.go(Routes.home, extra: NavIndex.intel);
      },
    );
  }
}
