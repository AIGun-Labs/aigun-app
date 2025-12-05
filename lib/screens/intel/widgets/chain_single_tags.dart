import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/language/language.dart';
import '../../../themes/colors.dart';
import '../../../utils/language_utils.dart';

class ChainSingleTags extends StatelessWidget {
  const ChainSingleTags({super.key, required this.tags});
  final List<Multilingual> tags;

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

  Widget _buildTag(BuildContext context, Multilingual tag) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.quinary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        LanguageUtils.getContentByLanguage(context, tag),
        style: TextStyle(
          color: AppColors.quaternary,
          fontSize: 14.sp,
          height: 1,
        ),
      ),
    );
  }
}
