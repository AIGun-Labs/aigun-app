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

class TokenList extends StatefulWidget {
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
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    // 初始化时设置为第一次加载
    _isFirstLoad = true;
  }

  @override
  void didUpdateWidget(TokenList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tokens != widget.tokens) {
      _isFirstLoad = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      // 如果不是第一次加载且有之前的数据，显示之前的数据
      if (!_isFirstLoad && widget.tokens != null) {
        return _buildTokenList(context);
      }
      // 第一次加载或没有数据时显示骨架屏
      if (_isFirstLoad) {
        return const TokenSkeleton();
      }
      return _buildTokenList(context);
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
    // if (widget.tokens?.isEmpty == true) {
    //   return Column(
    //     children: [
    //       SizedBox(height: 50.w),
    //       Text(S.of(context).wallet_noToken),
    //       SizedBox(height: 20.w),
    //       Center(
    //         child: CustomButton(
    //           width: 150.w,
    //           height: 40.w,
    //           backgroundColor: AppColors.foreground(context),
    //           fontSize: 12.sp,
    //           textColor: AppColors.background(context),
    //           onPressed: () {
    //             context.push(Routes.addToken);
    //           },
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Text(S.of(context).tokens_addToken),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }

    // return Column(
    //   children: widget.tokens?.map((token) {
    //         return TokenCard(
    //           token: token,
    //           showAddress: widget.showAddress,
    //           onTap: () {
    //             context.read<TransferCubit>().updateSelectedToken(token);
    //             context.push(Routes.sendTokenDetail);
    //           },
    //         );
    //       }).toList() ??
    //       [],
    // );

    return ListView.builder(itemBuilder: (context, index) {
      final token = widget.tokens?[index];
      if (token == null) {
        return const SizedBox.shrink();
      }
      return TokenCard(
          token: token,
          showAddress: widget.showAddress,
          onTap: () {
            context.read<TransferCubit>().updateSelectedToken(token);
            context.push(Routes.sendTokenDetail);
          });
    });
  }
}
