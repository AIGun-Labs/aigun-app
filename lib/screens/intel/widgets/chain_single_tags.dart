import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/data/models/multilingual_model.dart';
import '../../../shared/extensions/multilingual_model_extension.dart';
import '../../../themes/colors.dart';

class ChainSingleTags extends StatelessWidget {
  const ChainSingleTags({super.key, required this.tags});
  final List<MultilingualModel> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      runSpacing: 0,
      spacing: 8.w,
      children: tags.map((tag) => _buildTag(context, tag)).toList(),
    );
  }

  Widget _buildTag(BuildContext context, MultilingualModel tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.quinary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        tag.getByLocale(context),
        style: TextStyle(
          color: AppColors.quaternary,
          fontSize: 14.sp,
          height: 1,
        ),
      ),
    );
  }
}
