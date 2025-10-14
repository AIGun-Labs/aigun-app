import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QueryTokenItem extends StatelessWidget {
  const QueryTokenItem({
    super.key,
    this.token,
  });

  final Token? token;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarToken(
          avatar: token?.tokenAvatar,
          chainLogo: token?.chainLogo,
        )
      ],
    );
  }
}

class QueryTokenItemInfo extends StatelessWidget {
  const QueryTokenItemInfo({super.key, this.token});

  final Token? token;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          token?.tokenAvatar ?? '',
          style: TextStyle(color: AppColors.quaternary),
        ),
        Text(token?.address ?? ''),
        const Row(
          children: [
            Text(
              "流动性: \$592",
              style: TextStyle(color: AppColors.quinary),
            ),
            Text(
              "24h  成交额：\$8,690",
              style: TextStyle(color: AppColors.quinary),
            ),
          ],
        )
      ],
    );
  }
}

class QueryTokenItemAmounts extends StatelessWidget {
  const QueryTokenItemAmounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\$1.39",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "-13.9",
          style: TextStyle(color: AppColors.secondary, fontSize: 14.sp),
        )
      ],
    );
  }
}
