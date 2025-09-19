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
      color: const Color(0xFFE2FDFE),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1099FB),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Text(
              'AI',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            '9.6 12:12',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF565656),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              '马斯克将头像换成了AI16Z的logo，',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF565656),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 24.w,
            color: const Color(0xFF565656),
          ),
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