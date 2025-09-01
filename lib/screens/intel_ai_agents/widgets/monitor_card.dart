import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonitorCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Widget monitorInfo;
  final VoidCallback onTap;

  const MonitorCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.monitorInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: InputTheme.getBorderColor(context)),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          spacing: 10.w,
          children: [
            Column(
              children: [
                Center(
                  child: CachedImage(
                    imageUrl: imageUrl,
                    width: 86.w,
                    height: 86.w,
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                ),
              ],
            ),
            monitorInfo,
          ],
        ),
      ),
    );
  }
}
