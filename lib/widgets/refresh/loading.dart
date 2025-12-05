import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RefreshLoading extends StatelessWidget {
  const RefreshLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset("assets/lottie/loading.lottie",
        frameBuilder: (context, dotlottie) {
      if (dotlottie != null) {
        return Lottie.memory(dotlottie.animations.values.single,
            height: 60.h, width: 60.w);
      }
      return const SizedBox.shrink();
    });
  }
}
