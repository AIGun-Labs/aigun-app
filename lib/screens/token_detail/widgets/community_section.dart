import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '加入AIGun社区',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoItem('咨询问题，获取解答与帮助'),
          SizedBox(height: 16.h),
          _buildInfoItem('反馈建议拿奖励'),
          SizedBox(height: 16.h),
          _buildInfoItem('获取项目一手动态'),
          SizedBox(height: 20.h),
          Row(
            children: [
              _buildJoinButton(
                context,
                'Follow X',
                'assets/images/icons/x-logo.svg',
                () {},
              ),
              SizedBox(width: 11.w),
              _buildJoinButton(
                context,
                'Join Group',
                'assets/images/icons/telegram.svg',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xFF565656),
      ),
    );
  }

  Widget _buildJoinButton(
    BuildContext context,
    String label,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF1099FB),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 15.w,
                  height: 15.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF000000),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}