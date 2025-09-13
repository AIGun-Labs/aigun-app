import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingCard extends StatelessWidget {
  const CustomSettingCard({
    super.key,
    required this.children,
    this.title,
    this.subtitle,
  });

  final List<Widget> children;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background(context),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
          side: BorderSide(color: AppColors.border(context), width: 1.r)),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedImage(
                    width: 50.w,
                    height: 50.h,
                    imageUrl: "assets/images/icons/cowboy-hat.png"),
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
    );
  }
}
