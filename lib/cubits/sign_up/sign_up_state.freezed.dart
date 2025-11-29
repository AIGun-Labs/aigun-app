// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {

 String get paymentPin; String get inviteCode; String get nickname; SignUpStatus get signUpStatus; PaymentPinStatus get paymentPinStatus;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.paymentPin, paymentPin) || other.paymentPin == paymentPin)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.signUpStatus, signUpStatus) || other.signUpStatus == signUpStatus)&&(identical(other.paymentPinStatus, paymentPinStatus) || other.paymentPinStatus == paymentPinStatus));
}


@override
int get hashCode => Object.hash(runtimeType,paymentPin,inviteCode,nickname,signUpStatus,paymentPinStatus);

@override
String toString() {
  return 'SignUpState(paymentPin: $paymentPin, inviteCode: $inviteCode, nickname: $nickname, signUpStatus: $signUpStatus, paymentPinStatus: $paymentPinStatus)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 String paymentPin, String inviteCode, String nickname, SignUpStatus signUpStatus, PaymentPinStatus paymentPinStatus
});




}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentPin = null,Object? inviteCode = null,Object? nickname = null,Object? signUpStatus = null,Object? paymentPinStatus = null,}) {
  return _then(_self.copyWith(
paymentPin: null == paymentPin ? _self.paymentPin : paymentPin // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as SignUpStatus,paymentPinStatus: null == paymentPinStatus ? _self.paymentPinStatus : paymentPinStatus // ignore: cast_nullable_to_non_nullable
as PaymentPinStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentPin,  String inviteCode,  String nickname,  SignUpStatus signUpStatus,  PaymentPinStatus paymentPinStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.paymentPin,_that.inviteCode,_that.nickname,_that.signUpStatus,_that.paymentPinStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentPin,  String inviteCode,  String nickname,  SignUpStatus signUpStatus,  PaymentPinStatus paymentPinStatus)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.paymentPin,_that.inviteCode,_that.nickname,_that.signUpStatus,_that.paymentPinStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentPin,  String inviteCode,  String nickname,  SignUpStatus signUpStatus,  PaymentPinStatus paymentPinStatus)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.paymentPin,_that.inviteCode,_that.nickname,_that.signUpStatus,_that.paymentPinStatus);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState implements SignUpState {
  const _SignUpState({this.paymentPin = "", this.inviteCode = "", this.nickname = "", this.signUpStatus = SignUpStatus.initial, this.paymentPinStatus = PaymentPinStatus.inital});
  

@override@JsonKey() final  String paymentPin;
@override@JsonKey() final  String inviteCode;
@override@JsonKey() final  String nickname;
@override@JsonKey() final  SignUpStatus signUpStatus;
@override@JsonKey() final  PaymentPinStatus paymentPinStatus;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.paymentPin, paymentPin) || other.paymentPin == paymentPin)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.signUpStatus, signUpStatus) || other.signUpStatus == signUpStatus)&&(identical(other.paymentPinStatus, paymentPinStatus) || other.paymentPinStatus == paymentPinStatus));
}


@override
int get hashCode => Object.hash(runtimeType,paymentPin,inviteCode,nickname,signUpStatus,paymentPinStatus);

@override
String toString() {
  return 'SignUpState(paymentPin: $paymentPin, inviteCode: $inviteCode, nickname: $nickname, signUpStatus: $signUpStatus, paymentPinStatus: $paymentPinStatus)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 String paymentPin, String inviteCode, String nickname, SignUpStatus signUpStatus, PaymentPinStatus paymentPinStatus
});




}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentPin = null,Object? inviteCode = null,Object? nickname = null,Object? signUpStatus = null,Object? paymentPinStatus = null,}) {
  return _then(_SignUpState(
paymentPin: null == paymentPin ? _self.paymentPin : paymentPin // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as SignUpStatus,paymentPinStatus: null == paymentPinStatus ? _self.paymentPinStatus : paymentPinStatus // ignore: cast_nullable_to_non_nullable
as PaymentPinStatus,
  ));
}


}

// dart format on
