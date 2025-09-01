// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SingleShotEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String titleKey, String messageKey) showDialog,
    required TResult Function() loginSuccess,
    required TResult Function() userExists,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String titleKey, String messageKey)? showDialog,
    TResult? Function()? loginSuccess,
    TResult? Function()? userExists,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String titleKey, String messageKey)? showDialog,
    TResult Function()? loginSuccess,
    TResult Function()? userExists,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_UserExists value) userExists,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ShowDialog value)? showDialog,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_UserExists value)? userExists,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_UserExists value)? userExists,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleShotEventCopyWith<$Res> {
  factory $SingleShotEventCopyWith(
          SingleShotEvent value, $Res Function(SingleShotEvent) then) =
      _$SingleShotEventCopyWithImpl<$Res, SingleShotEvent>;
}

/// @nodoc
class _$SingleShotEventCopyWithImpl<$Res, $Val extends SingleShotEvent>
    implements $SingleShotEventCopyWith<$Res> {
  _$SingleShotEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShowDialogImplCopyWith<$Res> {
  factory _$$ShowDialogImplCopyWith(
          _$ShowDialogImpl value, $Res Function(_$ShowDialogImpl) then) =
      __$$ShowDialogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String titleKey, String messageKey});
}

/// @nodoc
class __$$ShowDialogImplCopyWithImpl<$Res>
    extends _$SingleShotEventCopyWithImpl<$Res, _$ShowDialogImpl>
    implements _$$ShowDialogImplCopyWith<$Res> {
  __$$ShowDialogImplCopyWithImpl(
      _$ShowDialogImpl _value, $Res Function(_$ShowDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleKey = null,
    Object? messageKey = null,
  }) {
    return _then(_$ShowDialogImpl(
      titleKey: null == titleKey
          ? _value.titleKey
          : titleKey // ignore: cast_nullable_to_non_nullable
              as String,
      messageKey: null == messageKey
          ? _value.messageKey
          : messageKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ShowDialogImpl implements _ShowDialog {
  const _$ShowDialogImpl({required this.titleKey, required this.messageKey});

  @override
  final String titleKey;
  @override
  final String messageKey;

  @override
  String toString() {
    return 'SingleShotEvent.showDialog(titleKey: $titleKey, messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowDialogImpl &&
            (identical(other.titleKey, titleKey) ||
                other.titleKey == titleKey) &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, titleKey, messageKey);

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowDialogImplCopyWith<_$ShowDialogImpl> get copyWith =>
      __$$ShowDialogImplCopyWithImpl<_$ShowDialogImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String titleKey, String messageKey) showDialog,
    required TResult Function() loginSuccess,
    required TResult Function() userExists,
  }) {
    return showDialog(titleKey, messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String titleKey, String messageKey)? showDialog,
    TResult? Function()? loginSuccess,
    TResult? Function()? userExists,
  }) {
    return showDialog?.call(titleKey, messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String titleKey, String messageKey)? showDialog,
    TResult Function()? loginSuccess,
    TResult Function()? userExists,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(titleKey, messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_UserExists value) userExists,
  }) {
    return showDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ShowDialog value)? showDialog,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_UserExists value)? userExists,
  }) {
    return showDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_UserExists value)? userExists,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(this);
    }
    return orElse();
  }
}

abstract class _ShowDialog implements SingleShotEvent {
  const factory _ShowDialog(
      {required final String titleKey,
      required final String messageKey}) = _$ShowDialogImpl;

  String get titleKey;
  String get messageKey;

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowDialogImplCopyWith<_$ShowDialogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginSuccessImplCopyWith<$Res> {
  factory _$$LoginSuccessImplCopyWith(
          _$LoginSuccessImpl value, $Res Function(_$LoginSuccessImpl) then) =
      __$$LoginSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSuccessImplCopyWithImpl<$Res>
    extends _$SingleShotEventCopyWithImpl<$Res, _$LoginSuccessImpl>
    implements _$$LoginSuccessImplCopyWith<$Res> {
  __$$LoginSuccessImplCopyWithImpl(
      _$LoginSuccessImpl _value, $Res Function(_$LoginSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSuccessImpl implements _LoginSuccess {
  const _$LoginSuccessImpl();

  @override
  String toString() {
    return 'SingleShotEvent.loginSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String titleKey, String messageKey) showDialog,
    required TResult Function() loginSuccess,
    required TResult Function() userExists,
  }) {
    return loginSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String titleKey, String messageKey)? showDialog,
    TResult? Function()? loginSuccess,
    TResult? Function()? userExists,
  }) {
    return loginSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String titleKey, String messageKey)? showDialog,
    TResult Function()? loginSuccess,
    TResult Function()? userExists,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_UserExists value) userExists,
  }) {
    return loginSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ShowDialog value)? showDialog,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_UserExists value)? userExists,
  }) {
    return loginSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_UserExists value)? userExists,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoginSuccess implements SingleShotEvent {
  const factory _LoginSuccess() = _$LoginSuccessImpl;
}

