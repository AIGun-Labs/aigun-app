import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/tabbar/wallet-active.json",
          width: 100.w,
          height: 100.h,
          fit: BoxFit.contain,
          animate: true,
          repeat: true, errorBuilder: (context, error, stackTrace) {
        Logger.error(error.toString());
        return const SizedBox.shrink();
      }),
    );
  }
}
