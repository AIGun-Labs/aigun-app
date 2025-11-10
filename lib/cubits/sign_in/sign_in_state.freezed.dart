// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignInState {
// @Default("") String email,
// @Default("") String verificationCode,
// @Default("") String emailError,
// @Default("") String verificationCodeError,
// @Default(false) bool isLoading,
  String get inviteCode => throw _privateConstructorUsedError;
  String get paymentPin => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get verificationCode => throw _privateConstructorUsedError;
  SignInStatus get status => throw _privateConstructorUsedError;
  NicknameStatus get nicknameStatus => throw _privateConstructorUsedError;
  PaymentPinStatus get paymentPinStatus => throw _privateConstructorUsedError;
  InviteCodeStatus get inviteCodeStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInStateCopyWith<SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
  @useResult
  $Res call(
      {String inviteCode,
      String paymentPin,
      String email,
      String verificationCode,
      SignInStatus status,
      NicknameStatus nicknameStatus,
      PaymentPinStatus paymentPinStatus,
      InviteCodeStatus inviteCodeStatus});
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteCode = null,
    Object? paymentPin = null,
    Object? email = null,
    Object? verificationCode = null,
    Object? status = null,
    Object? nicknameStatus = null,
    Object? paymentPinStatus = null,
    Object? inviteCodeStatus = null,
  }) {
    return _then(_value.copyWith(
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignInStatus,
      nicknameStatus: null == nicknameStatus
          ? _value.nicknameStatus
          : nicknameStatus // ignore: cast_nullable_to_non_nullable
              as NicknameStatus,
      paymentPinStatus: null == paymentPinStatus
          ? _value.paymentPinStatus
          : paymentPinStatus // ignore: cast_nullable_to_non_nullable
              as PaymentPinStatus,
      inviteCodeStatus: null == inviteCodeStatus
          ? _value.inviteCodeStatus
          : inviteCodeStatus // ignore: cast_nullable_to_non_nullable
              as InviteCodeStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignInStateImplCopyWith<$Res>
    implements $SignInStateCopyWith<$Res> {
  factory _$$SignInStateImplCopyWith(
          _$SignInStateImpl value, $Res Function(_$SignInStateImpl) then) =
      __$$SignInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inviteCode,
      String paymentPin,
      String email,
      String verificationCode,
      SignInStatus status,
      NicknameStatus nicknameStatus,
      PaymentPinStatus paymentPinStatus,
      InviteCodeStatus inviteCodeStatus});
}

/// @nodoc
class __$$SignInStateImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInStateImpl>
    implements _$$SignInStateImplCopyWith<$Res> {
  __$$SignInStateImplCopyWithImpl(
      _$SignInStateImpl _value, $Res Function(_$SignInStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteCode = null,
    Object? paymentPin = null,
    Object? email = null,
    Object? verificationCode = null,
    Object? status = null,
    Object? nicknameStatus = null,
    Object? paymentPinStatus = null,
    Object? inviteCodeStatus = null,
  }) {
    return _then(_$SignInStateImpl(
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignInStatus,
      nicknameStatus: null == nicknameStatus
          ? _value.nicknameStatus
          : nicknameStatus // ignore: cast_nullable_to_non_nullable
              as NicknameStatus,
      paymentPinStatus: null == paymentPinStatus
          ? _value.paymentPinStatus
          : paymentPinStatus // ignore: cast_nullable_to_non_nullable
              as PaymentPinStatus,
      inviteCodeStatus: null == inviteCodeStatus
          ? _value.inviteCodeStatus
          : inviteCodeStatus // ignore: cast_nullable_to_non_nullable
              as InviteCodeStatus,
    ));
  }
}

/// @nodoc

class _$SignInStateImpl implements _SignInState {
  const _$SignInStateImpl(
      {this.inviteCode = "",
      this.paymentPin = "",
      this.email = "",
      this.verificationCode = "",
      this.status = SignInStatus.initial,
      this.nicknameStatus = NicknameStatus.initial,
      this.paymentPinStatus = PaymentPinStatus.initial,
      this.inviteCodeStatus = InviteCodeStatus.initial});

// @Default("") String email,
// @Default("") String verificationCode,
// @Default("") String emailError,
// @Default("") String verificationCodeError,
// @Default(false) bool isLoading,
  @override
  @JsonKey()
  final String inviteCode;
  @override
  @JsonKey()
  final String paymentPin;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String verificationCode;
  @override
  @JsonKey()
  final SignInStatus status;
  @override
  @JsonKey()
  final NicknameStatus nicknameStatus;
  @override
  @JsonKey()
  final PaymentPinStatus paymentPinStatus;
  @override
  @JsonKey()
  final InviteCodeStatus inviteCodeStatus;

  @override
  String toString() {
    return 'SignInState(inviteCode: $inviteCode, paymentPin: $paymentPin, email: $email, verificationCode: $verificationCode, status: $status, nicknameStatus: $nicknameStatus, paymentPinStatus: $paymentPinStatus, inviteCodeStatus: $inviteCodeStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInStateImpl &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.paymentPin, paymentPin) ||
                other.paymentPin == paymentPin) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.verificationCode, verificationCode) ||
                other.verificationCode == verificationCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.nicknameStatus, nicknameStatus) ||
                other.nicknameStatus == nicknameStatus) &&
            (identical(other.paymentPinStatus, paymentPinStatus) ||
                other.paymentPinStatus == paymentPinStatus) &&
            (identical(other.inviteCodeStatus, inviteCodeStatus) ||
                other.inviteCodeStatus == inviteCodeStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      inviteCode,
      paymentPin,
      email,
      verificationCode,
      status,
      nicknameStatus,
      paymentPinStatus,
      inviteCodeStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      __$$SignInStateImplCopyWithImpl<_$SignInStateImpl>(this, _$identity);
}

abstract class _SignInState implements SignInState {
  const factory _SignInState(
      {final String inviteCode,
      final String paymentPin,
      final String email,
      final String verificationCode,
      final SignInStatus status,
      final NicknameStatus nicknameStatus,
      final PaymentPinStatus paymentPinStatus,
      final InviteCodeStatus inviteCodeStatus}) = _$SignInStateImpl;

  @override // @Default("") String email,
// @Default("") String verificationCode,
// @Default("") String emailError,
// @Default("") String verificationCodeError,
// @Default(false) bool isLoading,
  String get inviteCode;
  @override
  String get paymentPin;
  @override
  String get email;
  @override
  String get verificationCode;
  @override
  SignInStatus get status;
  @override
  NicknameStatus get nicknameStatus;
  @override
  PaymentPinStatus get paymentPinStatus;
  @override
  InviteCodeStatus get inviteCodeStatus;
  @override
  @JsonKey(ignore: true)
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
