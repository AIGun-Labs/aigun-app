import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      margin: EdgeInsets.only(right: 20.w),
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.textQuinary(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: S.of(context).intelGroups_intelXGroupNotifyAll,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 24.w,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          dropdownColor: AppColors.background(context),
          borderRadius: BorderRadius.circular(8.r),
          items: [
            S.of(context).intelGroups_intelXGroupNotifyAll,
            S.of(context).intelGroups_intelXGroupNotifyImportant,
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              // 处理选择
            }
          },
        ),
      ),
    );
  }
}
