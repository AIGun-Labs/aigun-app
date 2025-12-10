import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../themes/themes.dart';

class CustomSettingCard extends StatelessWidget {
  const CustomSettingCard(
      {super.key,
      required this.children,
      this.title,
      this.subtitle,
      this.isSelected = false,
      this.onTap});

  final List<Widget> children;
  final String? title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: AppColors.background(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
            side: BorderSide(
                color: isSelected
                    ? AppColors.foreground(context)
                    : AppColors.border(context),
                width: isSelected ? 2.r : 1.r)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: const CustomSettingCardIcon(),
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "Custom Solana Trade",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context)),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle ?? "Suitable for experienced veterans",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary(context)),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - 60) / 2; // 动态计算宽度
                  return Wrap(
                    spacing: 60.0, // 水平间距
                    runSpacing: 28.0, // 垂直间距
                    children: children
                        .map((child) => SizedBox(
                              width: itemWidth,
                              child: child,
                            ))
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSettingCardIcon extends StatelessWidget {
  const CustomSettingCardIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset("assets/lottie/cowboy-hat.lottie",
        frameBuilder: (context, dotlottie) {
      if (dotlottie != null) {
        return Lottie.memory(dotlottie.animations.values.single,
            height: 50.w, width: 50.w);
      }
      return const SizedBox.shrink();
    });
  }
}
