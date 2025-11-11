import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_aigun/widgets/skeleton/widgets/text.dart';
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
  final String? time;
  final String? content;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
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
                    text: time ?? "",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context))),
                WidgetSpan(child: SizedBox(width: 4.w)),
                // if (isLoading)
                //   WidgetSpan(
                //     child: TextSkeleton(width: double.infinity, height: 14.h),
                //   )
                // else
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
