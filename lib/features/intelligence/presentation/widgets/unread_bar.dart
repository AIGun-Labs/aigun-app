import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

/// Unread Bar Widget
///
/// Displays a floating bar showing the count of unread intelligence items.
class UnreadBarWidget extends StatelessWidget {
  const UnreadBarWidget({
    super.key,
    required this.count,
    this.onTap,
  });

  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 100.h,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.quaternary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_upward, size: 18.sp, color: Colors.white),
                SizedBox(width: 2.w),
                Text(
                  S.of(context).newIntel(count),
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
