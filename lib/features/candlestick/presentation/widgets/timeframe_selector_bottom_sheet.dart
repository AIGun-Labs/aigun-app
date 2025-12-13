import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/timeframe.dart';
import '../../../../l10n/l10n.dart' as app_l10n;
import '../../../../themes/colors.dart';
import '../../../../widgets/sheet/common.dart';

/// Shows a bottom sheet with all timeframe options
void showTimeframeSelectorBottomSheet({
  required BuildContext context,
  required Timeframe currentSelection,
  required ValueChanged<Timeframe> onSelected,
  required List<Timeframe> availableTimeframes,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.background(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => TimeframeSelectorBottomSheet(
      currentSelection: currentSelection,
      onSelected: onSelected,
      availableTimeframes: availableTimeframes,
    ),
  );
}

class TimeframeSelectorBottomSheet extends StatelessWidget {
  const TimeframeSelectorBottomSheet({
    super.key,
    required this.currentSelection,
    required this.onSelected,
    required this.availableTimeframes,
  });

  final Timeframe currentSelection;
  final ValueChanged<Timeframe> onSelected;
  final List<Timeframe> availableTimeframes;

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              app_l10n.S.of(context).common_selectTimeframe,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildTimeframeGrid(context),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildTimeframeGrid(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: availableTimeframes.map((timeframe) {
        final isSelected = timeframe == currentSelection;
        return _TimeframeGridItem(
          timeframe: timeframe,
          isSelected: isSelected,
          onTap: () => onSelected(timeframe),
        );
      }).toList(),
    );
  }
}

class _TimeframeGridItem extends StatelessWidget {
  const _TimeframeGridItem({
    required this.timeframe,
    required this.isSelected,
    required this.onTap,
  });

  final Timeframe timeframe;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface(context),
          borderRadius: BorderRadius.circular(10.r),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        child: Text(
          timeframe.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.primary : AppColors.textPrimary(context),
          ),
        ),
      ),
    );
  }
}
