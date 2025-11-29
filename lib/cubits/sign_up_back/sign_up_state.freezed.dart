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

 String get email; String get nickname; String get password; String get confirmPassword; String get code; bool get isLoading; bool get isSuccess; String? get message; int? get errorCode; ValidationError? get emailError; ValidationError? get nicknameError; ValidationError? get passwordError; ValidationError? get confirmPasswordError; bool get isEmailCheckLoading; bool get isEmailExists;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.email, email) || other.email == email)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.code, code) || other.code == code)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.isEmailCheckLoading, isEmailCheckLoading) || other.isEmailCheckLoading == isEmailCheckLoading)&&(identical(other.isEmailExists, isEmailExists) || other.isEmailExists == isEmailExists));
}


@override
int get hashCode => Object.hash(runtimeType,email,nickname,password,confirmPassword,code,isLoading,isSuccess,message,errorCode,emailError,nicknameError,passwordError,confirmPasswordError,isEmailCheckLoading,isEmailExists);

@override
String toString() {
  return 'SignUpState(email: $email, nickname: $nickname, password: $password, confirmPassword: $confirmPassword, code: $code, isLoading: $isLoading, isSuccess: $isSuccess, message: $message, errorCode: $errorCode, emailError: $emailError, nicknameError: $nicknameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isEmailCheckLoading: $isEmailCheckLoading, isEmailExists: $isEmailExists)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 String email, String nickname, String password, String confirmPassword, String code, bool isLoading, bool isSuccess, String? message, int? errorCode, ValidationError? emailError, ValidationError? nicknameError, ValidationError? passwordError, ValidationError? confirmPasswordError, bool isEmailCheckLoading, bool isEmailExists
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
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? nickname = null,Object? password = null,Object? confirmPassword = null,Object? code = null,Object? isLoading = null,Object? isSuccess = null,Object? message = freezed,Object? errorCode = freezed,Object? emailError = freezed,Object? nicknameError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? isEmailCheckLoading = null,Object? isEmailExists = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as int?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as ValidationError?,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as ValidationError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,isEmailCheckLoading: null == isEmailCheckLoading ? _self.isEmailCheckLoading : isEmailCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,isEmailExists: null == isEmailExists ? _self.isEmailExists : isEmailExists // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String nickname,  String password,  String confirmPassword,  String code,  bool isLoading,  bool isSuccess,  String? message,  int? errorCode,  ValidationError? emailError,  ValidationError? nicknameError,  ValidationError? passwordError,  ValidationError? confirmPasswordError,  bool isEmailCheckLoading,  bool isEmailExists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.email,_that.nickname,_that.password,_that.confirmPassword,_that.code,_that.isLoading,_that.isSuccess,_that.message,_that.errorCode,_that.emailError,_that.nicknameError,_that.passwordError,_that.confirmPasswordError,_that.isEmailCheckLoading,_that.isEmailExists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String nickname,  String password,  String confirmPassword,  String code,  bool isLoading,  bool isSuccess,  String? message,  int? errorCode,  ValidationError? emailError,  ValidationError? nicknameError,  ValidationError? passwordError,  ValidationError? confirmPasswordError,  bool isEmailCheckLoading,  bool isEmailExists)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.email,_that.nickname,_that.password,_that.confirmPassword,_that.code,_that.isLoading,_that.isSuccess,_that.message,_that.errorCode,_that.emailError,_that.nicknameError,_that.passwordError,_that.confirmPasswordError,_that.isEmailCheckLoading,_that.isEmailExists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String nickname,  String password,  String confirmPassword,  String code,  bool isLoading,  bool isSuccess,  String? message,  int? errorCode,  ValidationError? emailError,  ValidationError? nicknameError,  ValidationError? passwordError,  ValidationError? confirmPasswordError,  bool isEmailCheckLoading,  bool isEmailExists)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.email,_that.nickname,_that.password,_that.confirmPassword,_that.code,_that.isLoading,_that.isSuccess,_that.message,_that.errorCode,_that.emailError,_that.nicknameError,_that.passwordError,_that.confirmPasswordError,_that.isEmailCheckLoading,_that.isEmailExists);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState implements SignUpState {
  const _SignUpState({this.email = '', this.nickname = '', this.password = '', this.confirmPassword = '', this.code = '', this.isLoading = false, this.isSuccess = false, this.message, this.errorCode, this.emailError, this.nicknameError, this.passwordError, this.confirmPasswordError, this.isEmailCheckLoading = false, this.isEmailExists = false});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String nickname;
@override@JsonKey() final  String password;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  String code;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override final  String? message;
@override final  int? errorCode;
@override final  ValidationError? emailError;
@override final  ValidationError? nicknameError;
@override final  ValidationError? passwordError;
@override final  ValidationError? confirmPasswordError;
@override@JsonKey() final  bool isEmailCheckLoading;
@override@JsonKey() final  bool isEmailExists;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.email, email) || other.email == email)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.code, code) || other.code == code)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.isEmailCheckLoading, isEmailCheckLoading) || other.isEmailCheckLoading == isEmailCheckLoading)&&(identical(other.isEmailExists, isEmailExists) || other.isEmailExists == isEmailExists));
}


@override
int get hashCode => Object.hash(runtimeType,email,nickname,password,confirmPassword,code,isLoading,isSuccess,message,errorCode,emailError,nicknameError,passwordError,confirmPasswordError,isEmailCheckLoading,isEmailExists);

@override
String toString() {
  return 'SignUpState(email: $email, nickname: $nickname, password: $password, confirmPassword: $confirmPassword, code: $code, isLoading: $isLoading, isSuccess: $isSuccess, message: $message, errorCode: $errorCode, emailError: $emailError, nicknameError: $nicknameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isEmailCheckLoading: $isEmailCheckLoading, isEmailExists: $isEmailExists)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String nickname, String password, String confirmPassword, String code, bool isLoading, bool isSuccess, String? message, int? errorCode, ValidationError? emailError, ValidationError? nicknameError, ValidationError? passwordError, ValidationError? confirmPasswordError, bool isEmailCheckLoading, bool isEmailExists
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
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? nickname = null,Object? password = null,Object? confirmPassword = null,Object? code = null,Object? isLoading = null,Object? isSuccess = null,Object? message = freezed,Object? errorCode = freezed,Object? emailError = freezed,Object? nicknameError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? isEmailCheckLoading = null,Object? isEmailExists = null,}) {
  return _then(_SignUpState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as int?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as ValidationError?,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as ValidationError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,isEmailCheckLoading: null == isEmailCheckLoading ? _self.isEmailCheckLoading : isEmailCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,isEmailExists: null == isEmailExists ? _self.isEmailExists : isEmailExists // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
