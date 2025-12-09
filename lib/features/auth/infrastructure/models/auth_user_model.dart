import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

class StringOrIntConverter implements JsonConverter<String, Object?> {
  const StringOrIntConverter();

  @override
  String fromJson(Object? json) {
    if (json == null) return '';
    return json.toString(); // 无论是 int 还是 String 都转成 String
  }

  @override
  Object? toJson(String object) {
    return object; // 保持为 String 输出
  }
}

/// Auth User Model - Data Transfer Object for user data
///
/// This model is used for JSON serialization/deserialization
/// when communicating with the backend API.
@freezed
sealed class AuthUserModel with _$AuthUserModel {
  @JsonSerializable(explicitToJson: true)
  const factory AuthUserModel({
    @JsonKey(name: 'pk') required String pk,
    @JsonKey(name: 'tid') String? tid,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'nickname') required String nickname,
    @JsonKey(name: 'avatar') required String avatar,
    @JsonKey(name: 'invite_code') required String inviteCode,
    @JsonKey(name: 'superior_id') String? superiorId,
    @JsonKey(name: 'ancestor_id') String? ancestorId,
    @StringOrIntConverter()
    @JsonKey(name: 'invite_amount') required String? inviteAmount,
    @StringOrIntConverter()
    @JsonKey(name: 'indirect_invite_amount')
    required String? indirectInviteAmount,
    @JsonKey(name: 'expand_invite_list') required String expandInviteList,
    @JsonKey(name: 'Cn') required String cn,
    @JsonKey(name: 'C0') required String c0,
    @JsonKey(name: 'Sn') required String sn,
    @JsonKey(name: 'S0') required String s0,
    @JsonKey(name: 't0') required String t0,
    @JsonKey(name: 'claimed_amount') required String claimedAmount,
    @JsonKey(name: 'destroyed_amount') required String destroyedAmount,
    @JsonKey(name: 'received_at') required String receivedAt,
    @JsonKey(name: 'reward_claimed_amount') required String rewardClaimedAmount,
    @JsonKey(name: 'reward_destroyed_amount')
    required String rewardDestroyedAmount,
    @JsonKey(name: 'reward_unclaimed_amount')
    required String rewardUnclaimedAmount,
    @JsonKey(name: 'reward_t0') required String rewardT0,
    @JsonKey(name: 'created_at') required String createdAt,
    @StringOrIntConverter()
    @JsonKey(name: 'is_active')
    required String isActive,
    @StringOrIntConverter()
    @JsonKey(name: 'is_obsolete')
    required String isObsolete,
    @StringOrIntConverter() @JsonKey(name: 'role_id') required String roleId,
    @JsonKey(name: 'device_id') required String deviceId,
    @JsonKey(name: 'wallet_user_id') String? walletUserId,
    @JsonKey(name: 'organization_id') String? organizationId,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
