import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/monitor/index.dart';

class MonitorItem extends StatelessWidget {
  const MonitorItem({super.key, this.monitorList});
  final MonitorListType? monitorList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        border: Border.all(color: InputTheme.getBorderColor(context)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CachedImage(
                imageUrl: 'assets/images/token.webp',
                width: 40.w,
                height: 40.h,
                borderRadius: BorderRadius.circular(40.r),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      monitorList?.description ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@Nickname',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 90.w,
                height: 30.w,
                child: CustomButton(
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text(
                    S.of(context).intelGroups_intelXGroupWatch,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Introduction text here...',
            style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.bodySmall?.color),
          ),
        ],
      ),
    );
  }
}
