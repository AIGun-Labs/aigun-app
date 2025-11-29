// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {

 String get email; String get code; String get newPassword; String get confirmPassword; bool get isLoading; bool get isSuccess; bool get isError; String? get errorMessage; ValidationError? get emailError; ValidationError? get codeError; ValidationError? get newPasswordError; ValidationError? get confirmPasswordError; QueryStatus? get queryStatus; bool get isEmailCheckLoading; bool get isEmailExists;
/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordStateCopyWith<ForgotPasswordState> get copyWith => _$ForgotPasswordStateCopyWithImpl<ForgotPasswordState>(this as ForgotPasswordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.codeError, codeError) || other.codeError == codeError)&&(identical(other.newPasswordError, newPasswordError) || other.newPasswordError == newPasswordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.queryStatus, queryStatus) || other.queryStatus == queryStatus)&&(identical(other.isEmailCheckLoading, isEmailCheckLoading) || other.isEmailCheckLoading == isEmailCheckLoading)&&(identical(other.isEmailExists, isEmailExists) || other.isEmailExists == isEmailExists));
}


@override
int get hashCode => Object.hash(runtimeType,email,code,newPassword,confirmPassword,isLoading,isSuccess,isError,errorMessage,emailError,codeError,newPasswordError,confirmPasswordError,queryStatus,isEmailCheckLoading,isEmailExists);

@override
String toString() {
  return 'ForgotPasswordState(email: $email, code: $code, newPassword: $newPassword, confirmPassword: $confirmPassword, isLoading: $isLoading, isSuccess: $isSuccess, isError: $isError, errorMessage: $errorMessage, emailError: $emailError, codeError: $codeError, newPasswordError: $newPasswordError, confirmPasswordError: $confirmPasswordError, queryStatus: $queryStatus, isEmailCheckLoading: $isEmailCheckLoading, isEmailExists: $isEmailExists)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordStateCopyWith<$Res>  {
  factory $ForgotPasswordStateCopyWith(ForgotPasswordState value, $Res Function(ForgotPasswordState) _then) = _$ForgotPasswordStateCopyWithImpl;
@useResult
$Res call({
 String email, String code, String newPassword, String confirmPassword, bool isLoading, bool isSuccess, bool isError, String? errorMessage, ValidationError? emailError, ValidationError? codeError, ValidationError? newPasswordError, ValidationError? confirmPasswordError, QueryStatus? queryStatus, bool isEmailCheckLoading, bool isEmailExists
});




}
/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final ForgotPasswordState _self;
  final $Res Function(ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? code = null,Object? newPassword = null,Object? confirmPassword = null,Object? isLoading = null,Object? isSuccess = null,Object? isError = null,Object? errorMessage = freezed,Object? emailError = freezed,Object? codeError = freezed,Object? newPasswordError = freezed,Object? confirmPasswordError = freezed,Object? queryStatus = freezed,Object? isEmailCheckLoading = null,Object? isEmailExists = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as ValidationError?,codeError: freezed == codeError ? _self.codeError : codeError // ignore: cast_nullable_to_non_nullable
as ValidationError?,newPasswordError: freezed == newPasswordError ? _self.newPasswordError : newPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,queryStatus: freezed == queryStatus ? _self.queryStatus : queryStatus // ignore: cast_nullable_to_non_nullable
as QueryStatus?,isEmailCheckLoading: null == isEmailCheckLoading ? _self.isEmailCheckLoading : isEmailCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,isEmailExists: null == isEmailExists ? _self.isEmailExists : isEmailExists // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String code,  String newPassword,  String confirmPassword,  bool isLoading,  bool isSuccess,  bool isError,  String? errorMessage,  ValidationError? emailError,  ValidationError? codeError,  ValidationError? newPasswordError,  ValidationError? confirmPasswordError,  QueryStatus? queryStatus,  bool isEmailCheckLoading,  bool isEmailExists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.email,_that.code,_that.newPassword,_that.confirmPassword,_that.isLoading,_that.isSuccess,_that.isError,_that.errorMessage,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError,_that.queryStatus,_that.isEmailCheckLoading,_that.isEmailExists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String code,  String newPassword,  String confirmPassword,  bool isLoading,  bool isSuccess,  bool isError,  String? errorMessage,  ValidationError? emailError,  ValidationError? codeError,  ValidationError? newPasswordError,  ValidationError? confirmPasswordError,  QueryStatus? queryStatus,  bool isEmailCheckLoading,  bool isEmailExists)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState():
return $default(_that.email,_that.code,_that.newPassword,_that.confirmPassword,_that.isLoading,_that.isSuccess,_that.isError,_that.errorMessage,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError,_that.queryStatus,_that.isEmailCheckLoading,_that.isEmailExists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String code,  String newPassword,  String confirmPassword,  bool isLoading,  bool isSuccess,  bool isError,  String? errorMessage,  ValidationError? emailError,  ValidationError? codeError,  ValidationError? newPasswordError,  ValidationError? confirmPasswordError,  QueryStatus? queryStatus,  bool isEmailCheckLoading,  bool isEmailExists)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.email,_that.code,_that.newPassword,_that.confirmPassword,_that.isLoading,_that.isSuccess,_that.isError,_that.errorMessage,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError,_that.queryStatus,_that.isEmailCheckLoading,_that.isEmailExists);case _:
  return null;

}
}

}

