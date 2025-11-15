import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

class ButtonFollow extends StatefulWidget {
  const ButtonFollow(
      {super.key, required this.isFollowed, required this.onFollowTap});
  final bool isFollowed;
  final VoidCallback onFollowTap;
  @override
  State<ButtonFollow> createState() => _ButtonFollowState();
}

class _ButtonFollowState extends State<ButtonFollow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFollowTap,
      child: Container(
          height: 29.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: widget.isFollowed
                ? AppColors.primary
                : AppColors.foreground(context),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Text(
            widget.isFollowed ? S.of(context).followed : S.of(context).follow,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.2.h,
              fontWeight: FontWeight.w400,
              color: AppColors.background(context),
            ),
          )),
    );
  }
}
