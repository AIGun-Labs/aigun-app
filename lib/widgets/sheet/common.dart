import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';

class CommonSheet extends StatelessWidget {
  const CommonSheet({
    super.key,
    required this.child,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  final Widget child;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedPadding(
        padding: EdgeInsets.only(
          top: top ?? 16.h,
          right: right ?? 16.w,
          bottom: bottom ?? MediaQuery.of(context).viewInsets.bottom,
          left: left ?? 16.w,
        ),
        duration: const Duration(milliseconds: 200),
        child: SingleChildScrollView(child: CommonSheetContent(child: child)),
      ),
    );
  }
}

class CommonSheetContent extends StatelessWidget {
  const CommonSheetContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 4.h,
          width: 40.w,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textTertiary(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}
