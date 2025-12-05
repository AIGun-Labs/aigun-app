import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../themes/themes.dart';

class TextSkeleton extends StatelessWidget {
  const TextSkeleton(
      {super.key,
      required this.width,
      required this.height,
      this.borderRadius = 5});
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor(context),
          highlightColor: AppColors.shimmerHighlightColor(context),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.shimmerBaseColor(context),
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          )),
    );
  }
}
