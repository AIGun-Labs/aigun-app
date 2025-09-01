// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      pk: json['pk'] as String,
      tid: json['tid'] as String?,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      inviteCode: json['invite_code'] as String,
      superiorId: json['superior_id'] as String?,
      ancestorId: json['ancestor_id'] as String?,
      inviteAmount: json['invite_amount'] as String,
      indirectInviteAmount: json['indirect_invite_amount'] as String,
      expandInviteList: json['expand_invite_list'] as String,
      cn: json['Cn'] as String,
      c0: json['C0'] as String,
      sn: json['Sn'] as String,
      s0: json['S0'] as String,
      t0: json['t0'] as String,
      claimedAmount: json['claimed_amount'] as String,
      destroyedAmount: json['destroyed_amount'] as String,
      receivedAt: json['received_at'] as String,
      rewardClaimedAmount: json['reward_claimed_amount'] as String,
      rewardDestroyedAmount: json['reward_destroyed_amount'] as String,
      rewardUnclaimedAmount: json['reward_unclaimed_amount'] as String,
      rewardT0: json['reward_t0'] as String,
      createdAt: json['created_at'] as String,
      isActive: json['is_active'] as String,
      isObsolete: json['is_obsolete'] as String,
      roleId: json['role_id'] as String,
      deviceId: json['device_id'] as String,
      walletUserId: json['wallet_user_id'] as String?,
      organizationId: json['organization_id'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'tid': instance.tid,
      'email': instance.email,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'invite_code': instance.inviteCode,
      'superior_id': instance.superiorId,
      'ancestor_id': instance.ancestorId,
      'invite_amount': instance.inviteAmount,
      'indirect_invite_amount': instance.indirectInviteAmount,
      'expand_invite_list': instance.expandInviteList,
      'Cn': instance.cn,
      'C0': instance.c0,
      'Sn': instance.sn,
      'S0': instance.s0,
      't0': instance.t0,
      'claimed_amount': instance.claimedAmount,
      'destroyed_amount': instance.destroyedAmount,
      'received_at': instance.receivedAt,
      'reward_claimed_amount': instance.rewardClaimedAmount,
      'reward_destroyed_amount': instance.rewardDestroyedAmount,
      'reward_unclaimed_amount': instance.rewardUnclaimedAmount,
      'reward_t0': instance.rewardT0,
      'created_at': instance.createdAt,
      'is_active': instance.isActive,
      'is_obsolete': instance.isObsolete,
      'role_id': instance.roleId,
      'device_id': instance.deviceId,
      'wallet_user_id': instance.walletUserId,
      'organization_id': instance.organizationId,
    };
