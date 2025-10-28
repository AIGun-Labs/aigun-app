import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.child,
      this.paddingValue = 18,
      this.backgroundColor});
  final Widget child;
  final double paddingValue;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(paddingValue.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.card(context),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: child,
    );
  }
}
