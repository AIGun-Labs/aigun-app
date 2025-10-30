import '../models/invite_info_model.dart';
import '../../domain/entities/invite_info_entity.dart';

extension InviteInfoMapper on InviteInfoModel {
  InviteInfoEntity toEntity() {
    return InviteInfoEntity(
      inviteCode: inviteCode,
      inviteBonusRate: inviteBonusRate,
      isInvited: isInvited,
      inviteRewardGold: inviteRewardGold,
      claimedAmount: claimedAmount,
      aigunClaimedAmount: aigunClaimedAmount,
      claimedDollar: claimedDollar,
      unclaimedInviteGold: unclaimedInviteGold,
      unclaimedTradeGold: unclaimedTradeGold,
      inviteCount: inviteCount,
      totalUnclaimedAmount: totalUnclaimedAmount,
      inviteTotalTradingVolume: inviteTotalTradingVolume,
      bonusDetails: bonusDetails.map((b) => b.toEntity()).toList(),
    );
  }
}

extension BonusInfoMapper on BonusInfoModel {
  BonusInfoEntity toEntity() => BonusInfoEntity(
        id: id,
        actionType: actionType,
        rewardAmount: rewardAmount,
        rewardType: rewardType,
        time: createdAt,
        userName: triggerUserNickname,
      );
}
