import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';

class CommonSheet extends StatelessWidget {
  const CommonSheet({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedPadding(
          padding: padding ??
              EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.h),
          duration: const Duration(milliseconds: 200),
          child: CommonSheetContent(child: child)),
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
                borderRadius: BorderRadius.circular(2.r)),
          ),
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}
