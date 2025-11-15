import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/url.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/url.dart';

class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.joinAIGunCommunity,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
              SizedBox(height: 15.h),
              _buildInfoItem(context, s.askQuestions),
              SizedBox(height: 15.h),
              _buildInfoItem(context, s.feedbackReward),
              SizedBox(height: 15.h),
              _buildInfoItem(context, s.projectUpdates),
              SizedBox(height: 15.h),
              Row(
                children: [
                  _buildJoinButton(
                    context,
                    s.followX,
                    'assets/images/icons/x-logo.svg',
                    () {
                      launchUrl(UrlConfig.twitterENPath);
                    },
                  ),
                  SizedBox(width: 11.w),
                  _buildJoinButton(
                    context,
                    s.joinGroup,
                    'assets/images/icons/telegram.svg',
                    () {
                      launchUrl(UrlConfig.telegramChatENPath);
                    },
                  ),
                ],
              ),
            ],
          )),
          SizedBox(width: 15.w),
          SizedBox(
            width: 122.w,
            child: Image.asset(
              'assets/images/role-liquor.png',
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textSecondary(context),
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
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.quaternary,
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
