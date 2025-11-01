// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpState {
  String get paymentPin => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  SignUpStatus get signUpStatus => throw _privateConstructorUsedError;
  PaymentPinStatus get paymentPinStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpStateCopyWith<SignUpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
  @useResult
  $Res call(
      {String paymentPin,
      String inviteCode,
      String nickname,
      SignUpStatus signUpStatus,
      PaymentPinStatus paymentPinStatus});
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentPin = null,
    Object? inviteCode = null,
    Object? nickname = null,
    Object? signUpStatus = null,
    Object? paymentPinStatus = null,
  }) {
    return _then(_value.copyWith(
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      signUpStatus: null == signUpStatus
          ? _value.signUpStatus
          : signUpStatus // ignore: cast_nullable_to_non_nullable
              as SignUpStatus,
      paymentPinStatus: null == paymentPinStatus
          ? _value.paymentPinStatus
          : paymentPinStatus // ignore: cast_nullable_to_non_nullable
              as PaymentPinStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpStateImplCopyWith<$Res>
    implements $SignUpStateCopyWith<$Res> {
  factory _$$SignUpStateImplCopyWith(
          _$SignUpStateImpl value, $Res Function(_$SignUpStateImpl) then) =
      __$$SignUpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymentPin,
      String inviteCode,
      String nickname,
      SignUpStatus signUpStatus,
      PaymentPinStatus paymentPinStatus});
}

/// @nodoc
class __$$SignUpStateImplCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateImpl>
    implements _$$SignUpStateImplCopyWith<$Res> {
  __$$SignUpStateImplCopyWithImpl(
      _$SignUpStateImpl _value, $Res Function(_$SignUpStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentPin = null,
    Object? inviteCode = null,
    Object? nickname = null,
    Object? signUpStatus = null,
    Object? paymentPinStatus = null,
  }) {
    return _then(_$SignUpStateImpl(
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      signUpStatus: null == signUpStatus
          ? _value.signUpStatus
          : signUpStatus // ignore: cast_nullable_to_non_nullable
              as SignUpStatus,
      paymentPinStatus: null == paymentPinStatus
          ? _value.paymentPinStatus
          : paymentPinStatus // ignore: cast_nullable_to_non_nullable
              as PaymentPinStatus,
    ));
  }
}

/// @nodoc

class _$SignUpStateImpl implements _SignUpState {
  const _$SignUpStateImpl(
      {this.paymentPin = "",
      this.inviteCode = "",
      this.nickname = "",
      this.signUpStatus = SignUpStatus.initial,
      this.paymentPinStatus = PaymentPinStatus.inital});

  @override
  @JsonKey()
  final String paymentPin;
  @override
  @JsonKey()
  final String inviteCode;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey()
  final SignUpStatus signUpStatus;
  @override
  @JsonKey()
  final PaymentPinStatus paymentPinStatus;

  @override
  String toString() {
    return 'SignUpState(paymentPin: $paymentPin, inviteCode: $inviteCode, nickname: $nickname, signUpStatus: $signUpStatus, paymentPinStatus: $paymentPinStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpStateImpl &&
            (identical(other.paymentPin, paymentPin) ||
                other.paymentPin == paymentPin) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.signUpStatus, signUpStatus) ||
                other.signUpStatus == signUpStatus) &&
            (identical(other.paymentPinStatus, paymentPinStatus) ||
                other.paymentPinStatus == paymentPinStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentPin, inviteCode, nickname,
      signUpStatus, paymentPinStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      __$$SignUpStateImplCopyWithImpl<_$SignUpStateImpl>(this, _$identity);
}

abstract class _SignUpState implements SignUpState {
  const factory _SignUpState(
      {final String paymentPin,
      final String inviteCode,
      final String nickname,
      final SignUpStatus signUpStatus,
      final PaymentPinStatus paymentPinStatus}) = _$SignUpStateImpl;

  @override
  String get paymentPin;
  @override
  String get inviteCode;
  @override
  String get nickname;
  @override
  SignUpStatus get signUpStatus;
  @override
  PaymentPinStatus get paymentPinStatus;
  @override
  @JsonKey(ignore: true)
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
