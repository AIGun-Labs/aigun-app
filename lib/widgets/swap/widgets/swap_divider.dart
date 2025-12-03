import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubits/trade/trade_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../../themes/colors.dart';

class SwapTokenDivider extends StatelessWidget {
  const SwapTokenDivider({super.key, this.inAmount});
  final String? inAmount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Divider(height: 1.w, color: AppColors.border(context)),
        ),
        Center(
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.card(context),
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.buttonGradientStart,
                  AppColors.buttonGradientEnd,
                ],
              ),
            ),
            child: IconButton(
              onPressed: () {
                context.read<TradeCubit>().swapToken();
              },
              icon: SvgPicture.asset(
                // 'assets/images/icons/swap-outline.svg',
                Assets.images.icons.swapOutline,
                height: 16.w,
                width: 16.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
