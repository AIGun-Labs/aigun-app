import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double? topPadding;
  final Color? color;

  const TitleText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.topPadding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
