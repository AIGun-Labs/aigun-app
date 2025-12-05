import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/index.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/extensions/multilingual_extension.dart';
import '../../../themes/colors.dart';
import '../../../widgets/skeleton/widgets/text.dart';

class AINarrativeSection extends StatelessWidget {
  const AINarrativeSection({super.key, this.contents, this.isLoading = false});

  final Multilingual? contents;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (contents?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

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
              contents?.getText(context) ?? '',
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
        
        TextSkeleton(
          width: double.infinity,
          height: 18.h,
        ),
        SizedBox(height: 8.h),
        
        TextSkeleton(
          width: double.infinity,
          height: 18.h,
        ),
        SizedBox(height: 8.h),
        
        TextSkeleton(
          width: 280.w,
          height: 18.h,
        ),
      ],
    );
  }
}
