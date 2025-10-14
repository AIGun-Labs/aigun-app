import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class SearchTokenItem extends StatelessWidget {
  const SearchTokenItem({
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

class SearchTokenItemInfo extends StatelessWidget {
  const SearchTokenItemInfo({super.key, this.token});

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

class SearchTokenItemAmounts extends StatelessWidget {
  const SearchTokenItemAmounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text()
      ],
    );
  }
}
