import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trade_back/widgets/network_selector_dialog.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkSelector extends StatelessWidget {
  final Chain chain;

  const NetworkSelector({
    super.key,
    required this.chain,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        // final Token? token =
        //     context.read<BalanceCubit>().getBalance(tokenAddress, chainId);

        // final chainName = context.read<ChainCubit>().getChainName(chainId);
        // final selectedToken = context.read<SwapCubit>().state.selectedToken;

        return Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Container(
            padding: EdgeInsets.all(13.w),
            height: 58.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.background(context),
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
                      child: int.tryParse(chain.chainId.toString()) != null
                          ? CachedImage(
                              imageUrl: chain.logoUrl,
                              width: 30.h,
                              height: 30.h,
                              borderRadius: BorderRadius.circular(15.h),
                            )
                          : Container(
                              width: 30.h,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15.h),
                              ),
                              child: Icon(
                                Icons.token,
                                size: 18.w,
                                color: Colors.grey[600],
                              ),
                            ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      chain.chainName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    // context.read<TransferCubit>().updateSelectedToken(
                    //       selectedToken!,
                    //     );
                    // showSelectTokenDialog(context);
                    // 获取链
                    final chains = context.read<ChainCubit>().state.chains;

// 显示选择网络弹窗
                    showSelectNetworkDialog(context, chains);
                  },
                  child: Row(
                    children: [
                      Text(
                        S.of(context).wallet_network(chain.chainName),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withValues(alpha: .6),
                        size: 18.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
