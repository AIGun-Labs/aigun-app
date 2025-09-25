import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class AIAgentCard extends StatelessWidget {
  final String name;
  final String avatarPath;
  final bool isFollowed;
  final VoidCallback? onFollowTap;

  const AIAgentCard({
    super.key,
    required this.name,
    required this.avatarPath,
    this.isFollowed = false,
    this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 150.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDE3E1)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          ClipOval(
            child: CachedImage(imageUrl: avatarPath, width: 45.w, height: 45.h),
          ),
          SizedBox(height: 11.h),
          // 名称
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.17,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          // 关注按钮
          GestureDetector(
            onTap: onFollowTap,
            child: Container(
              // height: 26.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isFollowed ? Colors.black : AppColors.quaternary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                isFollowed ? '已关注' : '关注',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PingFang HK',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
