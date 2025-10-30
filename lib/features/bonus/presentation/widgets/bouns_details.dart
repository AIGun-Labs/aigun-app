import 'package:flutter/material.dart';
import 'package:flutter_aigun/presentation/extensions/datetime_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/bonus_action_type.dart';
import '../../domain/entities/invite_info_entity.dart';

class BounsDetails extends StatelessWidget {
  final List<BonusInfoEntity> bonusDetails;
  const BounsDetails({super.key, required this.bonusDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).bonusDetails,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        ...bonusDetails.map((e) => _BonusLine(item: e)),
      ],
    );
  }
}

class _BonusLine extends StatelessWidget {
  const _BonusLine({super.key, required this.item});
  final BonusInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: 14.sp, color: AppColors.textPrimary(context)),
            children: [
          TextSpan(text: _buildContentText(context, item)),
          TextSpan(
              text: item.time.fmt(context),
              style: TextStyle(color: AppColors.textTertiary(context))),
        ]));
  }

  String _buildContentText(BuildContext context, BonusInfoEntity item) {
    final s = S.of(context);
    final name = item.userName;
    final actionType = item.actionType;
    final amount = item.rewardAmount;

    switch (actionType) {
      case BonusActionType.inviteeTradeRewardDollar:
        return s.bonusDetailsItem1(amount, name);

      case BonusActionType.inviteeClaimRewardGold:
        return s.bonusDetailsItem2(amount, name);

      case BonusActionType.tradeRewardGold:
        return s.bonusDetailsItem3(amount);

      case BonusActionType.vipActivation:
        return s.bonusDetailsItem4(amount, name);
      default:
        return '';
    }
  }
}
