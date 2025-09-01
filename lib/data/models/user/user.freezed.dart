// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: "pk")
  String get pk => throw _privateConstructorUsedError;
  @JsonKey(name: 'tid')
  String? get tid => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: "nickname")
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: "avatar")
  String get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: "invite_code")
  String get inviteCode => throw _privateConstructorUsedError;
  @JsonKey(name: "superior_id")
  String? get superiorId => throw _privateConstructorUsedError;
  @JsonKey(name: "ancestor_id")
  String? get ancestorId => throw _privateConstructorUsedError;
  @JsonKey(name: "invite_amount")
  String get inviteAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "indirect_invite_amount")
  String get indirectInviteAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "expand_invite_list")
  String get expandInviteList => throw _privateConstructorUsedError;
  @JsonKey(name: "Cn")
  String get cn => throw _privateConstructorUsedError;
  @JsonKey(name: "C0")
  String get c0 => throw _privateConstructorUsedError;
  @JsonKey(name: "Sn")
  String get sn => throw _privateConstructorUsedError;
  @JsonKey(name: "S0")
  String get s0 => throw _privateConstructorUsedError;
  @JsonKey(name: "t0")
  String get t0 => throw _privateConstructorUsedError;
  @JsonKey(name: "claimed_amount")
  String get claimedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "destroyed_amount")
  String get destroyedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "received_at")
  String get receivedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "reward_claimed_amount")
  String get rewardClaimedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "reward_destroyed_amount")
  String get rewardDestroyedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "reward_unclaimed_amount")
  String get rewardUnclaimedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "reward_t0")
  String get rewardT0 => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "is_active")
  String get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: "is_obsolete")
  String get isObsolete => throw _privateConstructorUsedError;
  @JsonKey(name: "role_id")
  String get roleId => throw _privateConstructorUsedError;
  @JsonKey(name: "device_id")
  String get deviceId => throw _privateConstructorUsedError;
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId => throw _privateConstructorUsedError;
  @JsonKey(name: "organization_id")
  String? get organizationId => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: "pk") String pk,
      @JsonKey(name: 'tid') String? tid,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "nickname") String nickname,
      @JsonKey(name: "avatar") String avatar,
      @JsonKey(name: "invite_code") String inviteCode,
      @JsonKey(name: "superior_id") String? superiorId,
      @JsonKey(name: "ancestor_id") String? ancestorId,
      @JsonKey(name: "invite_amount") String inviteAmount,
      @JsonKey(name: "indirect_invite_amount") String indirectInviteAmount,
      @JsonKey(name: "expand_invite_list") String expandInviteList,
      @JsonKey(name: "Cn") String cn,
      @JsonKey(name: "C0") String c0,
      @JsonKey(name: "Sn") String sn,
      @JsonKey(name: "S0") String s0,
      @JsonKey(name: "t0") String t0,
      @JsonKey(name: "claimed_amount") String claimedAmount,
      @JsonKey(name: "destroyed_amount") String destroyedAmount,
      @JsonKey(name: "received_at") String receivedAt,
      @JsonKey(name: "reward_claimed_amount") String rewardClaimedAmount,
      @JsonKey(name: "reward_destroyed_amount") String rewardDestroyedAmount,
      @JsonKey(name: "reward_unclaimed_amount") String rewardUnclaimedAmount,
      @JsonKey(name: "reward_t0") String rewardT0,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "is_active") String isActive,
      @JsonKey(name: "is_obsolete") String isObsolete,
      @JsonKey(name: "role_id") String roleId,
      @JsonKey(name: "device_id") String deviceId,
      @JsonKey(name: "wallet_user_id") String? walletUserId,
      @JsonKey(name: "organization_id") String? organizationId});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? tid = freezed,
    Object? email = null,
    Object? nickname = null,
    Object? avatar = null,
    Object? inviteCode = null,
    Object? superiorId = freezed,
    Object? ancestorId = freezed,
    Object? inviteAmount = null,
    Object? indirectInviteAmount = null,
    Object? expandInviteList = null,
    Object? cn = null,
    Object? c0 = null,
    Object? sn = null,
    Object? s0 = null,
    Object? t0 = null,
    Object? claimedAmount = null,
    Object? destroyedAmount = null,
    Object? receivedAt = null,
    Object? rewardClaimedAmount = null,
    Object? rewardDestroyedAmount = null,
    Object? rewardUnclaimedAmount = null,
    Object? rewardT0 = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? isObsolete = null,
    Object? roleId = null,
    Object? deviceId = null,
    Object? walletUserId = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_value.copyWith(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String,
      tid: freezed == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      superiorId: freezed == superiorId
          ? _value.superiorId
          : superiorId // ignore: cast_nullable_to_non_nullable
              as String?,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteAmount: null == inviteAmount
          ? _value.inviteAmount
          : inviteAmount // ignore: cast_nullable_to_non_nullable
              as String,
      indirectInviteAmount: null == indirectInviteAmount
          ? _value.indirectInviteAmount
          : indirectInviteAmount // ignore: cast_nullable_to_non_nullable
              as String,
      expandInviteList: null == expandInviteList
          ? _value.expandInviteList
          : expandInviteList // ignore: cast_nullable_to_non_nullable
              as String,
      cn: null == cn
          ? _value.cn
          : cn // ignore: cast_nullable_to_non_nullable
              as String,
      c0: null == c0
          ? _value.c0
          : c0 // ignore: cast_nullable_to_non_nullable
              as String,
      sn: null == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String,
      s0: null == s0
          ? _value.s0
          : s0 // ignore: cast_nullable_to_non_nullable
              as String,
      t0: null == t0
          ? _value.t0
          : t0 // ignore: cast_nullable_to_non_nullable
              as String,
      claimedAmount: null == claimedAmount
          ? _value.claimedAmount
          : claimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      destroyedAmount: null == destroyedAmount
          ? _value.destroyedAmount
          : destroyedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receivedAt: null == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rewardClaimedAmount: null == rewardClaimedAmount
          ? _value.rewardClaimedAmount
          : rewardClaimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardDestroyedAmount: null == rewardDestroyedAmount
          ? _value.rewardDestroyedAmount
          : rewardDestroyedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardUnclaimedAmount: null == rewardUnclaimedAmount
          ? _value.rewardUnclaimedAmount
          : rewardUnclaimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardT0: null == rewardT0
          ? _value.rewardT0
          : rewardT0 // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as String,
      isObsolete: null == isObsolete
          ? _value.isObsolete
          : isObsolete // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      walletUserId: freezed == walletUserId
          ? _value.walletUserId
          : walletUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "pk") String pk,
      @JsonKey(name: 'tid') String? tid,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "nickname") String nickname,
      @JsonKey(name: "avatar") String avatar,
      @JsonKey(name: "invite_code") String inviteCode,
      @JsonKey(name: "superior_id") String? superiorId,
      @JsonKey(name: "ancestor_id") String? ancestorId,
      @JsonKey(name: "invite_amount") String inviteAmount,
      @JsonKey(name: "indirect_invite_amount") String indirectInviteAmount,
      @JsonKey(name: "expand_invite_list") String expandInviteList,
      @JsonKey(name: "Cn") String cn,
      @JsonKey(name: "C0") String c0,
      @JsonKey(name: "Sn") String sn,
      @JsonKey(name: "S0") String s0,
      @JsonKey(name: "t0") String t0,
      @JsonKey(name: "claimed_amount") String claimedAmount,
      @JsonKey(name: "destroyed_amount") String destroyedAmount,
      @JsonKey(name: "received_at") String receivedAt,
      @JsonKey(name: "reward_claimed_amount") String rewardClaimedAmount,
      @JsonKey(name: "reward_destroyed_amount") String rewardDestroyedAmount,
      @JsonKey(name: "reward_unclaimed_amount") String rewardUnclaimedAmount,
      @JsonKey(name: "reward_t0") String rewardT0,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "is_active") String isActive,
      @JsonKey(name: "is_obsolete") String isObsolete,
      @JsonKey(name: "role_id") String roleId,
      @JsonKey(name: "device_id") String deviceId,
      @JsonKey(name: "wallet_user_id") String? walletUserId,
      @JsonKey(name: "organization_id") String? organizationId});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? tid = freezed,
    Object? email = null,
    Object? nickname = null,
    Object? avatar = null,
    Object? inviteCode = null,
    Object? superiorId = freezed,
    Object? ancestorId = freezed,
    Object? inviteAmount = null,
    Object? indirectInviteAmount = null,
    Object? expandInviteList = null,
    Object? cn = null,
    Object? c0 = null,
    Object? sn = null,
    Object? s0 = null,
    Object? t0 = null,
    Object? claimedAmount = null,
    Object? destroyedAmount = null,
    Object? receivedAt = null,
    Object? rewardClaimedAmount = null,
    Object? rewardDestroyedAmount = null,
    Object? rewardUnclaimedAmount = null,
    Object? rewardT0 = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? isObsolete = null,
    Object? roleId = null,
    Object? deviceId = null,
    Object? walletUserId = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_$UserImpl(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String,
      tid: freezed == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      superiorId: freezed == superiorId
          ? _value.superiorId
          : superiorId // ignore: cast_nullable_to_non_nullable
              as String?,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteAmount: null == inviteAmount
          ? _value.inviteAmount
          : inviteAmount // ignore: cast_nullable_to_non_nullable
              as String,
      indirectInviteAmount: null == indirectInviteAmount
          ? _value.indirectInviteAmount
          : indirectInviteAmount // ignore: cast_nullable_to_non_nullable
              as String,
      expandInviteList: null == expandInviteList
          ? _value.expandInviteList
          : expandInviteList // ignore: cast_nullable_to_non_nullable
              as String,
      cn: null == cn
          ? _value.cn
          : cn // ignore: cast_nullable_to_non_nullable
              as String,
      c0: null == c0
          ? _value.c0
          : c0 // ignore: cast_nullable_to_non_nullable
              as String,
      sn: null == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String,
      s0: null == s0
          ? _value.s0
          : s0 // ignore: cast_nullable_to_non_nullable
              as String,
      t0: null == t0
          ? _value.t0
          : t0 // ignore: cast_nullable_to_non_nullable
              as String,
      claimedAmount: null == claimedAmount
          ? _value.claimedAmount
          : claimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      destroyedAmount: null == destroyedAmount
          ? _value.destroyedAmount
          : destroyedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receivedAt: null == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rewardClaimedAmount: null == rewardClaimedAmount
          ? _value.rewardClaimedAmount
          : rewardClaimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardDestroyedAmount: null == rewardDestroyedAmount
          ? _value.rewardDestroyedAmount
          : rewardDestroyedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardUnclaimedAmount: null == rewardUnclaimedAmount
          ? _value.rewardUnclaimedAmount
          : rewardUnclaimedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      rewardT0: null == rewardT0
          ? _value.rewardT0
          : rewardT0 // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as String,
      isObsolete: null == isObsolete
          ? _value.isObsolete
          : isObsolete // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      walletUserId: freezed == walletUserId
          ? _value.walletUserId
          : walletUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: "pk") required this.pk,
      @JsonKey(name: 'tid') this.tid,
      @JsonKey(name: "email") required this.email,
      @JsonKey(name: "nickname") required this.nickname,
      @JsonKey(name: "avatar") required this.avatar,
      @JsonKey(name: "invite_code") required this.inviteCode,
      @JsonKey(name: "superior_id") this.superiorId,
      @JsonKey(name: "ancestor_id") this.ancestorId,
      @JsonKey(name: "invite_amount") required this.inviteAmount,
      @JsonKey(name: "indirect_invite_amount")
      required this.indirectInviteAmount,
      @JsonKey(name: "expand_invite_list") required this.expandInviteList,
      @JsonKey(name: "Cn") required this.cn,
      @JsonKey(name: "C0") required this.c0,
      @JsonKey(name: "Sn") required this.sn,
      @JsonKey(name: "S0") required this.s0,
      @JsonKey(name: "t0") required this.t0,
      @JsonKey(name: "claimed_amount") required this.claimedAmount,
      @JsonKey(name: "destroyed_amount") required this.destroyedAmount,
      @JsonKey(name: "received_at") required this.receivedAt,
      @JsonKey(name: "reward_claimed_amount") required this.rewardClaimedAmount,
      @JsonKey(name: "reward_destroyed_amount")
      required this.rewardDestroyedAmount,
      @JsonKey(name: "reward_unclaimed_amount")
      required this.rewardUnclaimedAmount,
      @JsonKey(name: "reward_t0") required this.rewardT0,
      @JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "is_active") required this.isActive,
      @JsonKey(name: "is_obsolete") required this.isObsolete,
      @JsonKey(name: "role_id") required this.roleId,
      @JsonKey(name: "device_id") required this.deviceId,
      @JsonKey(name: "wallet_user_id") this.walletUserId,
      @JsonKey(name: "organization_id") this.organizationId});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: "pk")
  final String pk;
  @override
  @JsonKey(name: 'tid')
  final String? tid;
  @override
  @JsonKey(name: "email")
  final String email;
  @override
  @JsonKey(name: "nickname")
  final String nickname;
  @override
  @JsonKey(name: "avatar")
  final String avatar;
  @override
  @JsonKey(name: "invite_code")
  final String inviteCode;
  @override
  @JsonKey(name: "superior_id")
  final String? superiorId;
  @override
  @JsonKey(name: "ancestor_id")
  final String? ancestorId;
  @override
  @JsonKey(name: "invite_amount")
  final String inviteAmount;
  @override
  @JsonKey(name: "indirect_invite_amount")
  final String indirectInviteAmount;
  @override
  @JsonKey(name: "expand_invite_list")
  final String expandInviteList;
  @override
  @JsonKey(name: "Cn")
  final String cn;
  @override
  @JsonKey(name: "C0")
  final String c0;
  @override
  @JsonKey(name: "Sn")
  final String sn;
  @override
  @JsonKey(name: "S0")
  final String s0;
  @override
  @JsonKey(name: "t0")
  final String t0;
  @override
  @JsonKey(name: "claimed_amount")
  final String claimedAmount;
  @override
  @JsonKey(name: "destroyed_amount")
  final String destroyedAmount;
  @override
  @JsonKey(name: "received_at")
  final String receivedAt;
  @override
  @JsonKey(name: "reward_claimed_amount")
  final String rewardClaimedAmount;
  @override
  @JsonKey(name: "reward_destroyed_amount")
  final String rewardDestroyedAmount;
  @override
  @JsonKey(name: "reward_unclaimed_amount")
  final String rewardUnclaimedAmount;
  @override
  @JsonKey(name: "reward_t0")
  final String rewardT0;
  @override
  @JsonKey(name: "created_at")
  final String createdAt;
  @override
  @JsonKey(name: "is_active")
  final String isActive;
  @override
  @JsonKey(name: "is_obsolete")
  final String isObsolete;
  @override
  @JsonKey(name: "role_id")
  final String roleId;
  @override
  @JsonKey(name: "device_id")
  final String deviceId;
  @override
  @JsonKey(name: "wallet_user_id")
  final String? walletUserId;
  @override
  @JsonKey(name: "organization_id")
  final String? organizationId;

  @override
  String toString() {
    return 'User(pk: $pk, tid: $tid, email: $email, nickname: $nickname, avatar: $avatar, inviteCode: $inviteCode, superiorId: $superiorId, ancestorId: $ancestorId, inviteAmount: $inviteAmount, indirectInviteAmount: $indirectInviteAmount, expandInviteList: $expandInviteList, cn: $cn, c0: $c0, sn: $sn, s0: $s0, t0: $t0, claimedAmount: $claimedAmount, destroyedAmount: $destroyedAmount, receivedAt: $receivedAt, rewardClaimedAmount: $rewardClaimedAmount, rewardDestroyedAmount: $rewardDestroyedAmount, rewardUnclaimedAmount: $rewardUnclaimedAmount, rewardT0: $rewardT0, createdAt: $createdAt, isActive: $isActive, isObsolete: $isObsolete, roleId: $roleId, deviceId: $deviceId, walletUserId: $walletUserId, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.tid, tid) || other.tid == tid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.superiorId, superiorId) ||
                other.superiorId == superiorId) &&
            (identical(other.ancestorId, ancestorId) ||
                other.ancestorId == ancestorId) &&
            (identical(other.inviteAmount, inviteAmount) ||
                other.inviteAmount == inviteAmount) &&
            (identical(other.indirectInviteAmount, indirectInviteAmount) ||
                other.indirectInviteAmount == indirectInviteAmount) &&
            (identical(other.expandInviteList, expandInviteList) ||
                other.expandInviteList == expandInviteList) &&
            (identical(other.cn, cn) || other.cn == cn) &&
            (identical(other.c0, c0) || other.c0 == c0) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.s0, s0) || other.s0 == s0) &&
            (identical(other.t0, t0) || other.t0 == t0) &&
            (identical(other.claimedAmount, claimedAmount) ||
                other.claimedAmount == claimedAmount) &&
            (identical(other.destroyedAmount, destroyedAmount) ||
                other.destroyedAmount == destroyedAmount) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.rewardClaimedAmount, rewardClaimedAmount) ||
                other.rewardClaimedAmount == rewardClaimedAmount) &&
            (identical(other.rewardDestroyedAmount, rewardDestroyedAmount) ||
                other.rewardDestroyedAmount == rewardDestroyedAmount) &&
            (identical(other.rewardUnclaimedAmount, rewardUnclaimedAmount) ||
                other.rewardUnclaimedAmount == rewardUnclaimedAmount) &&
            (identical(other.rewardT0, rewardT0) ||
                other.rewardT0 == rewardT0) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isObsolete, isObsolete) ||
                other.isObsolete == isObsolete) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.walletUserId, walletUserId) ||
                other.walletUserId == walletUserId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        pk,
        tid,
        email,
        nickname,
        avatar,
        inviteCode,
        superiorId,
        ancestorId,
        inviteAmount,
        indirectInviteAmount,
        expandInviteList,
        cn,
        c0,
        sn,
        s0,
        t0,
        claimedAmount,
        destroyedAmount,
        receivedAt,
        rewardClaimedAmount,
        rewardDestroyedAmount,
        rewardUnclaimedAmount,
        rewardT0,
        createdAt,
        isActive,
        isObsolete,
        roleId,
        deviceId,
        walletUserId,
        organizationId
      ]);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: "pk") required final String pk,
      @JsonKey(name: 'tid') final String? tid,
      @JsonKey(name: "email") required final String email,
      @JsonKey(name: "nickname") required final String nickname,
      @JsonKey(name: "avatar") required final String avatar,
      @JsonKey(name: "invite_code") required final String inviteCode,
      @JsonKey(name: "superior_id") final String? superiorId,
      @JsonKey(name: "ancestor_id") final String? ancestorId,
      @JsonKey(name: "invite_amount") required final String inviteAmount,
      @JsonKey(name: "indirect_invite_amount")
      required final String indirectInviteAmount,
      @JsonKey(name: "expand_invite_list")
      required final String expandInviteList,
      @JsonKey(name: "Cn") required final String cn,
      @JsonKey(name: "C0") required final String c0,
      @JsonKey(name: "Sn") required final String sn,
      @JsonKey(name: "S0") required final String s0,
      @JsonKey(name: "t0") required final String t0,
      @JsonKey(name: "claimed_amount") required final String claimedAmount,
      @JsonKey(name: "destroyed_amount") required final String destroyedAmount,
      @JsonKey(name: "received_at") required final String receivedAt,
      @JsonKey(name: "reward_claimed_amount")
      required final String rewardClaimedAmount,
      @JsonKey(name: "reward_destroyed_amount")
      required final String rewardDestroyedAmount,
      @JsonKey(name: "reward_unclaimed_amount")
      required final String rewardUnclaimedAmount,
      @JsonKey(name: "reward_t0") required final String rewardT0,
      @JsonKey(name: "created_at") required final String createdAt,
      @JsonKey(name: "is_active") required final String isActive,
      @JsonKey(name: "is_obsolete") required final String isObsolete,
      @JsonKey(name: "role_id") required final String roleId,
      @JsonKey(name: "device_id") required final String deviceId,
      @JsonKey(name: "wallet_user_id") final String? walletUserId,
      @JsonKey(name: "organization_id")
      final String? organizationId}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: "pk")
  String get pk;
  @override
  @JsonKey(name: 'tid')
  String? get tid;
  @override
  @JsonKey(name: "email")
  String get email;
  @override
  @JsonKey(name: "nickname")
  String get nickname;
  @override
  @JsonKey(name: "avatar")
  String get avatar;
  @override
  @JsonKey(name: "invite_code")
  String get inviteCode;
  @override
  @JsonKey(name: "superior_id")
  String? get superiorId;
  @override
  @JsonKey(name: "ancestor_id")
  String? get ancestorId;
  @override
  @JsonKey(name: "invite_amount")
  String get inviteAmount;
  @override
  @JsonKey(name: "indirect_invite_amount")
  String get indirectInviteAmount;
  @override
  @JsonKey(name: "expand_invite_list")
  String get expandInviteList;
  @override
  @JsonKey(name: "Cn")
  String get cn;
  @override
  @JsonKey(name: "C0")
  String get c0;
  @override
  @JsonKey(name: "Sn")
  String get sn;
  @override
  @JsonKey(name: "S0")
  String get s0;
  @override
  @JsonKey(name: "t0")
  String get t0;
  @override
  @JsonKey(name: "claimed_amount")
  String get claimedAmount;
  @override
  @JsonKey(name: "destroyed_amount")
  String get destroyedAmount;
  @override
  @JsonKey(name: "received_at")
  String get receivedAt;
  @override
  @JsonKey(name: "reward_claimed_amount")
  String get rewardClaimedAmount;
  @override
  @JsonKey(name: "reward_destroyed_amount")
  String get rewardDestroyedAmount;
  @override
  @JsonKey(name: "reward_unclaimed_amount")
  String get rewardUnclaimedAmount;
  @override
  @JsonKey(name: "reward_t0")
  String get rewardT0;
  @override
  @JsonKey(name: "created_at")
  String get createdAt;
  @override
  @JsonKey(name: "is_active")
  String get isActive;
  @override
  @JsonKey(name: "is_obsolete")
  String get isObsolete;
  @override
  @JsonKey(name: "role_id")
  String get roleId;
  @override
  @JsonKey(name: "device_id")
  String get deviceId;
  @override
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId;
  @override
  @JsonKey(name: "organization_id")
  String? get organizationId;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
