import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/invite_info_entity.dart';
import '../cubits/invite_cubit.dart';
import 'bind_invite_card.dart';
import 'bouns_details.dart';
import 'get_funds_card.dart';
import 'get_gold_card.dart';
import 'invite_card.dart';
import 'invitee_card.dart';
import 'invitee_trade_card.dart';
import 'my_bonus_card.dart';

class BonusView extends StatelessWidget {
  const BonusView({super.key, required this.inviteInfo});
  final InviteInfoEntity inviteInfo;

  @override
  Widget build(BuildContext context) {
    final inviteCubit = BlocProvider.of<InviteCubit>(context);
    return Column(
      children: [
        InviteCard(
          inviteCode: inviteInfo.inviteCode,
          inviteLink: inviteInfo.inviteLink,
          inviteBonus: inviteInfo.inviteBonusDisplay,
        ),
        14.verticalSpace,
        if (!inviteInfo.isInvited)
          Column(
            children: [
              BindInviteCard(inviteRewardGold: inviteInfo.inviteRewardGold),
              14.verticalSpace,
            ],
          ),
        MyBonusCard(
          claimedGold: inviteInfo.claimedGold,
          claimedDollarValue: inviteInfo.claimedDollarValue,
        ),
        12.verticalSpace,
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80.w,
                    child: GetGoldCard(
                      unclaimedGold: inviteInfo.unclaimedGold,
                      onClaim: inviteCubit.claimGold,
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: SizedBox(
                    height: 80.w,
                    child: GetFundsCard(
                      unclaimedDollarValue: inviteInfo.unclaimedDollarValue,
                      realtimeFundsUpdate: inviteCubit.updateRealtimeFunds,
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
          ],
        ),
        35.verticalSpace,
        BounsDetails(bonusDetails: inviteInfo.bonusDetails),
      ],
    );
  }
}
