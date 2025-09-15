import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NetworkItem extends StatelessWidget {
  final Chain chain;

  const NetworkItem({
    super.key,
    required this.chain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 16.0.w),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0.r),
        child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
          return InkWell(
            borderRadius: BorderRadius.circular(10.0.r),
            onTap: () {
              // context.push(Routes.receiveAddress, extra: {
              //   'chainName': chain.chainName,
              //   'chainId': chain.chainId,
              //   'address': chain.explorer,
              // });

// 关闭弹窗
              context.pop();
              // 更新选择的链
              context.read<SwapCubit>().updateSelectedChain(chain);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 14.0.h,
                horizontal: 12.0.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.r),
                border: Border.all(
                  color: const Color(0xFFBBBBBB).withValues(alpha: .37),
                  width: 1.w,
                ),
              ),
              child: const Row(
                children: [
                  // NetworkLogo(logoPath: logoPath),
                  // SizedBox(width: 10.0.w),
                  // NetworkInfo(
                  //   name: name,
                  //   chainId: chainId,
                  //   addresses: [address],
                  // ),
                  // Spacer(),
                  // ActionIcons(address: address, name: name),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
