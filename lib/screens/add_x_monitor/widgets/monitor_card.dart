import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonitorCard extends StatelessWidget {
  final bool isWatching;
  final String username;
  final int accountCount;

  const MonitorCard({
    super.key,
    this.isWatching = false,
    this.username = 'elonmusk',
    this.accountCount = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(13.w),
      height: 70.w,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: InputTheme.getBorderColor(context)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                CachedImage(
                  imageUrl: 'assets/images/token.webp',
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).intelGroups_intelXGroupCryptoKol,
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            S.of(context).intelGroups_intelXGroupMonitorAll,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              height: 1,
                              fontSize: 14.sp,
                              color: AppColors.pirmary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).intelGroups_intelXGroupAccountInfo(
                                    accountCount.toString(),
                                    username,
                                  ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 1,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            ),
                          ),
                          Text(
                            S.of(context).intelGroups_intelXGroupCopyAiStrategy,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 1,
                              color: AppColors.pirmary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
