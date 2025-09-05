import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/date_time_helper.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/screens/intel/widgets_back/intel_content.dart';
import 'package:flutter_aigun/screens/intel/widgets_back/investment/index.dart';
import 'package:flutter_aigun/data/models/intel_back/intel.dart';

class IntelItem extends StatelessWidget {
  final int index;
  final bool isLast;
  final IntelMessage intel;

  const IntelItem({
    super.key,
    required this.index,
    this.isLast = false,
    required this.intel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
        bottom: isLast ? 10.h : 0,
      ),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部
          _buildHeader(context),
          SizedBox(height: 12.h),
          // 内容
          IntelContent(
            intel: intel,
          ),
          SizedBox(height: 12.h),
          // 投资机会
          InvestmentOpportunities(
            entities: intel.entities ?? [],
          ),
        ],
      ),
    );
  }

  /// 头部
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CachedImage(
          imageUrl: 'assets/images/token.webp',
          width: 40.w,
          height: 40.w,
          borderRadius: BorderRadius.circular(20.r),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intel.name ?? 'Unknown',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary(context),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateTimeHelper.formatTimestamp(intel.createdAt),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textQuinary(context),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
