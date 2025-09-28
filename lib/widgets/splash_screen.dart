import 'dart:math';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter_aigun/utils/extensions/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/tabbar/tabbar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// 启动动画设置
const List<String> splashImages = [
  "assets/images/splash/splash-1.jpg",
  "assets/images/splash/splash-2.jpg",
  "assets/images/splash/splash-3.jpg",
];

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 2),
      useImmersiveMode: true, // 使用沉浸式模式
      childWidget: Container(
        child: Stack(
          children: [
            Image.asset(splashImages.getRandomItem() ?? ""),
            Positioned.fill(
              top: 150.h,
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/images/logo/logo-text.svg",
                  width: 200.w,
                  height: 70.h,
                  colorFilter:
                      const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),
            )
          ],
        ),
      ),
      nextScreen: const TabbarScreen(),
      // backgroundColor: AppColors.background(context),
      onEnd: () {
        context.go(Routes.home, extra: NavIndex.intel);
      },
    );
  }
}
