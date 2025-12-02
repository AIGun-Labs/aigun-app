import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/time_pattern.dart';
import '../../../cubits/index.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../data/models/intel/intel.dart';
import '../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../themes/colors.dart';

class AINewsSection extends StatelessWidget {
  const AINewsSection({super.key, this.onTap});

  // final List<AINewsItem> news;
  // final String? time;
  // final String? content;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<TokenDetailCubit, TokenDetailState, Intel?>(
      selector: (state) => state.firstIntellgence,
      builder: (context, intellgence) {
        final localAnalyze = intellgence?.localAnalyze(context);
        // 如果第一条情报是空的 则是返回空内容
        if (localAnalyze?.isEmpty ?? true) return SizedBox();
        return Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 5.w,
            top: 12.h,
            bottom: 12.h,
          ),
          color: AppColors.quinary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'AI',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.quaternary,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 4.w)),
                      TextSpan(
                        text: intellgence?.publishedAt.fmt(
                          context,
                          pattern: TimePattern.hhMM,
                        ),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 4.w)),

                      TextSpan(
                        text: intellgence?.localAnalyze(context),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

class AINewsItem {
  final String time;
  final String content;
  final String tag;

  AINewsItem({required this.time, required this.content, this.tag = 'AI'});
}
