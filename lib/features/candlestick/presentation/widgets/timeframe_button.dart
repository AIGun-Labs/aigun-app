import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/timeframe.dart';
import '../../../../l10n/l10n.dart' as app_l10n;
import '../../../../themes/colors.dart';

class TimeframeButton extends StatelessWidget {
  const TimeframeButton({
    super.key,
    required this.timeframe,
    required this.isSelected,
    required this.onPressed,
  });

  final Timeframe timeframe;
  final bool isSelected;
  final VoidCallback onPressed;

  String _getShortLabel(BuildContext context) {
    switch (timeframe) {
      case Timeframe.m1:
        return app_l10n.S.of(context).chart_period_1min;
      case Timeframe.m5:
        return app_l10n.S.of(context).chart_period_5min;
      case Timeframe.m10:
        return app_l10n.S.of(context).chart_period_10min;
      case Timeframe.m15:
        return app_l10n.S.of(context).chart_period_15min;
      case Timeframe.m30:
        return app_l10n.S.of(context).chart_period_30min;
      case Timeframe.h1:
        return app_l10n.S.of(context).chart_period_1hour;
      case Timeframe.h4:
        return app_l10n.S.of(context).chart_period_4hour;
      case Timeframe.d1:
        return app_l10n.S.of(context).chart_period_1day;
      case Timeframe.w1:
        return app_l10n.S.of(context).chart_period_1week;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface(context) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          _getShortLabel(context),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
    );
  }
}
