import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class BindInviteCard extends StatelessWidget {
  const BindInviteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: InkWell(
        onTap: () {
          // TODO: 实现绑定邀请码的逻辑
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary(context),
                  ),
                  children: [
                    TextSpan(text: S.of(context).bind),
                    TextSpan(
                        text: S.of(context).friendInviteCode,
                        style: const TextStyle(color: AppColors.quaternary)),
                    TextSpan(text: S.of(context).getGoldBonus(100)),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
