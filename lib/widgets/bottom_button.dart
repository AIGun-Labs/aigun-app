import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.child,
    this.color = Colors.transparent,
  });

  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.all(16.w),
      color: AppColors.background(context),
      child: child,
    );
  }
}
