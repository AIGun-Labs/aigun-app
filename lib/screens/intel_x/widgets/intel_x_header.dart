import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/screens/intel_x/widgets/notification_options.dart';
import 'package:flutter_aigun/l10n/l10n.dart';

class IntelXHeader extends StatelessWidget {
  const IntelXHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        // height: 120.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/new-coin.png',
              width: 120.w,
              height: 120.w,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        S.of(context).intelGroups_intelXGroupNotifyTitle('bro'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        S.of(context).intelGroups_intelXGroupNotifyDesc,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  const NotificationOptions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
