import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/timeframe.dart';
import '../../../../l10n/l10n.dart' as app_l10n;
import '../../../../themes/colors.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    required this.isHighlighted,
    required this.selectedTimeframe,
    required this.onPressed,
  });

  final bool isHighlighted;
  final Timeframe? selectedTimeframe;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final displayText =
        selectedTimeframe?.label ?? app_l10n.S.of(context).common_more;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppColors.surface(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayText,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
                color: AppColors.textPrimary(context),
              ),
            ),
            SizedBox(width: 2.w),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14.sp,
              color: AppColors.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }
}
