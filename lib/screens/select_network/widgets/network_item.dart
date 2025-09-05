import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'action_icons.dart';
import 'network_info.dart';
import 'network_logo.dart';

class NetworkItem extends StatelessWidget {
  final String name;
  final String address;
  final String logoPath;
  final String chainId;

  const NetworkItem({
    super.key,
    required this.name,
    required this.address,
    required this.logoPath,
    required this.chainId,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10.0.r),
      child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(10.0.r),
          onTap: () {
            context.push(Routes.receiveAddress, extra: {
              'chainName': name,
              'chainId': chainId,
              'address': address,
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
                NetworkLogo(logoPath: logoPath),
                SizedBox(width: 10.0.w),
                NetworkInfo(
                  name: name,
                  chainId: chainId,
                  addresses: [address],
                ),
                Spacer(),
                ActionIcons(address: address, name: name),
              ],
            ),
          ),
        );
      }),
    );
  }
}
