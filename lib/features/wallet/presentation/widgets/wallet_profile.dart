import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubits/index.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/image.dart';

class WalletUserProfile extends StatelessWidget {
  const WalletUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WalletAsset(),
                  Transform.translate(
                    offset: Offset(15.w, 0),
                    child: CachedImage(
                      height: 110.w,
                      width: 110.w,
                      imageUrl: Assets.images.walletMark.path,
                    ),
                  ),
                ],
              ),
              const Row(children: []),
            ],
          ),
        );
      },
    );
  }
}

class WalletAsset extends StatelessWidget {
  const WalletAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        final balance =
            Decimal.tryParse(
              state.balances?.totalBalanceUsd ?? '0.00',
            )?.toStringAsFixed(2) ??
            '0.00';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$$balance',
              style: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 50.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.sp,
              ),
            ),
            SizedBox(height: 13.h),
            Row(
              children: [
                SizedBox(width: 4.w),
                // const Icon(Icons.safety_check),
                SvgPicture.asset(
                  'assets/images/icons/wallet-safe.svg',
                  width: 16.w,
                  height: 16.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  S.of(context).wallet_safe,
                  style: TextStyle(
                    color: AppColors.textTertiary(context),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
