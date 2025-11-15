import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../presentation/extensions/datetime_extension.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/bonus_action_type.dart';
import '../../domain/entities/invite_info_entity.dart';

class BounsDetails extends StatelessWidget {
  final List<BonusInfoEntity> bonusDetails;
  const BounsDetails({super.key, required this.bonusDetails});

  @override
  Widget build(BuildContext context) {
    // 预先过滤：只保留能生成文案的条目
    final visibleItems = bonusDetails
        .map((e) => (item: e, text: _buildContentText(context, e)))
        .where((it) => it.text != null)
        .toList();

    return Column(
      spacing: 14.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).bonusDetails,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          textAlign: TextAlign.left,
        ),
        ...visibleItems
            .map((it) => _BonusLine(item: it.item, contentText: it.text!)),
      ],
    );
  }

  String? _buildContentText(BuildContext context, BonusInfoEntity item) {
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

      case BonusActionType.inviteRewardGold:
        return s.bonusDetailsItem5(amount, name);
      default:
        return null;
    }
  }
}

class _BonusLine extends StatelessWidget {
  const _BonusLine({required this.item, required this.contentText});
  final BonusInfoEntity item;
  final String contentText;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: 14.sp, color: AppColors.textPrimary(context)),
            children: [
          TextSpan(text: contentText, children: [
            const TextSpan(text: ' '),
            TextSpan(
                text: item.time.fmt(context),
                style: TextStyle(color: AppColors.textTertiary(context))),
          ]),
        ]));
  }
}
