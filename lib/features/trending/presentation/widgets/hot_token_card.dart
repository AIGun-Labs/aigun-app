import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../../../../widgets/avatar/widget/round_token.dart';

class HotTokenCard extends StatelessWidget {
  const HotTokenCard({super.key, required this.token});
  final Map<String, dynamic> token;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Token image/icon placeholder
        AspectRatio(
          aspectRatio: 1,
          child: AvatarRoundToken(
            avatar: token['tokenAvatar'] ?? '',
            tokenName: token['tokenName'] ?? 's',
          ),
        ),
        // Token name
        Text(
          token['name'],
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        // Market cap
        Text(
          token['marketCap'],
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textTertiary(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
