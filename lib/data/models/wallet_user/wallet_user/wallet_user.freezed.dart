// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletUser _$WalletUserFromJson(Map<String, dynamic> json) {
  return _WalletUser.fromJson(json);
}

/// @nodoc
mixin _$WalletUser {
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId => throw _privateConstructorUsedError;
  @JsonKey(name: "organization_id")
  String? get organizationId => throw _privateConstructorUsedError;

  /// Serializes this WalletUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletUserCopyWith<WalletUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletUserCopyWith<$Res> {
  factory $WalletUserCopyWith(
          WalletUser value, $Res Function(WalletUser) then) =
      _$WalletUserCopyWithImpl<$Res, WalletUser>;
  @useResult
  $Res call(
      {@JsonKey(name: "wallet_user_id") String? walletUserId,
      @JsonKey(name: "organization_id") String? organizationId});
}

/// @nodoc
class _$WalletUserCopyWithImpl<$Res, $Val extends WalletUser>
    implements $WalletUserCopyWith<$Res> {
  _$WalletUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletUserId = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$WalletUserImplCopyWith<$Res>
    implements $WalletUserCopyWith<$Res> {
  factory _$$WalletUserImplCopyWith(
          _$WalletUserImpl value, $Res Function(_$WalletUserImpl) then) =
      __$$WalletUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "wallet_user_id") String? walletUserId,
      @JsonKey(name: "organization_id") String? organizationId});
}

/// @nodoc
class __$$WalletUserImplCopyWithImpl<$Res>
    extends _$WalletUserCopyWithImpl<$Res, _$WalletUserImpl>
    implements _$$WalletUserImplCopyWith<$Res> {
  __$$WalletUserImplCopyWithImpl(
      _$WalletUserImpl _value, $Res Function(_$WalletUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletUserId = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_$WalletUserImpl(
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
class _$WalletUserImpl implements _WalletUser {
  const _$WalletUserImpl(
      {@JsonKey(name: "wallet_user_id") this.walletUserId,
      @JsonKey(name: "organization_id") this.organizationId});

  factory _$WalletUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletUserImplFromJson(json);

  @override
  @JsonKey(name: "wallet_user_id")
  final String? walletUserId;
  @override
  @JsonKey(name: "organization_id")
  final String? organizationId;

  @override
  String toString() {
    return 'WalletUser(walletUserId: $walletUserId, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletUserImpl &&
            (identical(other.walletUserId, walletUserId) ||
                other.walletUserId == walletUserId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, walletUserId, organizationId);

  /// Create a copy of WalletUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletUserImplCopyWith<_$WalletUserImpl> get copyWith =>
      __$$WalletUserImplCopyWithImpl<_$WalletUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletUserImplToJson(
      this,
    );
  }
}

abstract class _WalletUser implements WalletUser {
  const factory _WalletUser(
          {@JsonKey(name: "wallet_user_id") final String? walletUserId,
          @JsonKey(name: "organization_id") final String? organizationId}) =
      _$WalletUserImpl;

  factory _WalletUser.fromJson(Map<String, dynamic> json) =
      _$WalletUserImpl.fromJson;

  @override
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId;
  @override
  @JsonKey(name: "organization_id")
  String? get organizationId;

  /// Create a copy of WalletUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletUserImplCopyWith<_$WalletUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
