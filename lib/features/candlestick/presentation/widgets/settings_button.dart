import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Icon(
          Icons.settings_outlined,
          size: 20.sp,
          color: AppColors.textSecondary(context),
        ),
      ),
    );
  }
}
