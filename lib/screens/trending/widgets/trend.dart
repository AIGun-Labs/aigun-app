import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendPage extends StatefulWidget {
  const TrendPage({super.key});

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          style: TextStyle(
              color: AppColors.textSecondary(context), fontSize: 20.sp),
          '开发中...'),
    );
  }
}
