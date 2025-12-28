import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/bonus_action_type.dart';

class BonusActionTypeConverter
    implements JsonConverter<BonusActionType, Object?> {
  const BonusActionTypeConverter();

  static const _map = <String, BonusActionType>{
    'trade_reward_gold': BonusActionType.tradeRewardGold,
    'invitee_trade_reward_dollar': BonusActionType.inviteeTradeRewardDollar,
    'invitee_claim_reward_gold': BonusActionType.inviteeClaimRewardGold,
    'vip_activation': BonusActionType.vipActivation,
    'invite_reward_gold': BonusActionType.inviteRewardGold,
    'claim_reward_gold': BonusActionType.claimRewardGold,
  };

  @override
  BonusActionType fromJson(Object? json) {
    final s = (json ?? '').toString();
    return _map[s] ?? BonusActionType.unknown;
  }

  @override
  Object toJson(BonusActionType object) {
    return _map.entries
        .firstWhere(
          (e) => e.value == object,
          orElse: () => const MapEntry('unknown', BonusActionType.unknown),
        )
        .key;
  }
}
