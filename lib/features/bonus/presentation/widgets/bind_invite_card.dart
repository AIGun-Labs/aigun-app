import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../utils/show_invite_sheet.dart';
import 'card_widget.dart';

class BindInviteCard extends StatelessWidget {
  const BindInviteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showInviteSheet(context),
      child: CardWidget(
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
