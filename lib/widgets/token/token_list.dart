import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token/token_item.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    super.key,
    required this.onTap,
    this.tokens,
    this.isShowRight = true,
  });

  final Function(Token)? onTap;
  final List<Token>? tokens;
  final bool isShowRight;

  @override
  Widget build(BuildContext context) {
    // if no tokens, show no tokens text
    if (tokens == null || tokens!.isEmpty) {
      return const Center(child: Text("No tokens"));
    }

    return SafeArea(
        child: ListView.builder(
            key: Key(key.toString()),
            itemCount: tokens?.length,
            itemBuilder: (context, index) {
              if (tokens == null) {
                return const SizedBox.shrink();
              }
              return _buildTokenItem(context, tokens![index]);
            }));
  }

  // Widget _buildTokenItem(BuildContext context, Token token) {
  //   return ListTile(
  //     onTap: () => onTap?.call(token),
  //     contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 2.0.w),
  //     leading: TokenAvatar(
  //         avatar: token.tokenAvatar,
  //         chainLogo: token.chainLogo,
  //         placeholderText: token.tokenName.split('').first,
  //         width: 46.w,
  //         height: 46.w),
  //     title: Text(
  //       token.tokenName,
  //       style:
  //           TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
  //     ),
  //     subtitle: Text(
  //       // _getChainName(token.chainId)
  //       token.chainName,
  //       style: TextStyle(
  //           fontSize: 12.sp,
  //           color: AppColors.textQuaternary(context),
  //           fontWeight: FontWeight.w700),
  //     ),
  //     trailing: Column(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Text(
  //           formatPrice(token.tokenPrice),
  //           style: TextStyle(
  //               fontSize: 16.sp, color: AppColors.textPrimary(context)),
  //         ),
  //         Text(
  //           formatPrice(token.rawBalance),
  //           style: TextStyle(
  //               fontSize: 12.sp, color: AppColors.textQuaternary(context)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTokenItem(BuildContext context, Token token) {
    return TokenItem(
        token: token,
        key: Key(token.toString()),
        onTap: (token) => onTap?.call(token),
        isShowRight: isShowRight);
  }
}

class TokenListSkeleton extends StatelessWidget {
  const TokenListSkeleton({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const TokenItemSkeleton();
        });
  }
}
