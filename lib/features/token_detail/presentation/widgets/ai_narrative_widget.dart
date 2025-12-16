import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/extensions/multilingual_model_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/skeleton/widgets/text.dart';
import '../cubits/token_info/token_info_cubit.dart';

class AINarrativeWidget extends StatelessWidget {
  const AINarrativeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<TokenInfoCubit, TokenInfoState>(
      builder: (context, state) {
        final contents = state.tokenInfo?.narrative;

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
              if (state.status == TokenInfoStatus.loading)
                const AINarrativeSectionSkeleton()
              else
                Text(
                  contents?.getByLocale(context) ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),
            ],
          ),
        );
      },
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
        TextSkeleton(width: double.infinity, height: 18.h),
        SizedBox(height: 8.h),
        // 第二行内容骨架屏
        TextSkeleton(width: double.infinity, height: 18.h),
        SizedBox(height: 8.h),
        // 第三行内容骨架屏
        TextSkeleton(width: 280.w, height: 18.h),
      ],
    );
  }
}
