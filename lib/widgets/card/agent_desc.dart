import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../button/follow.dart';
import '../image.dart';

class CardAgentDesc extends StatefulWidget {
  final String name;
  final String avatarPath;

  final bool isFollowed;
  final String? desc;
  final VoidCallback? onFollowTap;
  const CardAgentDesc({
    super.key,
    required this.name,
    required this.avatarPath,
    this.desc,
    this.isFollowed = false,
    this.onFollowTap,
  });

  @override
  State<CardAgentDesc> createState() => _CardAgentDescState();
}

class _CardAgentDescState extends State<CardAgentDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      height: 210.h,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        border: Border.all(color: AppColors.border(context)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedImage(
              imageUrl: widget.avatarPath,
              width: 65.w,
              height: 65.w,
            ),
          ),

          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Expanded(
            child: Text(
              widget.desc ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary(context),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          ButtonFollow(
            isFollowed: widget.isFollowed,
            onFollowTap: widget.onFollowTap ?? () {},
          ),
        ],
      ),
    );
  }
}
