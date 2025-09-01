import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/add_token/cubit/add_token_cubit.dart';
import 'package:flutter_aigun/screens/add_token/cubit/add_token_state.dart';
import 'package:flutter_aigun/widgets/select_network_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkSelector extends StatelessWidget {
  const NetworkSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).tokens_selectMainnet,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.all(13.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showSelectNetworkBottomSheet(context, (chainId) {
                context.read<AddTokenCubit>().updateChainId(chainId);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AddTokenCubit, AddTokenState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        // CachedImage(
                        //   imageUrl: context
                        //           .read<ChainCubit>()
                        //           .getChain(  state.chainId)
                        //           ?.logo ??
                        //       '',
                        //   width: 25.w,
                        //   height: 25.w,
                        // ),
                        SizedBox(width: 8.w),
                        Text(
                          "",
                          // context
                          //     .read<ChainCubit>()
                          //     .getChainName(state.chainId),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    );
                  },
                ),
                Icon(Icons.chevron_right, size: 24.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
