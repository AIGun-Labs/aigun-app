import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/widgets/feature_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';

class TokenSelector extends StatelessWidget {
  final String chainName;
  final String tokenAddress;
  final String chainId;

  const TokenSelector({
    super.key,
    required this.chainName,
    required this.tokenAddress,
    required this.chainId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        final selectedToken = context.read<TransferCubit>().state.selectedToken;

        Logger.info('selectedToken: $selectedToken');
        return Container(
          padding: EdgeInsets.all(13.w),
          height: 58.h,
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: InputTheme.getBorderColor(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 30.h,
                      height: 30.h,
                      child: ClipOval(
                        child: FeatureImage(
                          url: ImageUtils.getImageUrl(
                              selectedToken?.tokenAvatar),
                          width: 35.h,
                          height: 35.h,
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(width: 8.w),
                  Text(
                    selectedToken?.symbol ?? S.of(context).wallet_noToken,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: selectedToken != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: selectedToken != null
                          ? AppColors.textPrimary(context)
                          : AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.read<TransferCubit>().updateSelectedToken(
                        selectedToken!,
                      );
                  context.replaceNamed(RouteNames.sendSelectToken, extra: {
                    'showAddress': true,
                    'replace': true,
                  });
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).wallet_network(chainName),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textTertiary(context),
                      size: 18.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
