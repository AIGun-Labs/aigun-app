import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/router/constants.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import '../gen/assets.gen.dart';
import '../themes/themes.dart';
import '../utils/extensions/list.dart';

List<String> splashImages = [
  Assets.images.splash.splash1.path,
  Assets.images.splash.splash2.path,
  Assets.images.splash.splash3.path,
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _requestPrivacyPermission(),
    );
  }

  Future<void> _requestPrivacyPermission() async {
    if (!mounted) return;

    context.read<SoundEffectCubit>().playGunSound();

    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(RouteNames.intel);
    });
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
                  'assets/images/logo/logo-text.svg',
                  width: 200.w,
                  height: 70.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
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
