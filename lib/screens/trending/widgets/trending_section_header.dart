import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class TrendingSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const TrendingSectionHeader({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.17,
            ),
          ),
          const Spacer(),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: const Color(0xFF909090),
              ),
            ),
        ],
      ),
    );
  }
}
