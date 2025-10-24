import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';
import 'action_icons.dart';
import 'network_info.dart';
import 'network_logo.dart';

class NetworkItem extends StatelessWidget {
  final WalletAddress wallet;

  const NetworkItem({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10.0.r),
      child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(10.0.r),
          onTap: () {
            // 传递所需参数
            context.pushNamed(RouteNames.receiveAddress, extra: {
              "avatar": wallet.logoUrl ?? '',
              "title": S.of(context).networkReceive(wallet.chainName ?? ''),
              "symbol": wallet.chainName ?? '',
              "name": wallet.chainName ?? '',
              "address": wallet.address ?? '',
            });
            // 更新选择的网络
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 14.0.h,
              horizontal: 12.0.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(10.0.r),
              border: Border.all(
                // color: Color(0xFFBBBBBB).withValues(alpha: .37),
                color: AppColors.border(context),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                NetworkLogo(
                    url: wallet.logoUrl ?? '', name: wallet.chainName ?? ''),
                SizedBox(width: 10.0.w),
                NetworkInfo(
                  name: wallet.chainName ?? '',
                  chainId: wallet.chainId?.toString() ?? '',
                  addresses: [wallet.address ?? ''],
                ),
                const Spacer(),
                ActionIcons(
                    address: wallet.address ?? '',
                    name: wallet.chainName ?? ''),
              ],
            ),
          ),
        );
      }),
    );
  }
}
