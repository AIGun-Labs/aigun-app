import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../button/follow.dart';
import '../image.dart';

class CardAgent extends StatefulWidget {
  final String name;
  final String avatarPath;
  final bool isFollowed;
  final VoidCallback? onFollowTap;
  final double? width;
  final double? height;
  const CardAgent({
    super.key,
    required this.name,
    required this.avatarPath,
    this.isFollowed = false,
    this.onFollowTap,
    this.width,
    this.height,
  });

  @override
  State<CardAgent> createState() => _CardAgentState();
}

class _CardAgentState extends State<CardAgent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 130.w,
      height: widget.height ?? 150.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border(context)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedImage(
              imageUrl: widget.avatarPath,
              width: 50.w,
              height: 50.w,
            ),
          ),
          SizedBox(height: 4.h),

          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          SizedBox(height: 16.h),

          ButtonFollow(
            isFollowed: widget.isFollowed,
            onFollowTap: widget.onFollowTap ?? () {},
          ),
        ],
      ),
    );
  }
}
