// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) {
  return _SignInResponse.fromJson(json);
}

/// @nodoc
mixin _$SignInResponse {
  @JsonKey(name: "user")
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(name: "access_token", defaultValue: "")
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: "refresh_token", defaultValue: "")
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignInResponseCopyWith<SignInResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInResponseCopyWith<$Res> {
  factory $SignInResponseCopyWith(
          SignInResponse value, $Res Function(SignInResponse) then) =
      _$SignInResponseCopyWithImpl<$Res, SignInResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "user") User? user,
      @JsonKey(name: "access_token", defaultValue: "") String? accessToken,
      @JsonKey(name: "refresh_token", defaultValue: "") String? refreshToken});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$SignInResponseCopyWithImpl<$Res, $Val extends SignInResponse>
    implements $SignInResponseCopyWith<$Res> {
  _$SignInResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignInResponseImplCopyWith<$Res>
    implements $SignInResponseCopyWith<$Res> {
  factory _$$SignInResponseImplCopyWith(_$SignInResponseImpl value,
          $Res Function(_$SignInResponseImpl) then) =
      __$$SignInResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user") User? user,
      @JsonKey(name: "access_token", defaultValue: "") String? accessToken,
      @JsonKey(name: "refresh_token", defaultValue: "") String? refreshToken});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$SignInResponseImplCopyWithImpl<$Res>
    extends _$SignInResponseCopyWithImpl<$Res, _$SignInResponseImpl>
    implements _$$SignInResponseImplCopyWith<$Res> {
  __$$SignInResponseImplCopyWithImpl(
      _$SignInResponseImpl _value, $Res Function(_$SignInResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$SignInResponseImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignInResponseImpl implements _SignInResponse {
  const _$SignInResponseImpl(
      {@JsonKey(name: "user") this.user,
      @JsonKey(name: "access_token", defaultValue: "") this.accessToken,
      @JsonKey(name: "refresh_token", defaultValue: "") this.refreshToken});

  factory _$SignInResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignInResponseImplFromJson(json);

  @override
  @JsonKey(name: "user")
  final User? user;
  @override
  @JsonKey(name: "access_token", defaultValue: "")
  final String? accessToken;
  @override
  @JsonKey(name: "refresh_token", defaultValue: "")
  final String? refreshToken;

  @override
  String toString() {
    return 'SignInResponse(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInResponseImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInResponseImplCopyWith<_$SignInResponseImpl> get copyWith =>
      __$$SignInResponseImplCopyWithImpl<_$SignInResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignInResponseImplToJson(
      this,
    );
  }
}

abstract class _SignInResponse implements SignInResponse {
  const factory _SignInResponse(
      {@JsonKey(name: "user") final User? user,
      @JsonKey(name: "access_token", defaultValue: "")
      final String? accessToken,
      @JsonKey(name: "refresh_token", defaultValue: "")
      final String? refreshToken}) = _$SignInResponseImpl;

  factory _SignInResponse.fromJson(Map<String, dynamic> json) =
      _$SignInResponseImpl.fromJson;

  @override
  @JsonKey(name: "user")
  User? get user;
  @override
  @JsonKey(name: "access_token", defaultValue: "")
  String? get accessToken;
  @override
  @JsonKey(name: "refresh_token", defaultValue: "")
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$SignInResponseImplCopyWith<_$SignInResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