/// @nodoc
abstract class _$$UserExistsImplCopyWith<$Res> {
  factory _$$UserExistsImplCopyWith(
          _$UserExistsImpl value, $Res Function(_$UserExistsImpl) then) =
      __$$UserExistsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserExistsImplCopyWithImpl<$Res>
    extends _$SingleShotEventCopyWithImpl<$Res, _$UserExistsImpl>
    implements _$$UserExistsImplCopyWith<$Res> {
  __$$UserExistsImplCopyWithImpl(
      _$UserExistsImpl _value, $Res Function(_$UserExistsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleShotEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserExistsImpl implements _UserExists {
  const _$UserExistsImpl();

  @override
  String toString() {
    return 'SingleShotEvent.userExists()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserExistsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String titleKey, String messageKey) showDialog,
    required TResult Function() loginSuccess,
    required TResult Function() userExists,
  }) {
    return userExists();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String titleKey, String messageKey)? showDialog,
    TResult? Function()? loginSuccess,
    TResult? Function()? userExists,
  }) {
    return userExists?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String titleKey, String messageKey)? showDialog,
    TResult Function()? loginSuccess,
    TResult Function()? userExists,
    required TResult orElse(),
  }) {
    if (userExists != null) {
      return userExists();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_UserExists value) userExists,
  }) {
    return userExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ShowDialog value)? showDialog,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_UserExists value)? userExists,
  }) {
    return userExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_UserExists value)? userExists,
    required TResult orElse(),
  }) {
    if (userExists != null) {
      return userExists(this);
    }
    return orElse();
  }
}

abstract class _UserExists implements SingleShotEvent {
  const factory _UserExists() = _$UserExistsImpl;
}

