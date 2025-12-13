import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../../../domain/entities/base_token_entity.dart';
import '../avatar/round_token_avatar.dart';

class TokenGridCard extends StatelessWidget {
  final BaseTokenEntity token;
  final VoidCallback? onTap;
  final void Function(BuildContext context)? onLongPress;
  final BaseTokenEntity? realtimeToken;
  const TokenGridCard({
    super.key,
    required this.token,
    this.onTap,
    this.onLongPress,
    this.realtimeToken,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Token image/icon placeholder
            AspectRatio(
              aspectRatio: 1,
              child: RoundTokenAvatar(
                avatar: token.tokenLogo,
                tokenName: token.symbol,
              ),
            ),
            // Token name
            Text(
              token.symbol,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            // Market cap
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                realtimeToken?.formattedMarketCap ?? token.formattedMarketCap,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textTertiary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
