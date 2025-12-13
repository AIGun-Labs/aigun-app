import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/naive_to_utc_date_time_converter.dart';
import '../../domain/entities/bonus_action_type.dart';
import '../converters/bonus_action_type_converter.dart';

part 'invite_info_model.freezed.dart';
part 'invite_info_model.g.dart';

@freezed
sealed class InviteInfoModel with _$InviteInfoModel {
  const InviteInfoModel._();
  @JsonSerializable(explicitToJson: true, checked: true)
  const factory InviteInfoModel({
    @JsonKey(name: 'invite_code', defaultValue: '') required String inviteCode,
    @JsonKey(name: 'invite_domain', defaultValue: '')
    required String inviteDomain,
    @JsonKey(name: 'invite_bonus_rate', defaultValue: 0.0)
    required double inviteBonusRate,
    @JsonKey(name: 'is_invited') required bool isInvited,
    @JsonKey(name: 'invite_reward_gold', defaultValue: '')
    required String inviteRewardGold,
    @JsonKey(name: 'claimed_amount') required String claimedAmount,
    @JsonKey(name: 'aigun_claimed_amount', defaultValue: '')
    required String aigunClaimedAmount,
    @JsonKey(name: 'claimed_dollar', defaultValue: '')
    required String claimedDollar,
    @JsonKey(name: 'unclaimed_invite_gold', defaultValue: '')
    required String unclaimedInviteGold,
    @JsonKey(name: 'unclaimed_trade_gold') required String unclaimedTradeGold,
    @JsonKey(name: 'total_unclaimed_amount', defaultValue: '')
    required String totalUnclaimedAmount,
    @JsonKey(name: 'invite_count') required int inviteCount,
    @JsonKey(name: 'invite_total_trading_volume')
    required String inviteTotalTradingVolume,
    @JsonKey(name: 'bonus_details') required List<BonusInfoModel> bonusDetails,
  }) = _InviteInfoModel;

  factory InviteInfoModel.fromJson(Map<String, dynamic> json) =>
      _$InviteInfoModelFromJson(json);
}

@freezed
sealed class BonusInfoModel with _$BonusInfoModel {
  @JsonSerializable(checked: true)
  const factory BonusInfoModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'action_type')
    @BonusActionTypeConverter()
    required BonusActionType actionType,
    @JsonKey(name: 'reward_amount') required String rewardAmount,
    @JsonKey(name: 'reward_type') required String rewardType,
    @JsonKey(name: 'trigger_user_id') required String triggerUserId,
    @JsonKey(name: 'created_at')
    @NaiveToUtcDateTimeConverter()
    required DateTime createdAt,
    @JsonKey(name: 'trigger_user_nickname', defaultValue: '')
    required String triggerUserNickname,
  }) = _BonusInfoModel;

  factory BonusInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BonusInfoModelFromJson(json);
}
