import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trade_back/widgets/network_item.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/error_retry_view.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showSelectNetworkDialog(BuildContext context, List<Chain> chains) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SelectNetworkList(chains: chains, isLoading: false),
          ),
        );
      });
}

class SelectNetworkList extends StatelessWidget {
  const SelectNetworkList({
    super.key,
    // required this.tokens,
    // required this.addressList,
    this.showAddress = false,
    this.replace = false,
    this.isLoading = false,
    this.errorMessage,
    required this.chains,
  });

  final List<Chain> chains;

  final bool showAddress;
  final bool replace;
  // final List<Address>? addressList;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // 如果有之前的数据，显示之前的数据
      if (chains.isNotEmpty) {
        return _buildNetworkList(context);
      }
      // 首次加载显示骨架屏
      return const TokenSkeleton();
    }

    // 显示错误状态
    if (errorMessage != null
        //  && addressList?.isNotEmpty == true

        ) {
      return ErrorRetryView(
        errorMessage: errorMessage ?? '发生错误',
        onRetry: () {
          context.read<BalanceCubit>().getBalanceList();
        },
      );
    }

    // 显示数据
    return _buildNetworkList(context);
  }

  Widget _buildNetworkList(BuildContext context) {
    if (chains.isEmpty == true) {
      return Column(
        children: [
          SizedBox(height: 50.w),
          Text(S.of(context).wallet_noToken),
          SizedBox(height: 20.w),
          Center(
            child: CustomButton(
              width: 150.w,
              height: 40.w,
              backgroundColor: Theme.of(context).colorScheme.primary,
              fontSize: 14.sp,
              textColor: Colors.white,
              onPressed: () {
                context.push(Routes.addToken);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).tokens_addToken),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      spacing: 10.0.h,
      children: chains.map((chain) {
        // return TokenCard(
        //   token: token,
        //   // addressInfo: addressList!
        //   //     .firstWhere((address) => address.chainId == token.chainId),
        //   showAddress: showAddress,
        //   onTap: () {
        //     getIt<SwapCubit>().updateToken(token);
        //     context.pop(); // 关闭弹窗
        //   },
        // );
        return NetworkItem(chain: chain);
      }).toList(),
    );
  }
}