/// @nodoc


class _ForgotPasswordState implements ForgotPasswordState {
  const _ForgotPasswordState({this.email = '', this.code = '', this.newPassword = '', this.confirmPassword = '', this.isLoading = false, this.isSuccess = false, this.isError = false, this.errorMessage, this.emailError, this.codeError, this.newPasswordError, this.confirmPasswordError, this.queryStatus, this.isEmailCheckLoading = false, this.isEmailExists = true});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String code;
@override@JsonKey() final  String newPassword;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override@JsonKey() final  bool isError;
@override final  String? errorMessage;
@override final  ValidationError? emailError;
@override final  ValidationError? codeError;
@override final  ValidationError? newPasswordError;
@override final  ValidationError? confirmPasswordError;
@override final  QueryStatus? queryStatus;
@override@JsonKey() final  bool isEmailCheckLoading;
@override@JsonKey() final  bool isEmailExists;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordStateCopyWith<_ForgotPasswordState> get copyWith => __$ForgotPasswordStateCopyWithImpl<_ForgotPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordState&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.codeError, codeError) || other.codeError == codeError)&&(identical(other.newPasswordError, newPasswordError) || other.newPasswordError == newPasswordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.queryStatus, queryStatus) || other.queryStatus == queryStatus)&&(identical(other.isEmailCheckLoading, isEmailCheckLoading) || other.isEmailCheckLoading == isEmailCheckLoading)&&(identical(other.isEmailExists, isEmailExists) || other.isEmailExists == isEmailExists));
}


@override
int get hashCode => Object.hash(runtimeType,email,code,newPassword,confirmPassword,isLoading,isSuccess,isError,errorMessage,emailError,codeError,newPasswordError,confirmPasswordError,queryStatus,isEmailCheckLoading,isEmailExists);

@override
String toString() {
  return 'ForgotPasswordState(email: $email, code: $code, newPassword: $newPassword, confirmPassword: $confirmPassword, isLoading: $isLoading, isSuccess: $isSuccess, isError: $isError, errorMessage: $errorMessage, emailError: $emailError, codeError: $codeError, newPasswordError: $newPasswordError, confirmPasswordError: $confirmPasswordError, queryStatus: $queryStatus, isEmailCheckLoading: $isEmailCheckLoading, isEmailExists: $isEmailExists)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordStateCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory _$ForgotPasswordStateCopyWith(_ForgotPasswordState value, $Res Function(_ForgotPasswordState) _then) = __$ForgotPasswordStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String code, String newPassword, String confirmPassword, bool isLoading, bool isSuccess, bool isError, String? errorMessage, ValidationError? emailError, ValidationError? codeError, ValidationError? newPasswordError, ValidationError? confirmPasswordError, QueryStatus? queryStatus, bool isEmailCheckLoading, bool isEmailExists
});




}
/// @nodoc
class __$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$ForgotPasswordStateCopyWith<$Res> {
  __$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final _ForgotPasswordState _self;
  final $Res Function(_ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? code = null,Object? newPassword = null,Object? confirmPassword = null,Object? isLoading = null,Object? isSuccess = null,Object? isError = null,Object? errorMessage = freezed,Object? emailError = freezed,Object? codeError = freezed,Object? newPasswordError = freezed,Object? confirmPasswordError = freezed,Object? queryStatus = freezed,Object? isEmailCheckLoading = null,Object? isEmailExists = null,}) {
  return _then(_ForgotPasswordState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as ValidationError?,codeError: freezed == codeError ? _self.codeError : codeError // ignore: cast_nullable_to_non_nullable
as ValidationError?,newPasswordError: freezed == newPasswordError ? _self.newPasswordError : newPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as ValidationError?,queryStatus: freezed == queryStatus ? _self.queryStatus : queryStatus // ignore: cast_nullable_to_non_nullable
as QueryStatus?,isEmailCheckLoading: null == isEmailCheckLoading ? _self.isEmailCheckLoading : isEmailCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,isEmailExists: null == isEmailExists ? _self.isEmailExists : isEmailExists // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
