import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/invite_info_entity.dart';
import '../utils/show_invite_sheet.dart';
import 'bind_invite_card.dart';
import 'bouns_details.dart';
import 'get_funds_card.dart';
import 'get_gold_card.dart';
import 'invite_card.dart';
import 'invite_header.dart';
import 'invitee_card.dart';
import 'invitee_trade_card.dart';
import 'my_bonus_card.dart';

class BonusView extends StatelessWidget {
  const BonusView({
    super.key,
    required this.inviteInfo,
    required this.onClaimGold,
  });
  final InviteInfoEntity inviteInfo;
  final Future<void> Function() onClaimGold;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        InviteHeader(),
        20.verticalSpace,
        InviteCard(
          inviteCode: inviteInfo.inviteCode,
          inviteLink: inviteInfo.inviteLink,
          inviteBonus: inviteInfo.inviteBonusDisplay,
        ),
        14.verticalSpace,
        if (!inviteInfo.isInvited) ...[
          BindInviteCard(
            inviteRewardGold: inviteInfo.inviteRewardGold,
            onTap: () => showInviteSheet(context),
          ),
          14.verticalSpace,
        ],
        MyBonusCard(
          claimedGold: inviteInfo.claimedGold,
          claimedDollarValue: inviteInfo.claimedDollarValue,
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 80.w,
                child: GetGoldCard(
                  unclaimedGold: inviteInfo.unclaimedGold,
                  onClaim: onClaimGold,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: SizedBox(
                height: 80.w,
                child: GetFundsCard(
                  unclaimedDollarValue: inviteInfo.unclaimedDollarValue,
                ),
              ),
            ),
          ],
        ),
        14.verticalSpace,
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 80.w,
                child: InviteeCard(inviteeCount: inviteInfo.inviteCount),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: SizedBox(
                height: 80.w,
                child: InviteeTradeCard(
                  inviteTotalTradingVolumeValue:
                      inviteInfo.inviteTotalTradingVolumeValue,
                ),
              ),
            ),
          ],
        ),
        35.verticalSpace,
        BounsDetails(bonusDetails: inviteInfo.bonusDetails),
      ],
    );
  }
}
