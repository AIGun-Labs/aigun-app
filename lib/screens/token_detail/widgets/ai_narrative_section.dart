import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AINarrativeSection extends StatelessWidget {
  const AINarrativeSection({
    super.key,
    this.content = '',
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI叙事分析',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            content.isEmpty
                ? 'ai16z刻意模仿知名风投机构 Andreessen Horowitz（a16z），创始人 Shaw 公开表示希望通过 AI 技术在投资领域「打败 Marc Andreessen」。这种对标引发市场对其创新性的期待，同时借助 a16z 的品牌效应快速吸引关注。例如，Marc Andreessen 本人曾在社交媒体上转发互动，称 ai16z 为「挑战者」，进一步推高项目热度。'
                : content,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}