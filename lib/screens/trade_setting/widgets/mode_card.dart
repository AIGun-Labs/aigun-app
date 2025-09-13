import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeModeCard extends StatelessWidget {
  const TradeModeCard(
      {super.key,
      this.modeIcon,
      required this.modeTitle,
      required this.modeDescription,
      required this.onTap,
      required this.isSelected});

  final String? modeIcon;
  final String modeTitle;
  final String modeDescription;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background(context),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
          side: BorderSide(
              color: isSelected
                  ? AppColors.foreground(context)
                  : AppColors.border(context),
              width: isSelected ? 2.r : 1.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
              top: 10.h, bottom: 10.h, right: 16.w, left: 8.w),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.4,
                child: CachedImage(
                  imageUrl: modeIcon ?? "assets/images/icons/lightning.png",
                  height: 94.h,
                  width: 94.w,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    modeTitle,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary(context)),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    modeDescription,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context)),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
