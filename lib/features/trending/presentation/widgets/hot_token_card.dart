import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../../../../widgets/avatar/widget/round_token.dart';
import '../../domain/entities/hot_token_entity.dart';

class HotTokenCard extends StatelessWidget {
  const HotTokenCard({super.key, required this.token, required this.onTap});
  final HotTokenEntity token;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Token image/icon placeholder
          AspectRatio(
            aspectRatio: 1,
            child: AvatarRoundToken(
              avatar: token.logo,
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
              token.marketCapFormat,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textTertiary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
