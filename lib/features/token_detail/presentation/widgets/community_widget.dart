import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/url.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/url.dart';

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        spacing: 15.w,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.h,
              children: [
                Text(
                  s.joinAIGunCommunity,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                _buildInfoItem(context, s.askQuestions),
                _buildInfoItem(context, s.feedbackReward),
                _buildInfoItem(context, s.projectUpdates),
                Row(
                  children: [
                    _buildJoinButton(
                      context,
                      s.followX,
                      Assets.images.icons.xLogo,
                      () {
                        launchUrl(UrlConfig.twitterENPath);
                      },
                    ),
                    SizedBox(width: 11.w),
                    _buildJoinButton(
                      context,
                      s.joinGroup,
                      Assets.images.icons.telegram,
                      () {
                        launchUrl(UrlConfig.telegramChatENPath);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 122.w,
            child: Image.asset(Assets.images.roleLiquor.path, width: 100.w),
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
            height: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.quaternary, width: 1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 15.w,
                  height: 15.w,
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
