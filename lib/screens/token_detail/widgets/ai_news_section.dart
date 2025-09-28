import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AINewsSection extends StatelessWidget {
  const AINewsSection({
    super.key,
    this.news = const [],
    this.time,
    this.content,
    this.onTap,
  });

  final List<AINewsItem> news;
  final DateTime? time;
  final String? content;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final timeFormatted =
        DateUtilsHelper.formatUtcToLocal(time ?? DateTime.now(), "M.d HH:mm");

    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 5.w, top: 12.h, bottom: 12.h),
      color: AppColors.quinary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "AI",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.quaternary)),
                WidgetSpan(child: SizedBox(width: 4.w)),
                TextSpan(
                    text: timeFormatted,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context))),
                WidgetSpan(child: SizedBox(width: 4.w)),
                TextSpan(
                    text: content ?? '',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary(context))),
              ]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            child: GestureDetector(
              onTap: () {
                onTap?.call();
              },
              child: Icon(
                Icons.chevron_right,
                size: 24.w,
                color: AppColors.textSecondary(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AINewsItem {
  final String time;
  final String content;
  final String tag;

  AINewsItem({
    required this.time,
    required this.content,
    this.tag = 'AI',
  });
}
