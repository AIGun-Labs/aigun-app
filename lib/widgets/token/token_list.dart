import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/widgets/token/token_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    super.key,
    required this.onTap,
    this.tokens,
  });

  final Function(Token)? onTap;
  final List<Token>? tokens;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tokens?.length ?? 0,
        itemBuilder: (context, index) {
          if (tokens == null) {
            return const SizedBox.shrink();
          }
          return _buildTokenItem(context, tokens![index]);
        });
  }

  Widget _buildTokenItem(BuildContext context, Token token) {
    return ListTile(
      onTap: () => onTap?.call(token),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 2.0.w),
      leading: TokenAvatar(
          avatar: token.tokenAvatar,
          chainLogo: token.chainLogo,
          placeholderText: token.tokenName.split('').first,
          width: 46.w,
          height: 46.w),
      title: Text(
        token.tokenName,
        style:
            TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
      ),
      subtitle: Text(
        _getChainName(token.chainId),
        style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textQuaternary(context),
            fontWeight: FontWeight.w700),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatPrice(token.tokenPrice),
            style: TextStyle(
                fontSize: 16.sp, color: AppColors.textPrimary(context)),
          ),
          Text(
            formatPrice(token.rawBalance),
            style: TextStyle(
                fontSize: 12.sp, color: AppColors.textQuaternary(context)),
          ),
        ],
      ),
    );
  }

  String _getChainName(int chainId) {
    switch (chainId) {
      case 1:
        return "Ethereum";
      case 56:
        return "BSC";
      case 1399811149:
        return "Solana";
      default:
        return "Unknown";
    }
  }
}
