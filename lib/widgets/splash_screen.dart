import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_aigun/data/services/permissions_service.dart';
import 'package:flutter_aigun/utils/extensions/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/storage/local/permission_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/router/constants.dart';

// 启动动画设置
const List<String> splashImages = [
  "assets/images/splash/splash-1.jpg",
  "assets/images/splash/splash-2.jpg",
  "assets/images/splash/splash-3.jpg",
];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String _backgroundImage =
      splashImages.getRandomItem() ?? splashImages[0];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _requestPrivacyPermission());
  }

  Future<void> _requestPrivacyPermission() async {
    final bool? agreed =
        await PermissionsService.requestPrivacyPermission(context);

    // if (kDebugMode) {
    //   context.goNamed(RouteNames.intel);
    // }

    if (!mounted) return;

    if (agreed ?? false) {
      context.read<SoundEffectCubit>().playGunSound();
      getIt<PermissionStorage>().setPrivacyPermission(true);

      Future.delayed(const Duration(seconds: 2), () {
        context.goNamed(RouteNames.intel);
      });
    } else {
      getIt<PermissionStorage>().setPrivacyPermission(false);
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.15,
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
      // backgroundColor: AppColors.background(context),
      // onEnd: () {
      //   context.goNamed(RouteNames.intel);
      // },
    );
  }
}
