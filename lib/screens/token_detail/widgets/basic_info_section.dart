import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../cubits/index.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/clipboard.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/toast.dart';
import '../../../utils/url.dart';

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
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.basicInfo,
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
                      s.contractAddress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () async {
                        await ClipboardUtils.copy(contractAddress);
                        if (!context.mounted) return;
                        ToastUtils.showCenterToast(context, s.copySuccess);
                      },
                      child: Row(
                        children: [
                          Text(
                            contractAddress.splitStartAndEnd(4, 4),
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
                      s.blockchain,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      blockchain.capitelize(),
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
          BlocBuilder<TokenDetailCubit, TokenDetailState>(
              buildWhen: (previous, current) =>
                  previous.tokenUrls != current.tokenUrls,
              builder: (context, state) {
                return Row(
                  children: [
                    if (state.tokenUrls?.x?.trim() != null)
                      _buildSocialButton(
                        context,
                        'assets/images/icons/x-logo.svg',
                        () {
                          launchUrl(state.tokenUrls!.x!);
                        },
                      ),
                    SizedBox(width: 18.w),
                    if (state.tokenUrls?.telegram?.trim() != null)
                      _buildSocialButton(
                        context,
                        'assets/images/icons/telegram.svg',
                        () {
                          launchUrl(state.tokenUrls!.telegram!);
                        },
                      ),
                    SizedBox(width: 18.w),
                    if (state.tokenUrls?.discord?.trim() != null)
                      _buildSocialButton(
                        context,
                        'assets/images/icons/discord-outline.svg',
                        () {
                          launchUrl(state.tokenUrls!.discord!);
                        },
                      ),
                  ],
                );
              }),
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
