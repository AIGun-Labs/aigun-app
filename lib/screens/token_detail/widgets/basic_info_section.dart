import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({
    super.key,
    this.contractAddress = '',
    this.blockchain = 'Solana',
  });

  final String contractAddress;
  final String blockchain;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '基础信息',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '合约地址',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        ClipboardUtils.copy(contractAddress);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '已复制',
                              style: TextStyle(
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                            backgroundColor: AppColors.card(context),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            contractAddress.isEmpty
                                ? 'pump...2344'
                                : contractAddress.splitStartAndEnd(4, 4),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '区块链',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      blockchain,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              _buildSocialButton(
                context,
                'assets/images/icons/x-logo.svg',
                () {},
              ),
              SizedBox(width: 18.w),
              _buildSocialButton(
                context,
                'assets/images/icons/telegram.svg',
                () {},
              ),
              SizedBox(width: 18.w),
              _buildSocialButton(
                context,
                'assets/images/icons/discord-outline.svg',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: const BoxDecoration(
          color: Color(0xFFE2FDFE),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          iconPath,
          width: 15.w,
          height: 15.h,
          colorFilter: const ColorFilter.mode(
            Color(0xFF000000),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
