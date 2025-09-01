// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransferStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStatusCopyWith<$Res> {
  factory $TransferStatusCopyWith(
          TransferStatus value, $Res Function(TransferStatus) then) =
      _$TransferStatusCopyWithImpl<$Res, TransferStatus>;
}

/// @nodoc
class _$TransferStatusCopyWithImpl<$Res, $Val extends TransferStatus>
    implements $TransferStatusCopyWith<$Res> {
  _$TransferStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TransferStatusCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'TransferStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TransferStatus {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TransferStatusCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'TransferStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TransferStatus {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferTransaction transaction});

  $TransferTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$TransferStatusCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$SuccessImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction,
    ));
  }

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferTransactionCopyWith<$Res> get transaction {
    return $TransferTransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.transaction);

  @override
  final TransferTransaction transaction;

  @override
  String toString() {
    return 'TransferStatus.success(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function() failure,
  }) {
    return success(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function()? failure,
  }) {
    return success?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements TransferStatus {
  const factory _Success(final TransferTransaction transaction) = _$SuccessImpl;

  TransferTransaction get transaction;

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$TransferStatusCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl();

  @override
  String toString() {
    return 'TransferStatus.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements TransferStatus {
  const factory _Failure() = _$FailureImpl;
}

/// @nodoc
mixin _$RiskChallenge {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskChallengeCopyWith<$Res> {
  factory $RiskChallengeCopyWith(
          RiskChallenge value, $Res Function(RiskChallenge) then) =
      _$RiskChallengeCopyWithImpl<$Res, RiskChallenge>;
}

/// @nodoc
class _$RiskChallengeCopyWithImpl<$Res, $Val extends RiskChallenge>
    implements $RiskChallengeCopyWith<$Res> {
  _$RiskChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RiskChallengeInitialImplCopyWith<$Res> {
  factory _$$RiskChallengeInitialImplCopyWith(_$RiskChallengeInitialImpl value,
          $Res Function(_$RiskChallengeInitialImpl) then) =
      __$$RiskChallengeInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RiskChallengeInitialImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeInitialImpl>
    implements _$$RiskChallengeInitialImplCopyWith<$Res> {
  __$$RiskChallengeInitialImplCopyWithImpl(_$RiskChallengeInitialImpl _value,
      $Res Function(_$RiskChallengeInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RiskChallengeInitialImpl implements _RiskChallengeInitial {
  const _$RiskChallengeInitialImpl();

  @override
  String toString() {
    return 'RiskChallenge.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeInitial implements RiskChallenge {
  const factory _RiskChallengeInitial() = _$RiskChallengeInitialImpl;
}

/// @nodoc
abstract class _$$RiskChallengeLoadingImplCopyWith<$Res> {
  factory _$$RiskChallengeLoadingImplCopyWith(_$RiskChallengeLoadingImpl value,
          $Res Function(_$RiskChallengeLoadingImpl) then) =
      __$$RiskChallengeLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RiskChallengeLoadingImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeLoadingImpl>
    implements _$$RiskChallengeLoadingImplCopyWith<$Res> {
  __$$RiskChallengeLoadingImplCopyWithImpl(_$RiskChallengeLoadingImpl _value,
      $Res Function(_$RiskChallengeLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RiskChallengeLoadingImpl implements _RiskChallengeLoading {
  const _$RiskChallengeLoadingImpl();

  @override
  String toString() {
    return 'RiskChallenge.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeLoading implements RiskChallenge {
  const factory _RiskChallengeLoading() = _$RiskChallengeLoadingImpl;
}

/// @nodoc
abstract class _$$RiskChallengeCaptchaImplCopyWith<$Res> {
  factory _$$RiskChallengeCaptchaImplCopyWith(_$RiskChallengeCaptchaImpl value,
          $Res Function(_$RiskChallengeCaptchaImpl) then) =
      __$$RiskChallengeCaptchaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Captcha? captcha});

  $CaptchaCopyWith<$Res>? get captcha;
}

/// @nodoc
class __$$RiskChallengeCaptchaImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeCaptchaImpl>
    implements _$$RiskChallengeCaptchaImplCopyWith<$Res> {
  __$$RiskChallengeCaptchaImplCopyWithImpl(_$RiskChallengeCaptchaImpl _value,
      $Res Function(_$RiskChallengeCaptchaImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? captcha = freezed,
  }) {
    return _then(_$RiskChallengeCaptchaImpl(
      freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as Captcha?,
    ));
  }

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaptchaCopyWith<$Res>? get captcha {
    if (_value.captcha == null) {
      return null;
    }

    return $CaptchaCopyWith<$Res>(_value.captcha!, (value) {
      return _then(_value.copyWith(captcha: value));
    });
  }
}

/// @nodoc

class _$RiskChallengeCaptchaImpl implements _RiskChallengeCaptcha {
  const _$RiskChallengeCaptchaImpl(this.captcha);

  @override
  final Captcha? captcha;

  @override
  String toString() {
    return 'RiskChallenge.captcha(captcha: $captcha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeCaptchaImpl &&
            (identical(other.captcha, captcha) || other.captcha == captcha));
  }

  @override
  int get hashCode => Object.hash(runtimeType, captcha);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskChallengeCaptchaImplCopyWith<_$RiskChallengeCaptchaImpl>
      get copyWith =>
          __$$RiskChallengeCaptchaImplCopyWithImpl<_$RiskChallengeCaptchaImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return captcha(this.captcha);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return captcha?.call(this.captcha);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (captcha != null) {
      return captcha(this.captcha);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return captcha(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return captcha?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (captcha != null) {
      return captcha(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeCaptcha implements RiskChallenge {
  const factory _RiskChallengeCaptcha(final Captcha? captcha) =
      _$RiskChallengeCaptchaImpl;

  Captcha? get captcha;

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskChallengeCaptchaImplCopyWith<_$RiskChallengeCaptchaImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RiskChallengeSmsImplCopyWith<$Res> {
  factory _$$RiskChallengeSmsImplCopyWith(_$RiskChallengeSmsImpl value,
          $Res Function(_$RiskChallengeSmsImpl) then) =
      __$$RiskChallengeSmsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Sms? sms});

  $SmsCopyWith<$Res>? get sms;
}

/// @nodoc
class __$$RiskChallengeSmsImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeSmsImpl>
    implements _$$RiskChallengeSmsImplCopyWith<$Res> {
  __$$RiskChallengeSmsImplCopyWithImpl(_$RiskChallengeSmsImpl _value,
      $Res Function(_$RiskChallengeSmsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sms = freezed,
  }) {
    return _then(_$RiskChallengeSmsImpl(
      freezed == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as Sms?,
    ));
  }

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmsCopyWith<$Res>? get sms {
    if (_value.sms == null) {
      return null;
    }

    return $SmsCopyWith<$Res>(_value.sms!, (value) {
      return _then(_value.copyWith(sms: value));
    });
  }
}

/// @nodoc

class _$RiskChallengeSmsImpl implements _RiskChallengeSms {
  const _$RiskChallengeSmsImpl(this.sms);

  @override
  final Sms? sms;

  @override
  String toString() {
    return 'RiskChallenge.sms(sms: $sms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeSmsImpl &&
            (identical(other.sms, sms) || other.sms == sms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sms);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskChallengeSmsImplCopyWith<_$RiskChallengeSmsImpl> get copyWith =>
      __$$RiskChallengeSmsImplCopyWithImpl<_$RiskChallengeSmsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return sms(this.sms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return sms?.call(this.sms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (sms != null) {
      return sms(this.sms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return sms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return sms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (sms != null) {
      return sms(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeSms implements RiskChallenge {
  const factory _RiskChallengeSms(final Sms? sms) = _$RiskChallengeSmsImpl;

  Sms? get sms;

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskChallengeSmsImplCopyWith<_$RiskChallengeSmsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RiskChallengeSuccessImplCopyWith<$Res> {
  factory _$$RiskChallengeSuccessImplCopyWith(_$RiskChallengeSuccessImpl value,
          $Res Function(_$RiskChallengeSuccessImpl) then) =
      __$$RiskChallengeSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RiskChallengeSuccessImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeSuccessImpl>
    implements _$$RiskChallengeSuccessImplCopyWith<$Res> {
  __$$RiskChallengeSuccessImplCopyWithImpl(_$RiskChallengeSuccessImpl _value,
      $Res Function(_$RiskChallengeSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RiskChallengeSuccessImpl implements _RiskChallengeSuccess {
  const _$RiskChallengeSuccessImpl();

  @override
  String toString() {
    return 'RiskChallenge.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeSuccess implements RiskChallenge {
  const factory _RiskChallengeSuccess() = _$RiskChallengeSuccessImpl;
}

/// @nodoc
abstract class _$$RiskChallengeFailureImplCopyWith<$Res> {
  factory _$$RiskChallengeFailureImplCopyWith(_$RiskChallengeFailureImpl value,
          $Res Function(_$RiskChallengeFailureImpl) then) =
      __$$RiskChallengeFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RiskChallengeFailureImplCopyWithImpl<$Res>
    extends _$RiskChallengeCopyWithImpl<$Res, _$RiskChallengeFailureImpl>
    implements _$$RiskChallengeFailureImplCopyWith<$Res> {
  __$$RiskChallengeFailureImplCopyWithImpl(_$RiskChallengeFailureImpl _value,
      $Res Function(_$RiskChallengeFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskChallenge
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RiskChallengeFailureImpl implements _RiskChallengeFailure {
  const _$RiskChallengeFailureImpl();

  @override
  String toString() {
    return 'RiskChallenge.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskChallengeFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Captcha? captcha) captcha,
    required TResult Function(Sms? sms) sms,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Captcha? captcha)? captcha,
    TResult? Function(Sms? sms)? sms,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Captcha? captcha)? captcha,
    TResult Function(Sms? sms)? sms,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RiskChallengeInitial value) initial,
    required TResult Function(_RiskChallengeLoading value) loading,
    required TResult Function(_RiskChallengeCaptcha value) captcha,
    required TResult Function(_RiskChallengeSms value) sms,
    required TResult Function(_RiskChallengeSuccess value) success,
    required TResult Function(_RiskChallengeFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RiskChallengeInitial value)? initial,
    TResult? Function(_RiskChallengeLoading value)? loading,
    TResult? Function(_RiskChallengeCaptcha value)? captcha,
    TResult? Function(_RiskChallengeSms value)? sms,
    TResult? Function(_RiskChallengeSuccess value)? success,
    TResult? Function(_RiskChallengeFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RiskChallengeInitial value)? initial,
    TResult Function(_RiskChallengeLoading value)? loading,
    TResult Function(_RiskChallengeCaptcha value)? captcha,
    TResult Function(_RiskChallengeSms value)? sms,
    TResult Function(_RiskChallengeSuccess value)? success,
    TResult Function(_RiskChallengeFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _RiskChallengeFailure implements RiskChallenge {
  const factory _RiskChallengeFailure() = _$RiskChallengeFailureImpl;
}

/// @nodoc
mixin _$TransferState {
  String get tokenAddress => throw _privateConstructorUsedError;
  int get chainId => throw _privateConstructorUsedError;
  String get toAddress => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  Gas? get gas => throw _privateConstructorUsedError;
  EtherAmount? get calculatedGas => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  bool get gasError => throw _privateConstructorUsedError;
  bool get addressError => throw _privateConstructorUsedError;
  bool get amountError => throw _privateConstructorUsedError;
  bool get loadingGas => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isSent => throw _privateConstructorUsedError;
  bool get isFailed => throw _privateConstructorUsedError;
  String get failedReason => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  Token? get selectedToken => throw _privateConstructorUsedError;
  TransferStatus get transferStatus =>
      throw _privateConstructorUsedError; // 转出的发送状态
  RiskChallenge get riskChallenge => throw _privateConstructorUsedError;
  String get paymentPin => throw _privateConstructorUsedError;
  TransferTransaction? get transaction =>
      throw _privateConstructorUsedError; // 不要直接在这里初始化 TextEditingController
  TextEditingController get toAddressController =>
      throw _privateConstructorUsedError;
  TextEditingController get amountController =>
      throw _privateConstructorUsedError;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferStateCopyWith<TransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
          TransferState value, $Res Function(TransferState) then) =
      _$TransferStateCopyWithImpl<$Res, TransferState>;
  @useResult
  $Res call(
      {String tokenAddress,
      int chainId,
      String toAddress,
      String amount,
      Gas? gas,
      EtherAmount? calculatedGas,
      int decimals,
      bool gasError,
      bool addressError,
      bool amountError,
      bool loadingGas,
      bool isSending,
      bool isSent,
      bool isFailed,
      String failedReason,
      bool isSuccess,
      Token? selectedToken,
      TransferStatus transferStatus,
      RiskChallenge riskChallenge,
      String paymentPin,
      TransferTransaction? transaction,
      TextEditingController toAddressController,
      TextEditingController amountController});

  $GasCopyWith<$Res>? get gas;
  $TokenCopyWith<$Res>? get selectedToken;
  $TransferStatusCopyWith<$Res> get transferStatus;
  $RiskChallengeCopyWith<$Res> get riskChallenge;
  $TransferTransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? chainId = null,
    Object? toAddress = null,
    Object? amount = null,
    Object? gas = freezed,
    Object? calculatedGas = freezed,
    Object? decimals = null,
    Object? gasError = null,
    Object? addressError = null,
    Object? amountError = null,
    Object? loadingGas = null,
    Object? isSending = null,
    Object? isSent = null,
    Object? isFailed = null,
    Object? failedReason = null,
    Object? isSuccess = null,
    Object? selectedToken = freezed,
    Object? transferStatus = null,
    Object? riskChallenge = null,
    Object? paymentPin = null,
    Object? transaction = freezed,
    Object? toAddressController = null,
    Object? amountController = null,
  }) {
    return _then(_value.copyWith(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      toAddress: null == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      gas: freezed == gas
          ? _value.gas
          : gas // ignore: cast_nullable_to_non_nullable
              as Gas?,
      calculatedGas: freezed == calculatedGas
          ? _value.calculatedGas
          : calculatedGas // ignore: cast_nullable_to_non_nullable
              as EtherAmount?,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      gasError: null == gasError
          ? _value.gasError
          : gasError // ignore: cast_nullable_to_non_nullable
              as bool,
      addressError: null == addressError
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as bool,
      amountError: null == amountError
          ? _value.amountError
          : amountError // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingGas: null == loadingGas
          ? _value.loadingGas
          : loadingGas // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isFailed: null == isFailed
          ? _value.isFailed
          : isFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      failedReason: null == failedReason
          ? _value.failedReason
          : failedReason // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      transferStatus: null == transferStatus
          ? _value.transferStatus
          : transferStatus // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      riskChallenge: null == riskChallenge
          ? _value.riskChallenge
          : riskChallenge // ignore: cast_nullable_to_non_nullable
              as RiskChallenge,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction?,
      toAddressController: null == toAddressController
          ? _value.toAddressController
          : toAddressController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      amountController: null == amountController
          ? _value.amountController
          : amountController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ) as $Val);
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasCopyWith<$Res>? get gas {
    if (_value.gas == null) {
      return null;
    }

    return $GasCopyWith<$Res>(_value.gas!, (value) {
      return _then(_value.copyWith(gas: value) as $Val);
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res>? get selectedToken {
    if (_value.selectedToken == null) {
      return null;
    }

    return $TokenCopyWith<$Res>(_value.selectedToken!, (value) {
      return _then(_value.copyWith(selectedToken: value) as $Val);
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferStatusCopyWith<$Res> get transferStatus {
    return $TransferStatusCopyWith<$Res>(_value.transferStatus, (value) {
      return _then(_value.copyWith(transferStatus: value) as $Val);
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskChallengeCopyWith<$Res> get riskChallenge {
    return $RiskChallengeCopyWith<$Res>(_value.riskChallenge, (value) {
      return _then(_value.copyWith(riskChallenge: value) as $Val);
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferTransactionCopyWith<$Res>? get transaction {
    if (_value.transaction == null) {
      return null;
    }

    return $TransferTransactionCopyWith<$Res>(_value.transaction!, (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransferStateImplCopyWith<$Res>
    implements $TransferStateCopyWith<$Res> {
  factory _$$TransferStateImplCopyWith(
          _$TransferStateImpl value, $Res Function(_$TransferStateImpl) then) =
      __$$TransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tokenAddress,
      int chainId,
      String toAddress,
      String amount,
      Gas? gas,
      EtherAmount? calculatedGas,
      int decimals,
      bool gasError,
      bool addressError,
      bool amountError,
      bool loadingGas,
      bool isSending,
      bool isSent,
      bool isFailed,
      String failedReason,
      bool isSuccess,
      Token? selectedToken,
      TransferStatus transferStatus,
      RiskChallenge riskChallenge,
      String paymentPin,
      TransferTransaction? transaction,
      TextEditingController toAddressController,
      TextEditingController amountController});

  @override
  $GasCopyWith<$Res>? get gas;
  @override
  $TokenCopyWith<$Res>? get selectedToken;
  @override
  $TransferStatusCopyWith<$Res> get transferStatus;
  @override
  $RiskChallengeCopyWith<$Res> get riskChallenge;
  @override
  $TransferTransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class __$$TransferStateImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateImpl>
    implements _$$TransferStateImplCopyWith<$Res> {
  __$$TransferStateImplCopyWithImpl(
      _$TransferStateImpl _value, $Res Function(_$TransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? chainId = null,
    Object? toAddress = null,
    Object? amount = null,
    Object? gas = freezed,
    Object? calculatedGas = freezed,
    Object? decimals = null,
    Object? gasError = null,
    Object? addressError = null,
    Object? amountError = null,
    Object? loadingGas = null,
    Object? isSending = null,
    Object? isSent = null,
    Object? isFailed = null,
    Object? failedReason = null,
    Object? isSuccess = null,
    Object? selectedToken = freezed,
    Object? transferStatus = null,
    Object? riskChallenge = null,
    Object? paymentPin = null,
    Object? transaction = freezed,
    Object? toAddressController = null,
    Object? amountController = null,
  }) {
    return _then(_$TransferStateImpl(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      toAddress: null == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      gas: freezed == gas
          ? _value.gas
          : gas // ignore: cast_nullable_to_non_nullable
              as Gas?,
      calculatedGas: freezed == calculatedGas
          ? _value.calculatedGas
          : calculatedGas // ignore: cast_nullable_to_non_nullable
              as EtherAmount?,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      gasError: null == gasError
          ? _value.gasError
          : gasError // ignore: cast_nullable_to_non_nullable
              as bool,
      addressError: null == addressError
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as bool,
      amountError: null == amountError
          ? _value.amountError
          : amountError // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingGas: null == loadingGas
          ? _value.loadingGas
          : loadingGas // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isFailed: null == isFailed
          ? _value.isFailed
          : isFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      failedReason: null == failedReason
          ? _value.failedReason
          : failedReason // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      transferStatus: null == transferStatus
          ? _value.transferStatus
          : transferStatus // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      riskChallenge: null == riskChallenge
          ? _value.riskChallenge
          : riskChallenge // ignore: cast_nullable_to_non_nullable
              as RiskChallenge,
      paymentPin: null == paymentPin
          ? _value.paymentPin
          : paymentPin // ignore: cast_nullable_to_non_nullable
              as String,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction?,
      toAddressController: null == toAddressController
          ? _value.toAddressController
          : toAddressController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      amountController: null == amountController
          ? _value.amountController
          : amountController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$TransferStateImpl implements _TransferState {
  const _$TransferStateImpl(
      {this.tokenAddress = '',
      this.chainId = 0,
      this.toAddress = '',
      this.amount = '',
      this.gas = null,
      this.calculatedGas = null,
      this.decimals = 18,
      this.gasError = false,
      this.addressError = false,
      this.amountError = false,
      this.loadingGas = false,
      this.isSending = false,
      this.isSent = false,
      this.isFailed = false,
      this.failedReason = '',
      this.isSuccess = false,
      this.selectedToken = null,
      this.transferStatus = const TransferStatus.initial(),
      this.riskChallenge = const RiskChallenge.initial(),
      this.paymentPin = "",
      this.transaction,
      required this.toAddressController,
      required this.amountController});

  @override
  @JsonKey()
  final String tokenAddress;
  @override
  @JsonKey()
  final int chainId;
  @override
  @JsonKey()
  final String toAddress;
  @override
  @JsonKey()
  final String amount;
  @override
  @JsonKey()
  final Gas? gas;
  @override
  @JsonKey()
  final EtherAmount? calculatedGas;
  @override
  @JsonKey()
  final int decimals;
  @override
  @JsonKey()
  final bool gasError;
  @override
  @JsonKey()
  final bool addressError;
  @override
  @JsonKey()
  final bool amountError;
  @override
  @JsonKey()
  final bool loadingGas;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isSent;
  @override
  @JsonKey()
  final bool isFailed;
  @override
  @JsonKey()
  final String failedReason;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final Token? selectedToken;
  @override
  @JsonKey()
  final TransferStatus transferStatus;
// 转出的发送状态
  @override
  @JsonKey()
  final RiskChallenge riskChallenge;
  @override
  @JsonKey()
  final String paymentPin;
  @override
  final TransferTransaction? transaction;
// 不要直接在这里初始化 TextEditingController
  @override
  final TextEditingController toAddressController;
  @override
  final TextEditingController amountController;

  @override
  String toString() {
    return 'TransferState(tokenAddress: $tokenAddress, chainId: $chainId, toAddress: $toAddress, amount: $amount, gas: $gas, calculatedGas: $calculatedGas, decimals: $decimals, gasError: $gasError, addressError: $addressError, amountError: $amountError, loadingGas: $loadingGas, isSending: $isSending, isSent: $isSent, isFailed: $isFailed, failedReason: $failedReason, isSuccess: $isSuccess, selectedToken: $selectedToken, transferStatus: $transferStatus, riskChallenge: $riskChallenge, paymentPin: $paymentPin, transaction: $transaction, toAddressController: $toAddressController, amountController: $amountController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateImpl &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.toAddress, toAddress) ||
                other.toAddress == toAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.gas, gas) || other.gas == gas) &&
            (identical(other.calculatedGas, calculatedGas) ||
                other.calculatedGas == calculatedGas) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.gasError, gasError) ||
                other.gasError == gasError) &&
            (identical(other.addressError, addressError) ||
                other.addressError == addressError) &&
            (identical(other.amountError, amountError) ||
                other.amountError == amountError) &&
            (identical(other.loadingGas, loadingGas) ||
                other.loadingGas == loadingGas) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.isFailed, isFailed) ||
                other.isFailed == isFailed) &&
            (identical(other.failedReason, failedReason) ||
                other.failedReason == failedReason) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.selectedToken, selectedToken) ||
                other.selectedToken == selectedToken) &&
            (identical(other.transferStatus, transferStatus) ||
                other.transferStatus == transferStatus) &&
            (identical(other.riskChallenge, riskChallenge) ||
                other.riskChallenge == riskChallenge) &&
            (identical(other.paymentPin, paymentPin) ||
                other.paymentPin == paymentPin) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.toAddressController, toAddressController) ||
                other.toAddressController == toAddressController) &&
            (identical(other.amountController, amountController) ||
                other.amountController == amountController));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        tokenAddress,
        chainId,
        toAddress,
        amount,
        gas,
        calculatedGas,
        decimals,
        gasError,
        addressError,
        amountError,
        loadingGas,
        isSending,
        isSent,
        isFailed,
        failedReason,
        isSuccess,
        selectedToken,
        transferStatus,
        riskChallenge,
        paymentPin,
        transaction,
        toAddressController,
        amountController
      ]);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      __$$TransferStateImplCopyWithImpl<_$TransferStateImpl>(this, _$identity);
}

abstract class _TransferState implements TransferState {
  const factory _TransferState(
          {final String tokenAddress,
          final int chainId,
          final String toAddress,
          final String amount,
          final Gas? gas,
          final EtherAmount? calculatedGas,
          final int decimals,
          final bool gasError,
          final bool addressError,
          final bool amountError,
          final bool loadingGas,
          final bool isSending,
          final bool isSent,
          final bool isFailed,
          final String failedReason,
          final bool isSuccess,
          final Token? selectedToken,
          final TransferStatus transferStatus,
          final RiskChallenge riskChallenge,
          final String paymentPin,
          final TransferTransaction? transaction,
          required final TextEditingController toAddressController,
          required final TextEditingController amountController}) =
      _$TransferStateImpl;

  @override
  String get tokenAddress;
  @override
  int get chainId;
  @override
  String get toAddress;
  @override
  String get amount;
  @override
  Gas? get gas;
  @override
  EtherAmount? get calculatedGas;
  @override
  int get decimals;
  @override
  bool get gasError;
  @override
  bool get addressError;
  @override
  bool get amountError;
  @override
  bool get loadingGas;
  @override
  bool get isSending;
  @override
  bool get isSent;
  @override
  bool get isFailed;
  @override
  String get failedReason;
  @override
  bool get isSuccess;
  @override
  Token? get selectedToken;
  @override
  TransferStatus get transferStatus; // 转出的发送状态
  @override
  RiskChallenge get riskChallenge;
  @override
  String get paymentPin;
  @override
  TransferTransaction? get transaction; // 不要直接在这里初始化 TextEditingController
  @override
  TextEditingController get toAddressController;
  @override
  TextEditingController get amountController;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
