import 'package:freezed_annotation/freezed_annotation.dart';

import 'bonus_action_type.dart';

part 'invite_info_entity.freezed.dart';

@freezed
class InviteInfoEntity with _$InviteInfoEntity {
  const InviteInfoEntity._();

  const factory InviteInfoEntity({
    required String inviteCode,
    required String inviteDomain,
    required double inviteBonusRate,
    required bool isInvited,
    required String inviteRewardGold,
    required String claimedAmount,
    required String aigunClaimedAmount,
    required String claimedDollar,
    required String unclaimedInviteGold,
    required String unclaimedTradeGold,
    required String totalUnclaimedAmount,
    required int inviteCount,
    required String inviteTotalTradingVolume,
    required List<BonusInfoEntity> bonusDetails,
  }) = _InviteInfoEntity;

  String get inviteBonusDisplay {
    final percentage = inviteBonusRate * 100;
    // 如果是整数，不显示小数部分
    if (percentage == percentage.roundToDouble()) {
      return '${percentage.toInt()}%';
    }
    // 如果有小数，保留1位
    return '${percentage.toStringAsFixed(1)}%';
  }

  //总领取gold(claimedAmount + aigunClaimedAmount)
  int get claimedGold {
    final claimed = double.tryParse(claimedAmount) ?? 0;
    final aigunClaimed = double.tryParse(aigunClaimedAmount) ?? 0;
    return (claimed + aigunClaimed).toInt();
  }

  //未领取gold(unclaimedInviteGold + unclaimedTradeGold)
  int get unclaimedGold {
    final unclaimed = double.tryParse(unclaimedInviteGold) ?? 0;
    final unclaimedTrade = double.tryParse(unclaimedTradeGold) ?? 0;
    return (unclaimed + unclaimedTrade).toInt();
  }

  //未领取funds(unclaimedFunds)
  double get unclaimedFunds {
    return double.tryParse(totalUnclaimedAmount) ?? 0.0;
  }

  //已领取funds(claimedDollar)
  double get claimedDollarValue {
    return double.tryParse(claimedDollar) ?? 0.0;
  }

  //未领取funds(unclaimedFunds)
  double get unclaimedDollarValue {
    return double.tryParse(totalUnclaimedAmount) ?? 0.0;
  }

  //受邀人交易量(inviteTotalTradingVolume)
  double get inviteTotalTradingVolumeValue {
    return double.tryParse(inviteTotalTradingVolume) ?? 0.0;
  }

  String get inviteLink {
    return '$inviteDomain?invite=$inviteCode';
  }
}

@freezed
class BonusInfoEntity with _$BonusInfoEntity {
  const BonusInfoEntity._();
  const factory BonusInfoEntity({
    required String id,
    required BonusActionType actionType,
    required String rewardAmount,
    required String rewardType,
    required DateTime time,
    required String userName,
  }) = _BonusInfoEntity;
}
