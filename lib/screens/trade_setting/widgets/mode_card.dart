import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeModeCard extends StatelessWidget {
  const TradeModeCard(
      {Key? key,
      this.modeIcon,
      required this.modeTitle,
      required this.modeDescription,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

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
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
              color: isSelected
                  ? AppColors.foreground(context)
                  : AppColors.border(context),
              width: 1.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding:
              EdgeInsetsGeometry.only(top: 16.h, bottom: 16.h, right: 16.w),
          child: Row(
            children: [
              CachedImage(
                imageUrl: modeIcon ?? "assets/images/icons/lightning.png",
                height: 94.h,
                width: 94.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    modeTitle,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary(context)),
                  ),
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
