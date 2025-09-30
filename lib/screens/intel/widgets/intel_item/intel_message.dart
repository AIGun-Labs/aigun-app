import 'package:flutter/material.dart';
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/format/number.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:flutter_aigun/l10n/l10n.dart";

class IntelMessageInfo extends StatelessWidget {
  const IntelMessageInfo({super.key, this.analyzedTime, this.monitorTime});

  final double? analyzedTime;
  final double? monitorTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // "AIGun：The world's fastest AI monitoring and analysis",
          "AIGun：${S.of(context).intel_worldsFastest}",
          style: TextStyle(
              color: AppColors.textTertiary(context), fontSize: 12.sp),
        ),
        Row(
          children: [
            // Icon(Icons.access_time, color: AppColors.textTertiary(context)),
            SvgPicture.asset(
              "assets/images/icons/time-monitor.svg",
              width: 17.w,
              height: 17.h,
              colorFilter: ColorFilter.mode(
                AppColors.textTertiary(context),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              // "Event monitor: ${convertMillisecondToSecond(monitorTime ?? 0)} s",
              S.of(context).intel_eventMonitor(
                  convertMillisecondToSecond(monitorTime ?? 0)),
              style: TextStyle(
                  color: AppColors.textTertiary(context), fontSize: 12.sp),
            ),
            const SizedBox(
              width: 10,
            ),
            if (analyzedTime != null)
              Text(
                // "AI analysis: ${convertMillisecondToSecond(analyzedTime ?? 0)} s",
                S.of(context).inte_aiAnalysis(
                    convertMillisecondToSecond(analyzedTime ?? 0)),
                style: TextStyle(
                    color: AppColors.textTertiary(context), fontSize: 12.sp),
              ),
          ],
        )
      ],
    );
  }
}
