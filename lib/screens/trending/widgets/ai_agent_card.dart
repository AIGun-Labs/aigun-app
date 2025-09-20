import 'package:flutter/material.dart';
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
          // 头像
          Container(
            width: 45.w,
            height: 45.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.asset(
                avatarPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 25.sp,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
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
                color: AppColors.black,
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
              width: 51.w,
              height: 26.h,
              decoration: BoxDecoration(
                color: isFollowed ? AppColors.black : const Color(0xFF1099FB),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Text(
                  isFollowed ? '已关注' : '关注',
                  style: TextStyle(
                    fontFamily: 'PingFang HK',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    height: 1,
                  ),
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
