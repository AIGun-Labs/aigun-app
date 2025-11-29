// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {

// @Default("") String email,
// @Default("") String verificationCode,
// @Default("") String emailError,
// @Default("") String verificationCodeError,
// @Default(false) bool isLoading,
 String get inviteCode; String get paymentPin; String get email; String get verificationCode; SignInStatus get status; NicknameStatus get nicknameStatus; PaymentPinStatus get paymentPinStatus; InviteCodeStatus get inviteCodeStatus;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.paymentPin, paymentPin) || other.paymentPin == paymentPin)&&(identical(other.email, email) || other.email == email)&&(identical(other.verificationCode, verificationCode) || other.verificationCode == verificationCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.nicknameStatus, nicknameStatus) || other.nicknameStatus == nicknameStatus)&&(identical(other.paymentPinStatus, paymentPinStatus) || other.paymentPinStatus == paymentPinStatus)&&(identical(other.inviteCodeStatus, inviteCodeStatus) || other.inviteCodeStatus == inviteCodeStatus));
}


@override
int get hashCode => Object.hash(runtimeType,inviteCode,paymentPin,email,verificationCode,status,nicknameStatus,paymentPinStatus,inviteCodeStatus);

@override
String toString() {
  return 'SignInState(inviteCode: $inviteCode, paymentPin: $paymentPin, email: $email, verificationCode: $verificationCode, status: $status, nicknameStatus: $nicknameStatus, paymentPinStatus: $paymentPinStatus, inviteCodeStatus: $inviteCodeStatus)';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 String inviteCode, String paymentPin, String email, String verificationCode, SignInStatus status, NicknameStatus nicknameStatus, PaymentPinStatus paymentPinStatus, InviteCodeStatus inviteCodeStatus
});




}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inviteCode = null,Object? paymentPin = null,Object? email = null,Object? verificationCode = null,Object? status = null,Object? nicknameStatus = null,Object? paymentPinStatus = null,Object? inviteCodeStatus = null,}) {
  return _then(_self.copyWith(
inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,paymentPin: null == paymentPin ? _self.paymentPin : paymentPin // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verificationCode: null == verificationCode ? _self.verificationCode : verificationCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignInStatus,nicknameStatus: null == nicknameStatus ? _self.nicknameStatus : nicknameStatus // ignore: cast_nullable_to_non_nullable
as NicknameStatus,paymentPinStatus: null == paymentPinStatus ? _self.paymentPinStatus : paymentPinStatus // ignore: cast_nullable_to_non_nullable
as PaymentPinStatus,inviteCodeStatus: null == inviteCodeStatus ? _self.inviteCodeStatus : inviteCodeStatus // ignore: cast_nullable_to_non_nullable
as InviteCodeStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String inviteCode,  String paymentPin,  String email,  String verificationCode,  SignInStatus status,  NicknameStatus nicknameStatus,  PaymentPinStatus paymentPinStatus,  InviteCodeStatus inviteCodeStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.inviteCode,_that.paymentPin,_that.email,_that.verificationCode,_that.status,_that.nicknameStatus,_that.paymentPinStatus,_that.inviteCodeStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String inviteCode,  String paymentPin,  String email,  String verificationCode,  SignInStatus status,  NicknameStatus nicknameStatus,  PaymentPinStatus paymentPinStatus,  InviteCodeStatus inviteCodeStatus)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.inviteCode,_that.paymentPin,_that.email,_that.verificationCode,_that.status,_that.nicknameStatus,_that.paymentPinStatus,_that.inviteCodeStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String inviteCode,  String paymentPin,  String email,  String verificationCode,  SignInStatus status,  NicknameStatus nicknameStatus,  PaymentPinStatus paymentPinStatus,  InviteCodeStatus inviteCodeStatus)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.inviteCode,_that.paymentPin,_that.email,_that.verificationCode,_that.status,_that.nicknameStatus,_that.paymentPinStatus,_that.inviteCodeStatus);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState implements SignInState {
  const _SignInState({this.inviteCode = "", this.paymentPin = "", this.email = "", this.verificationCode = "", this.status = SignInStatus.initial, this.nicknameStatus = NicknameStatus.initial, this.paymentPinStatus = PaymentPinStatus.initial, this.inviteCodeStatus = InviteCodeStatus.initial});
  

// @Default("") String email,
// @Default("") String verificationCode,
// @Default("") String emailError,
// @Default("") String verificationCodeError,
// @Default(false) bool isLoading,
@override@JsonKey() final  String inviteCode;
@override@JsonKey() final  String paymentPin;
@override@JsonKey() final  String email;
@override@JsonKey() final  String verificationCode;
@override@JsonKey() final  SignInStatus status;
@override@JsonKey() final  NicknameStatus nicknameStatus;
@override@JsonKey() final  PaymentPinStatus paymentPinStatus;
@override@JsonKey() final  InviteCodeStatus inviteCodeStatus;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.paymentPin, paymentPin) || other.paymentPin == paymentPin)&&(identical(other.email, email) || other.email == email)&&(identical(other.verificationCode, verificationCode) || other.verificationCode == verificationCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.nicknameStatus, nicknameStatus) || other.nicknameStatus == nicknameStatus)&&(identical(other.paymentPinStatus, paymentPinStatus) || other.paymentPinStatus == paymentPinStatus)&&(identical(other.inviteCodeStatus, inviteCodeStatus) || other.inviteCodeStatus == inviteCodeStatus));
}


@override
int get hashCode => Object.hash(runtimeType,inviteCode,paymentPin,email,verificationCode,status,nicknameStatus,paymentPinStatus,inviteCodeStatus);

@override
String toString() {
  return 'SignInState(inviteCode: $inviteCode, paymentPin: $paymentPin, email: $email, verificationCode: $verificationCode, status: $status, nicknameStatus: $nicknameStatus, paymentPinStatus: $paymentPinStatus, inviteCodeStatus: $inviteCodeStatus)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 String inviteCode, String paymentPin, String email, String verificationCode, SignInStatus status, NicknameStatus nicknameStatus, PaymentPinStatus paymentPinStatus, InviteCodeStatus inviteCodeStatus
});




}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inviteCode = null,Object? paymentPin = null,Object? email = null,Object? verificationCode = null,Object? status = null,Object? nicknameStatus = null,Object? paymentPinStatus = null,Object? inviteCodeStatus = null,}) {
  return _then(_SignInState(
inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,paymentPin: null == paymentPin ? _self.paymentPin : paymentPin // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verificationCode: null == verificationCode ? _self.verificationCode : verificationCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignInStatus,nicknameStatus: null == nicknameStatus ? _self.nicknameStatus : nicknameStatus // ignore: cast_nullable_to_non_nullable
as NicknameStatus,paymentPinStatus: null == paymentPinStatus ? _self.paymentPinStatus : paymentPinStatus // ignore: cast_nullable_to_non_nullable
as PaymentPinStatus,inviteCodeStatus: null == inviteCodeStatus ? _self.inviteCodeStatus : inviteCodeStatus // ignore: cast_nullable_to_non_nullable
as InviteCodeStatus,
  ));
}


}

// dart format on
