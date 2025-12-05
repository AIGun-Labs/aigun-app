import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/toast.dart';
import '../../../../utils/url.dart';
import '../cubits/token_info/token_info_cubit.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.h,
        children: [
          Text(
            s.basicInfo,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.h,
                  children: [
                    Text(
                      s.contractAddress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    BlocBuilder<TokenInfoCubit, TokenInfoState>(
                      builder: (context, state) {
                        final contractAddress = state.tokenInfo?.address ?? '';
                        return GestureDetector(
                          onTap: () async {
                            await ClipboardUtils.copy(contractAddress);
                            if (!context.mounted) return;
                            ToastUtils.showCenterToast(context, s.copySuccess);
                          },
                          child: Text(
                            contractAddress.splitStartAndEnd(4, 4),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.h,
                  children: [
                    Text(
                      s.blockchain,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    BlocBuilder<TokenInfoCubit, TokenInfoState>(
                      builder: (context, state) {
                        final chainName =
                            state.tokenInfo?.chainName ??
                            state.tokenInfo?.network ??
                            '';

                        return Text(
                          chainName.capitelize(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary(context),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          BlocBuilder<TokenInfoCubit, TokenInfoState>(
            builder: (context, state) {
              final urls = state.urls;
              if (urls == null) return const SizedBox.shrink();
              return Row(
                children: [
                  if (urls.x?.isNotEmpty ?? false)
                    _buildSocialButton(
                      context,
                      'assets/images/icons/x-logo.svg',
                      () {
                        launchUrl(urls.x!);
                      },
                    ),
                  SizedBox(width: 18.w),
                  if (urls.telegram?.isNotEmpty ?? false)
                    _buildSocialButton(
                      context,
                      'assets/images/icons/telegram.svg',
                      () {
                        launchUrl(urls.telegram!);
                      },
                    ),
                  SizedBox(width: 18.w),
                  if (urls.discord?.isNotEmpty ?? false)
                    _buildSocialButton(
                      context,
                      'assets/images/icons/discord-outline.svg',
                      () {
                        launchUrl(urls.discord!);
                      },
                    ),
                ],
              );
            },
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
        height: 32.w,
        decoration: const BoxDecoration(
          color: Color(0xFFE2FDFE),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          iconPath,
          width: 15.w,
          height: 15.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF000000),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
