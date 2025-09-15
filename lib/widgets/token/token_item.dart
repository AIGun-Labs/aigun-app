import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenItem extends StatelessWidget {
  const TokenItem(
      {super.key,
      required this.token,
      this.onTap,
      this.tokenAvatarSize = 46,
      this.chainLogoSize = 18,
      this.isShowRight = true,
      this.title,
      this.subtitle,
      this.trailing,
      this.trailingSubtitle});
  final Token token;
  final Function(Token)? onTap;
  final double tokenAvatarSize;
  final double chainLogoSize;
  final bool isShowRight;

  final String? title;
  final String? subtitle;
  final String? trailing;
  final String? trailingSubtitle;

  @override
  Widget build(BuildContext context) {
    final tileTitle = title ?? token.tokenName;
    final tileSubtitle = subtitle ?? token.symbol;
    final tileTrailing = trailing ?? formatPrice(token.rawBalance);
    final tileTrailingSubtitle =
        trailingSubtitle ?? formatPrice(token.tokenPrice);

    return ListTile(
      onTap: () => onTap?.call(token),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 2.0.w),
      leading: AvatarToken(
        avatar: token.tokenAvatar,
        chainLogo: token.chainLogo,
        tokenName: token.tokenName,
        chainName: token.chainName,
        width: tokenAvatarSize.w,
        height: tokenAvatarSize.h,
        chainLogoHeight: chainLogoSize.h,
        chainLogoWidth: chainLogoSize.w,
      ),
      title: Text(
        tileTitle,
        style:
            TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
      ),
      subtitle: Text(
        // _getChainName(token.chainId)
        tileSubtitle,
        style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textQuaternary(context),
            fontWeight: FontWeight.w700),
      ),
      trailing: isShowRight
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$$tileTrailing",
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.textPrimary(context)),
                ),
                Text(
                  tileTrailingSubtitle,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textQuaternary(context)),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