/// @nodoc
mixin _$AuthState {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  NetworkState<void> get sendCodeStatus => throw _privateConstructorUsedError;
  NetworkState<void> get verifyCodeStatus => throw _privateConstructorUsedError;
  NetworkState<void> get registerStatus => throw _privateConstructorUsedError;
  bool get isCodeValid => throw _privateConstructorUsedError;
  bool get isNicknameValid => throw _privateConstructorUsedError;
  bool get isInviteCodeValid => throw _privateConstructorUsedError;
  bool get isEmailValid => throw _privateConstructorUsedError;
  bool get isUserExists => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int get thanksMessageId => throw _privateConstructorUsedError;
  String get paymentPin => throw _privateConstructorUsedError;
  bool get isPaymentPinValid => throw _privateConstructorUsedError;
  bool get isLoggedIn => throw _privateConstructorUsedError;
  SingleShotEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {String email,
      String code,
      String nickname,
      String inviteCode,
      NetworkState<void> sendCodeStatus,
      NetworkState<void> verifyCodeStatus,
      NetworkState<void> registerStatus,
      bool isCodeValid,
      bool isNicknameValid,
      bool isInviteCodeValid,
      bool isEmailValid,
      bool isUserExists,
      bool isLoading,
      int thanksMessageId,
      String paymentPin,
      bool isPaymentPinValid,
      bool isLoggedIn,
      SingleShotEvent? event});

  $NetworkStateCopyWith<void, $Res> get sendCodeStatus;
  $NetworkStateCopyWith<void, $Res> get verifyCodeStatus;
  $NetworkStateCopyWith<void, $Res> get registerStatus;
  $SingleShotEventCopyWith<$Res>? get event;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? nickname = null,
    Object? inviteCode = null,
    Object? sendCodeStatus = null,
    Object? verifyCodeStatus = null,
    Object? registerStatus = null,
    Object? isCodeValid = null,
    Object? isNicknameValid = null,
    Object? isInviteCodeValid = null,
    Object? isEmailValid = null,
    Object? isUserExists = null,
    Object? isLoading = null,
    Object? thanksMessageId = null,
    Object? paymentPin = null,
    Object? isPaymentPinValid = null,
    Object? isLoggedIn = null,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      sendCodeStatus: null == sendCodeStatus
          ? _value.sendCodeStatus
          : sendCodeStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      verifyCodeStatus: null == verifyCodeStatus
          ? _value.verifyCodeStatus
          : verifyCodeStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      isCodeValid: null == isCodeValid
          ? _value.isCodeValid
          : isCodeValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isNicknameValid: null == isNicknameValid
          ? _value.isNicknameValid
          : isNicknameValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isInviteCodeValid: null == isInviteCodeValid
          ? _value.isInviteCodeValid
          : isInviteCodeValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserExists: null == isUserExists
          ? _value.isUserExists
          : isUserExists // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      thanksMessageId: null == thanksMessageId
          ? _value.thanksMessageId
          : thanksMessageId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      isPaymentPinValid: null == isPaymentPinValid
          ? _value.isPaymentPinValid
          : isPaymentPinValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SingleShotEvent?,
    ) as $Val);
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkStateCopyWith<void, $Res> get sendCodeStatus {
    return $NetworkStateCopyWith<void, $Res>(_value.sendCodeStatus, (value) {
      return _then(_value.copyWith(sendCodeStatus: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkStateCopyWith<void, $Res> get verifyCodeStatus {
    return $NetworkStateCopyWith<void, $Res>(_value.verifyCodeStatus, (value) {
      return _then(_value.copyWith(verifyCodeStatus: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkStateCopyWith<void, $Res> get registerStatus {
    return $NetworkStateCopyWith<void, $Res>(_value.registerStatus, (value) {
      return _then(_value.copyWith(registerStatus: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SingleShotEventCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $SingleShotEventCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String code,
      String nickname,
      String inviteCode,
      NetworkState<void> sendCodeStatus,
      NetworkState<void> verifyCodeStatus,
      NetworkState<void> registerStatus,
      bool isCodeValid,
      bool isNicknameValid,
      bool isInviteCodeValid,
      bool isEmailValid,
      bool isUserExists,
      bool isLoading,
      int thanksMessageId,
      String paymentPin,
      bool isPaymentPinValid,
      bool isLoggedIn,
      SingleShotEvent? event});

  @override
  $NetworkStateCopyWith<void, $Res> get sendCodeStatus;
  @override
  $NetworkStateCopyWith<void, $Res> get verifyCodeStatus;
  @override
  $NetworkStateCopyWith<void, $Res> get registerStatus;
  @override
  $SingleShotEventCopyWith<$Res>? get event;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? nickname = null,
    Object? inviteCode = null,
    Object? sendCodeStatus = null,
    Object? verifyCodeStatus = null,
    Object? registerStatus = null,
    Object? isCodeValid = null,
    Object? isNicknameValid = null,
    Object? isInviteCodeValid = null,
    Object? isEmailValid = null,
    Object? isUserExists = null,
    Object? isLoading = null,
    Object? thanksMessageId = null,
    Object? paymentPin = null,
    Object? isPaymentPinValid = null,
    Object? isLoggedIn = null,
    Object? event = freezed,
  }) {
    return _then(_$AuthStateImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      sendCodeStatus: null == sendCodeStatus
          ? _value.sendCodeStatus
          : sendCodeStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      verifyCodeStatus: null == verifyCodeStatus
          ? _value.verifyCodeStatus
          : verifyCodeStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as NetworkState<void>,
      isCodeValid: null == isCodeValid
          ? _value.isCodeValid
          : isCodeValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isNicknameValid: null == isNicknameValid
          ? _value.isNicknameValid
          : isNicknameValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isInviteCodeValid: null == isInviteCodeValid
          ? _value.isInviteCodeValid
          : isInviteCodeValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserExists: null == isUserExists
          ? _value.isUserExists
          : isUserExists // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      thanksMessageId: null == thanksMessageId
          ? _value.thanksMessageId
          : thanksMessageId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      isPaymentPinValid: null == isPaymentPinValid
          ? _value.isPaymentPinValid
          : isPaymentPinValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SingleShotEvent?,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.email = "",
      this.code = "",
      this.nickname = "",
      this.inviteCode = "",
      this.sendCodeStatus = const NetworkState.initial(),
      this.verifyCodeStatus = const NetworkState.initial(),
      this.registerStatus = const NetworkState.initial(),
      this.isCodeValid = true,
      this.isNicknameValid = true,
      this.isInviteCodeValid = true,
      this.isEmailValid = true,
      this.isUserExists = false,
      this.isLoading = false,
      this.thanksMessageId = 0,
      this.paymentPin = "",
      this.isPaymentPinValid = true,
      this.isLoggedIn = false,
      this.event});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey()
  final String inviteCode;
  @override
  @JsonKey()
  final NetworkState<void> sendCodeStatus;
  @override
  @JsonKey()
  final NetworkState<void> verifyCodeStatus;
  @override
  @JsonKey()
  final NetworkState<void> registerStatus;
  @override
  @JsonKey()
  final bool isCodeValid;
  @override
  @JsonKey()
  final bool isNicknameValid;
  @override
  @JsonKey()
  final bool isInviteCodeValid;
  @override
  @JsonKey()
  final bool isEmailValid;
  @override
  @JsonKey()
  final bool isUserExists;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int thanksMessageId;
  @override
  @JsonKey()
  final String paymentPin;
  @override
  @JsonKey()
  final bool isPaymentPinValid;
  @override
  @JsonKey()
  final bool isLoggedIn;
  @override
  final SingleShotEvent? event;

  @override
  String toString() {
    return 'AuthState(email: $email, code: $code, nickname: $nickname, inviteCode: $inviteCode, sendCodeStatus: $sendCodeStatus, verifyCodeStatus: $verifyCodeStatus, registerStatus: $registerStatus, isCodeValid: $isCodeValid, isNicknameValid: $isNicknameValid, isInviteCodeValid: $isInviteCodeValid, isEmailValid: $isEmailValid, isUserExists: $isUserExists, isLoading: $isLoading, thanksMessageId: $thanksMessageId, paymentPin: $paymentPin, isPaymentPinValid: $isPaymentPinValid, isLoggedIn: $isLoggedIn, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.sendCodeStatus, sendCodeStatus) ||
                other.sendCodeStatus == sendCodeStatus) &&
            (identical(other.verifyCodeStatus, verifyCodeStatus) ||
                other.verifyCodeStatus == verifyCodeStatus) &&
            (identical(other.registerStatus, registerStatus) ||
                other.registerStatus == registerStatus) &&
            (identical(other.isCodeValid, isCodeValid) ||
                other.isCodeValid == isCodeValid) &&
            (identical(other.isNicknameValid, isNicknameValid) ||
                other.isNicknameValid == isNicknameValid) &&
            (identical(other.isInviteCodeValid, isInviteCodeValid) ||
                other.isInviteCodeValid == isInviteCodeValid) &&
            (identical(other.isEmailValid, isEmailValid) ||
                other.isEmailValid == isEmailValid) &&
            (identical(other.isUserExists, isUserExists) ||
                other.isUserExists == isUserExists) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.thanksMessageId, thanksMessageId) ||
                other.thanksMessageId == thanksMessageId) &&
            (identical(other.paymentPin, paymentPin) ||
                other.paymentPin == paymentPin) &&
            (identical(other.isPaymentPinValid, isPaymentPinValid) ||
                other.isPaymentPinValid == isPaymentPinValid) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      code,
      nickname,
      inviteCode,
      sendCodeStatus,
      verifyCodeStatus,
      registerStatus,
      isCodeValid,
      isNicknameValid,
      isInviteCodeValid,
      isEmailValid,
      isUserExists,
      isLoading,
      thanksMessageId,
      paymentPin,
      isPaymentPinValid,
      isLoggedIn,
      event);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final String email,
      final String code,
      final String nickname,
      final String inviteCode,
      final NetworkState<void> sendCodeStatus,
      final NetworkState<void> verifyCodeStatus,
      final NetworkState<void> registerStatus,
      final bool isCodeValid,
      final bool isNicknameValid,
      final bool isInviteCodeValid,
      final bool isEmailValid,
      final bool isUserExists,
      final bool isLoading,
      final int thanksMessageId,
      final String paymentPin,
      final bool isPaymentPinValid,
      final bool isLoggedIn,
      final SingleShotEvent? event}) = _$AuthStateImpl;

  @override
  String get email;
  @override
  String get code;
  @override
  String get nickname;
  @override
  String get inviteCode;
  @override
  NetworkState<void> get sendCodeStatus;
  @override
  NetworkState<void> get verifyCodeStatus;
  @override
  NetworkState<void> get registerStatus;
  @override
  bool get isCodeValid;
  @override
  bool get isNicknameValid;
  @override
  bool get isInviteCodeValid;
  @override
  bool get isEmailValid;
  @override
  bool get isUserExists;
  @override
  bool get isLoading;
  @override
  int get thanksMessageId;
  @override
  String get paymentPin;
  @override
  bool get isPaymentPinValid;
  @override
  bool get isLoggedIn;
  @override
  SingleShotEvent? get event;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
