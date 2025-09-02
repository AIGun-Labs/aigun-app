import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/error_retry_view.dart';
import 'package:flutter_aigun/widgets/token_card.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    super.key,
    required this.tokens,
    // required this.addressList,
    this.showAddress = false,
    this.replace = false,
    this.isLoading = false,
    this.errorMessage,
  });

  final bool showAddress;
  final bool replace;
  final List<Token>? tokens;
  // final List<Address>? addressList;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // 如果有之前的数据，显示之前的数据
      if (tokens != null) {
        return _buildTokenList(context);
      }
      // 首次加载显示骨架屏
      return const TokenSkeleton();
    }

    // 显示错误状态
    if (errorMessage != null && tokens?.isNotEmpty == true) {
      return ErrorRetryView(
        errorMessage: errorMessage ?? '发生错误',
        onRetry: () {
          context.read<BalanceCubit>().getBalanceList();
        },
      );
    }

    // 显示数据
    return _buildTokenList(context);
  }

  Widget _buildTokenList(BuildContext context) {
    if (tokens!.isEmpty == true) {
      return Column(
        children: [
          SizedBox(height: 50.w),
          Text(S.of(context).wallet_noToken),
          SizedBox(height: 20.w),
          Center(
            child: CustomButton(
              width: 150.w,
              height: 40.w,
              backgroundColor: AppColors.foreground(context),
              fontSize: 12.sp,
              textColor: AppColors.background(context),
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
      children: tokens!.map((token) {
        return TokenCard(
          token: token,
          // addressInfo: addressList!
          //     .firstWhere((address) => address.chainId == token.chainId),
          showAddress: showAddress,
          onTap: () {
            // context.read<TransferCubit>().updateToken(
            //       token.chainAddress,
            //       token.chainId.toString(),
            //     );

            context.read<TransferCubit>().updateSelectedToken(token);

            context.push(Routes.sendTokenDetail);
            // if (!replace) {
            //   context.push(Routes.sendTokenDetail, extra: {
            //     'tokenAddress': token.chainAddress,
            //     'chainId': token.chainId.toString(),
            //     'tokenSymbol': token.symbol,
            //     'decimals': 18, // 使用默认值，因为 Token 模型中没有 decimals 属性
            //   });
            // } else {
            //   context.replace(Routes.sendTokenDetail, extra: {
            //     'tokenAddress': token.chainAddress,
            //     'chainId': token.chainId.toString(),
            //     'tokenSymbol': token.symbol,
            //     'decimals': 18, // 使用默认值，因为 Token 模型中没有 decimals 属性
            //   });
            // }
          },
        );
      }).toList(),
    );
  }
}
