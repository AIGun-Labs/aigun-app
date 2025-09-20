import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AINewsSection extends StatelessWidget {
  const AINewsSection({
    super.key,
    this.news = const [],
  });

  final List<AINewsItem> news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      color: AppColors.quinary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   child: Text.rich(
          //       softWrap: true,
          //       maxLines: 2,
          //       overflow: TextOverflow.ellipsis,
          //       TextSpan(children: [
          //         TextSpan(
          //             text: "AI",
          //             style: TextStyle(
          //                 fontSize: 14.sp,
          //                 fontWeight: FontWeight.w700,
          //                 color: AppColors.quaternary)),
          //         WidgetSpan(child: SizedBox(width: 4.w)),
          //         TextSpan(
          //             text: "9.6 12:12",
          //             style: TextStyle(
          //                 fontSize: 12.sp,
          //                 color: AppColors.textSecondary(context))),
          //         WidgetSpan(child: SizedBox(width: 4.w)),
          //         TextSpan(
          //           text: "马斯克将头像换成了AI16Z的logo，这将引发市场强烈关注，带来大量的资金，因此可买入...",
          //           style: TextStyle(
          //               fontSize: 14.sp,
          //               color: AppColors.textSecondary(context)),
          //         ),
          //       ])),
          // ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "AI",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.quaternary)),
                WidgetSpan(child: SizedBox(width: 4.w)),
                TextSpan(
                    text: "9.6 12:12",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context))),
                WidgetSpan(child: SizedBox(width: 4.w)),
                TextSpan(
                    text: "马斯克将头像换成了AI16Z的logo",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary(context))),
              ])),
              Text(
                "这将引发市场强烈关注，带来大量的资金，因此可买入",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
          SizedBox(
            width: 30.w,
            child: Icon(
              Icons.chevron_right,
              size: 24.w,
              color: AppColors.textSecondary(context),
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
