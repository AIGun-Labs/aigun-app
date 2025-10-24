import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/widgets/skeleton/widgets/text.dart';

class AINarrativeSection extends StatelessWidget {
  const AINarrativeSection(
      {super.key, this.content = '', this.isLoading = false});

  final String content;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.aiNarrativeAnalysis,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 15.h),
          if (isLoading)
            const AINarrativeSectionSkeleton()
          else
            Text(
              content.trim() == '' ? s.noAnalysis : content,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
        ],
      ),
    );
  }
}

class AINarrativeSectionSkeleton extends StatelessWidget {
  const AINarrativeSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 第一行内容骨架屏
        TextSkeleton(
          width: double.infinity,
          height: 18.h,
        ),
        SizedBox(height: 8.h),
        // 第二行内容骨架屏
        TextSkeleton(
          width: double.infinity,
          height: 18.h,
        ),
        SizedBox(height: 8.h),
        // 第三行内容骨架屏
        TextSkeleton(
          width: 280.w,
          height: 18.h,
        ),
      ],
    );
  }
}
