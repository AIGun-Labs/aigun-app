import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RefreshLoadingWidget extends StatelessWidget {
  const RefreshLoadingWidget({super.key, required this.isRefreshing});

  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset(
      'assets/lottie/loading.lottie',
      frameBuilder: (context, dotlottie) {
        if (dotlottie != null) {
          return Lottie.memory(
            dotlottie.animations.values.single,
            height: 60.w,
            width: 60.w,
            animate: isRefreshing, 
            repeat: isRefreshing, 
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
