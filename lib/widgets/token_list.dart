import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/error_retry_view.dart';
import 'package:flutter_aigun/widgets/token_card.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenList extends StatefulWidget {
  const TokenList(
      {super.key,
      required this.tokens,
      required this.isLoading,
      this.errorMessage,
      this.showAddress = false,
      this.replace = false});
  final bool showAddress;
  final bool replace;
  final List<Token>? tokens;
  // final List<Address>? addressList;
  final bool isLoading;
  final String? errorMessage;

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      // 如果有之前的数据，显示之前的数据
      if (widget.tokens != null) {
        return _buildTokenList(context);
      }
      // 首次加载显示骨架屏
      return const TokenSkeleton();
    }

    // 显示错误状态
    if (widget.errorMessage != null && widget.tokens?.isNotEmpty == true) {
      return ErrorRetryView(
        errorMessage: widget.errorMessage ?? '发生错误',
        onRetry: () {
          context.read<BalanceCubit>().getBalanceList();
        },
      );
    }

    // 显示数据
    return _buildTokenList(context);
  }

  Widget _buildTokenList(BuildContext context) {
    if (widget.tokens?.isEmpty == true) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Text(
            S.of(context).noToken,
            style: TextStyle(
              color: AppColors.textPrimary(context),
              fontSize: 16.sp,
            ),
          ),
        ),
      );
    }

    return Column(
      children: widget.tokens?.map((token) {
            return TokenCard(
              token: token,
              showAddress: widget.showAddress,
              onTap: () {
                context.read<TransferCubit>().updateSelectedToken(token);
                context.push(Routes.tokenDetail, extra: {
                  'address': token.tokenAddress,
                  'chainId': token.chainId.toString(),
                });
              },
            );
          }).toList() ??
          [],
    );
  }
}
