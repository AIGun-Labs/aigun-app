import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/time_pattern.dart';
import '../../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/language_utils.dart';
import '../cubits/intels/intels_cubit.dart';

class LatestIntelWidget extends StatelessWidget {
  const LatestIntelWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return BlocBuilder<IntelsCubit, IntelsState>(
      buildWhen: (previous, current) =>
          previous.latestIntel != current.latestIntel,
      builder: (context, state) {
        final latestIntel = state.latestIntel;
        if (latestIntel == null) {
          return const SizedBox.shrink();
        }

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
                        text: latestIntel.publishedAt.fmt(
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
                        text: LanguageUtils.getContentByLanguageV2(
                          context,
                          latestIntel.analyzed,
                        ),
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
                  onTap: () => tabController.animateTo(1),
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
