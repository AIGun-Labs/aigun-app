import 'package:freezed_annotation/freezed_annotation.dart';

import 'bonus_action_type.dart';

part 'invite_info_entity.freezed.dart';

@freezed
sealed class InviteInfoEntity with _$InviteInfoEntity {
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
  const InviteInfoEntity._();

  String get inviteBonusDisplay {
    final percentage = inviteBonusRate * 100;
    if (percentage == percentage.roundToDouble()) {
      return '${percentage.toInt()}%';
    }
    return '${percentage.toStringAsFixed(1)}%';
  }

  int get claimedGold {
    final claimed = double.tryParse(claimedAmount) ?? 0;
    final aigunClaimed = double.tryParse(aigunClaimedAmount) ?? 0;
    return (claimed + aigunClaimed).toInt();
  }

  int get unclaimedGold {
    final unclaimed = double.tryParse(unclaimedInviteGold) ?? 0;
    final unclaimedTrade = double.tryParse(unclaimedTradeGold) ?? 0;
    return (unclaimed + unclaimedTrade).toInt();
  }

  double get claimedDollarValue {
    return double.tryParse(claimedDollar) ?? 0.0;
  }

  double get unclaimedDollarValue {
    return double.tryParse(totalUnclaimedAmount) ?? 0.0;
  }

  double get inviteTotalTradingVolumeValue {
    return double.tryParse(inviteTotalTradingVolume) ?? 0.0;
  }

  String get inviteLink {
    return '$inviteDomain?invite=$inviteCode';
  }
}

@freezed
sealed class BonusInfoEntity with _$BonusInfoEntity {
  const factory BonusInfoEntity({
    required String id,
    required BonusActionType actionType,
    required String rewardAmount,
    required String rewardType,
    required DateTime time,
    required String userName,
  }) = _BonusInfoEntity;
  const BonusInfoEntity._();
}
