import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';

class ButtonFollow extends StatefulWidget {
  const ButtonFollow({super.key});

  @override
  State<ButtonFollow> createState() => _ButtonFollowState();
}

class _ButtonFollowState extends State<ButtonFollow> {
  bool _isFollowed = true;

  void _onFollowTap() {
    setState(() {
      _isFollowed = !_isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onFollowTap,
      child: Container(
          height: 28.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color:
                _isFollowed ? AppColors.primary : AppColors.foreground(context),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Text(
            _isFollowed ? S.of(context).followed : S.of(context).follow,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.h,
              fontWeight: FontWeight.w400,
              color: AppColors.background(context),
            ),
          )),
    );
  }
}
