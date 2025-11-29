import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';

class ExpandableContent extends StatelessWidget {
  const ExpandableContent({super.key, this.content = ''});

  final String content;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content,
      trimMode: TrimMode.Line,
      trimLines: 3,
      trimCollapsedText: ' ${S.of(context).expand}',
      trimExpandedText: ' ${S.of(context).collapse}',
      moreStyle:
          TextStyle(color: AppColors.textSecondary(context), fontSize: 14.sp),
      lessStyle:
          TextStyle(color: AppColors.textSecondary(context), fontSize: 14.sp),
      style: TextStyle(color: AppColors.textPrimary(context), fontSize: 16.sp),
    );
  }
}
