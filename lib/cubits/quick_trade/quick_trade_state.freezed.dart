// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_trade_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BuyTokenStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(BuyTokenFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(BuyTokenFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(BuyTokenFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BuyTokenInitial value) initial,
    required TResult Function(_BuyTokenLoading value) loading,
    required TResult Function(_BuyTokenSuccess value) success,
    required TResult Function(_BuyTokenFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BuyTokenInitial value)? initial,
    TResult? Function(_BuyTokenLoading value)? loading,
    TResult? Function(_BuyTokenSuccess value)? success,
    TResult? Function(_BuyTokenFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BuyTokenInitial value)? initial,
    TResult Function(_BuyTokenLoading value)? loading,
    TResult Function(_BuyTokenSuccess value)? success,
    TResult Function(_BuyTokenFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyTokenStatusCopyWith<$Res> {
  factory $BuyTokenStatusCopyWith(
          BuyTokenStatus value, $Res Function(BuyTokenStatus) then) =
      _$BuyTokenStatusCopyWithImpl<$Res, BuyTokenStatus>;
}

/// @nodoc
class _$BuyTokenStatusCopyWithImpl<$Res, $Val extends BuyTokenStatus>
    implements $BuyTokenStatusCopyWith<$Res> {
  _$BuyTokenStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BuyTokenInitialImplCopyWith<$Res> {
  factory _$$BuyTokenInitialImplCopyWith(_$BuyTokenInitialImpl value,
          $Res Function(_$BuyTokenInitialImpl) then) =
      __$$BuyTokenInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BuyTokenInitialImplCopyWithImpl<$Res>
    extends _$BuyTokenStatusCopyWithImpl<$Res, _$BuyTokenInitialImpl>
    implements _$$BuyTokenInitialImplCopyWith<$Res> {
  __$$BuyTokenInitialImplCopyWithImpl(
      _$BuyTokenInitialImpl _value, $Res Function(_$BuyTokenInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BuyTokenInitialImpl extends _BuyTokenInitial {
  const _$BuyTokenInitialImpl() : super._();

  @override
  String toString() {
    return 'BuyTokenStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BuyTokenInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(BuyTokenFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(BuyTokenFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(BuyTokenFailure failure)? failure,
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
    required TResult Function(_BuyTokenInitial value) initial,
    required TResult Function(_BuyTokenLoading value) loading,
    required TResult Function(_BuyTokenSuccess value) success,
    required TResult Function(_BuyTokenFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BuyTokenInitial value)? initial,
    TResult? Function(_BuyTokenLoading value)? loading,
    TResult? Function(_BuyTokenSuccess value)? success,
    TResult? Function(_BuyTokenFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BuyTokenInitial value)? initial,
    TResult Function(_BuyTokenLoading value)? loading,
    TResult Function(_BuyTokenSuccess value)? success,
    TResult Function(_BuyTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _BuyTokenInitial extends BuyTokenStatus {
  const factory _BuyTokenInitial() = _$BuyTokenInitialImpl;
  const _BuyTokenInitial._() : super._();
}

/// @nodoc
abstract class _$$BuyTokenLoadingImplCopyWith<$Res> {
  factory _$$BuyTokenLoadingImplCopyWith(_$BuyTokenLoadingImpl value,
          $Res Function(_$BuyTokenLoadingImpl) then) =
      __$$BuyTokenLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BuyTokenLoadingImplCopyWithImpl<$Res>
    extends _$BuyTokenStatusCopyWithImpl<$Res, _$BuyTokenLoadingImpl>
    implements _$$BuyTokenLoadingImplCopyWith<$Res> {
  __$$BuyTokenLoadingImplCopyWithImpl(
      _$BuyTokenLoadingImpl _value, $Res Function(_$BuyTokenLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BuyTokenLoadingImpl extends _BuyTokenLoading {
  const _$BuyTokenLoadingImpl() : super._();

  @override
  String toString() {
    return 'BuyTokenStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BuyTokenLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(BuyTokenFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(BuyTokenFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(BuyTokenFailure failure)? failure,
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
    required TResult Function(_BuyTokenInitial value) initial,
    required TResult Function(_BuyTokenLoading value) loading,
    required TResult Function(_BuyTokenSuccess value) success,
    required TResult Function(_BuyTokenFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BuyTokenInitial value)? initial,
    TResult? Function(_BuyTokenLoading value)? loading,
    TResult? Function(_BuyTokenSuccess value)? success,
    TResult? Function(_BuyTokenFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BuyTokenInitial value)? initial,
    TResult Function(_BuyTokenLoading value)? loading,
    TResult Function(_BuyTokenSuccess value)? success,
    TResult Function(_BuyTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _BuyTokenLoading extends BuyTokenStatus {
  const factory _BuyTokenLoading() = _$BuyTokenLoadingImpl;
  const _BuyTokenLoading._() : super._();
}

/// @nodoc
abstract class _$$BuyTokenSuccessImplCopyWith<$Res> {
  factory _$$BuyTokenSuccessImplCopyWith(_$BuyTokenSuccessImpl value,
          $Res Function(_$BuyTokenSuccessImpl) then) =
      __$$BuyTokenSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferTransaction transaction});

  $TransferTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$BuyTokenSuccessImplCopyWithImpl<$Res>
    extends _$BuyTokenStatusCopyWithImpl<$Res, _$BuyTokenSuccessImpl>
    implements _$$BuyTokenSuccessImplCopyWith<$Res> {
  __$$BuyTokenSuccessImplCopyWithImpl(
      _$BuyTokenSuccessImpl _value, $Res Function(_$BuyTokenSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$BuyTokenSuccessImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction,
    ));
  }

  /// Create a copy of BuyTokenStatus
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

class _$BuyTokenSuccessImpl extends _BuyTokenSuccess {
  const _$BuyTokenSuccessImpl(this.transaction) : super._();

  @override
  final TransferTransaction transaction;

  @override
  String toString() {
    return 'BuyTokenStatus.success(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyTokenSuccessImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyTokenSuccessImplCopyWith<_$BuyTokenSuccessImpl> get copyWith =>
      __$$BuyTokenSuccessImplCopyWithImpl<_$BuyTokenSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(BuyTokenFailure failure) failure,
  }) {
    return success(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(BuyTokenFailure failure)? failure,
  }) {
    return success?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(BuyTokenFailure failure)? failure,
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
    required TResult Function(_BuyTokenInitial value) initial,
    required TResult Function(_BuyTokenLoading value) loading,
    required TResult Function(_BuyTokenSuccess value) success,
    required TResult Function(_BuyTokenFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BuyTokenInitial value)? initial,
    TResult? Function(_BuyTokenLoading value)? loading,
    TResult? Function(_BuyTokenSuccess value)? success,
    TResult? Function(_BuyTokenFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BuyTokenInitial value)? initial,
    TResult Function(_BuyTokenLoading value)? loading,
    TResult Function(_BuyTokenSuccess value)? success,
    TResult Function(_BuyTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _BuyTokenSuccess extends BuyTokenStatus {
  const factory _BuyTokenSuccess(final TransferTransaction transaction) =
      _$BuyTokenSuccessImpl;
  const _BuyTokenSuccess._() : super._();

  TransferTransaction get transaction;

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyTokenSuccessImplCopyWith<_$BuyTokenSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BuyTokenFailureImplCopyWith<$Res> {
  factory _$$BuyTokenFailureImplCopyWith(_$BuyTokenFailureImpl value,
          $Res Function(_$BuyTokenFailureImpl) then) =
      __$$BuyTokenFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuyTokenFailure failure});
}

/// @nodoc
class __$$BuyTokenFailureImplCopyWithImpl<$Res>
    extends _$BuyTokenStatusCopyWithImpl<$Res, _$BuyTokenFailureImpl>
    implements _$$BuyTokenFailureImplCopyWith<$Res> {
  __$$BuyTokenFailureImplCopyWithImpl(
      _$BuyTokenFailureImpl _value, $Res Function(_$BuyTokenFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$BuyTokenFailureImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as BuyTokenFailure,
    ));
  }
}

/// @nodoc

class _$BuyTokenFailureImpl extends _BuyTokenFailure {
  const _$BuyTokenFailureImpl(this.failure) : super._();

  @override
  final BuyTokenFailure failure;

  @override
  String toString() {
    return 'BuyTokenStatus.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyTokenFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyTokenFailureImplCopyWith<_$BuyTokenFailureImpl> get copyWith =>
      __$$BuyTokenFailureImplCopyWithImpl<_$BuyTokenFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(BuyTokenFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(BuyTokenFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(BuyTokenFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BuyTokenInitial value) initial,
    required TResult Function(_BuyTokenLoading value) loading,
    required TResult Function(_BuyTokenSuccess value) success,
    required TResult Function(_BuyTokenFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BuyTokenInitial value)? initial,
    TResult? Function(_BuyTokenLoading value)? loading,
    TResult? Function(_BuyTokenSuccess value)? success,
    TResult? Function(_BuyTokenFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BuyTokenInitial value)? initial,
    TResult Function(_BuyTokenLoading value)? loading,
    TResult Function(_BuyTokenSuccess value)? success,
    TResult Function(_BuyTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _BuyTokenFailure extends BuyTokenStatus {
  const factory _BuyTokenFailure(final BuyTokenFailure failure) =
      _$BuyTokenFailureImpl;
  const _BuyTokenFailure._() : super._();

  BuyTokenFailure get failure;

  /// Create a copy of BuyTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyTokenFailureImplCopyWith<_$BuyTokenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SellTokenStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(SellTokenFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(SellTokenFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(SellTokenFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SellTokenInitial value) initial,
    required TResult Function(_SellTokenLoading value) loading,
    required TResult Function(_SellTokenSuccess value) success,
    required TResult Function(_SellTokenFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SellTokenInitial value)? initial,
    TResult? Function(_SellTokenLoading value)? loading,
    TResult? Function(_SellTokenSuccess value)? success,
    TResult? Function(_SellTokenFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SellTokenInitial value)? initial,
    TResult Function(_SellTokenLoading value)? loading,
    TResult Function(_SellTokenSuccess value)? success,
    TResult Function(_SellTokenFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellTokenStatusCopyWith<$Res> {
  factory $SellTokenStatusCopyWith(
          SellTokenStatus value, $Res Function(SellTokenStatus) then) =
      _$SellTokenStatusCopyWithImpl<$Res, SellTokenStatus>;
}

/// @nodoc
class _$SellTokenStatusCopyWithImpl<$Res, $Val extends SellTokenStatus>
    implements $SellTokenStatusCopyWith<$Res> {
  _$SellTokenStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SellTokenInitialImplCopyWith<$Res> {
  factory _$$SellTokenInitialImplCopyWith(_$SellTokenInitialImpl value,
          $Res Function(_$SellTokenInitialImpl) then) =
      __$$SellTokenInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellTokenInitialImplCopyWithImpl<$Res>
    extends _$SellTokenStatusCopyWithImpl<$Res, _$SellTokenInitialImpl>
    implements _$$SellTokenInitialImplCopyWith<$Res> {
  __$$SellTokenInitialImplCopyWithImpl(_$SellTokenInitialImpl _value,
      $Res Function(_$SellTokenInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SellTokenInitialImpl extends _SellTokenInitial {
  const _$SellTokenInitialImpl() : super._();

  @override
  String toString() {
    return 'SellTokenStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SellTokenInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(SellTokenFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(SellTokenFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(SellTokenFailure failure)? failure,
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
    required TResult Function(_SellTokenInitial value) initial,
    required TResult Function(_SellTokenLoading value) loading,
    required TResult Function(_SellTokenSuccess value) success,
    required TResult Function(_SellTokenFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SellTokenInitial value)? initial,
    TResult? Function(_SellTokenLoading value)? loading,
    TResult? Function(_SellTokenSuccess value)? success,
    TResult? Function(_SellTokenFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SellTokenInitial value)? initial,
    TResult Function(_SellTokenLoading value)? loading,
    TResult Function(_SellTokenSuccess value)? success,
    TResult Function(_SellTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _SellTokenInitial extends SellTokenStatus {
  const factory _SellTokenInitial() = _$SellTokenInitialImpl;
  const _SellTokenInitial._() : super._();
}

/// @nodoc
abstract class _$$SellTokenLoadingImplCopyWith<$Res> {
  factory _$$SellTokenLoadingImplCopyWith(_$SellTokenLoadingImpl value,
          $Res Function(_$SellTokenLoadingImpl) then) =
      __$$SellTokenLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellTokenLoadingImplCopyWithImpl<$Res>
    extends _$SellTokenStatusCopyWithImpl<$Res, _$SellTokenLoadingImpl>
    implements _$$SellTokenLoadingImplCopyWith<$Res> {
  __$$SellTokenLoadingImplCopyWithImpl(_$SellTokenLoadingImpl _value,
      $Res Function(_$SellTokenLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SellTokenLoadingImpl extends _SellTokenLoading {
  const _$SellTokenLoadingImpl() : super._();

  @override
  String toString() {
    return 'SellTokenStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SellTokenLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(SellTokenFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(SellTokenFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(SellTokenFailure failure)? failure,
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
    required TResult Function(_SellTokenInitial value) initial,
    required TResult Function(_SellTokenLoading value) loading,
    required TResult Function(_SellTokenSuccess value) success,
    required TResult Function(_SellTokenFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SellTokenInitial value)? initial,
    TResult? Function(_SellTokenLoading value)? loading,
    TResult? Function(_SellTokenSuccess value)? success,
    TResult? Function(_SellTokenFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SellTokenInitial value)? initial,
    TResult Function(_SellTokenLoading value)? loading,
    TResult Function(_SellTokenSuccess value)? success,
    TResult Function(_SellTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _SellTokenLoading extends SellTokenStatus {
  const factory _SellTokenLoading() = _$SellTokenLoadingImpl;
  const _SellTokenLoading._() : super._();
}

/// @nodoc
abstract class _$$SellTokenSuccessImplCopyWith<$Res> {
  factory _$$SellTokenSuccessImplCopyWith(_$SellTokenSuccessImpl value,
          $Res Function(_$SellTokenSuccessImpl) then) =
      __$$SellTokenSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferTransaction transaction});

  $TransferTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$SellTokenSuccessImplCopyWithImpl<$Res>
    extends _$SellTokenStatusCopyWithImpl<$Res, _$SellTokenSuccessImpl>
    implements _$$SellTokenSuccessImplCopyWith<$Res> {
  __$$SellTokenSuccessImplCopyWithImpl(_$SellTokenSuccessImpl _value,
      $Res Function(_$SellTokenSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$SellTokenSuccessImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction,
    ));
  }

  /// Create a copy of SellTokenStatus
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

class _$SellTokenSuccessImpl extends _SellTokenSuccess {
  const _$SellTokenSuccessImpl(this.transaction) : super._();

  @override
  final TransferTransaction transaction;

  @override
  String toString() {
    return 'SellTokenStatus.success(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellTokenSuccessImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SellTokenSuccessImplCopyWith<_$SellTokenSuccessImpl> get copyWith =>
      __$$SellTokenSuccessImplCopyWithImpl<_$SellTokenSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(SellTokenFailure failure) failure,
  }) {
    return success(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(SellTokenFailure failure)? failure,
  }) {
    return success?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(SellTokenFailure failure)? failure,
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
    required TResult Function(_SellTokenInitial value) initial,
    required TResult Function(_SellTokenLoading value) loading,
    required TResult Function(_SellTokenSuccess value) success,
    required TResult Function(_SellTokenFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SellTokenInitial value)? initial,
    TResult? Function(_SellTokenLoading value)? loading,
    TResult? Function(_SellTokenSuccess value)? success,
    TResult? Function(_SellTokenFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SellTokenInitial value)? initial,
    TResult Function(_SellTokenLoading value)? loading,
    TResult Function(_SellTokenSuccess value)? success,
    TResult Function(_SellTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SellTokenSuccess extends SellTokenStatus {
  const factory _SellTokenSuccess(final TransferTransaction transaction) =
      _$SellTokenSuccessImpl;
  const _SellTokenSuccess._() : super._();

  TransferTransaction get transaction;

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SellTokenSuccessImplCopyWith<_$SellTokenSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SellTokenFailureImplCopyWith<$Res> {
  factory _$$SellTokenFailureImplCopyWith(_$SellTokenFailureImpl value,
          $Res Function(_$SellTokenFailureImpl) then) =
      __$$SellTokenFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SellTokenFailure failure});
}

/// @nodoc
class __$$SellTokenFailureImplCopyWithImpl<$Res>
    extends _$SellTokenStatusCopyWithImpl<$Res, _$SellTokenFailureImpl>
    implements _$$SellTokenFailureImplCopyWith<$Res> {
  __$$SellTokenFailureImplCopyWithImpl(_$SellTokenFailureImpl _value,
      $Res Function(_$SellTokenFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$SellTokenFailureImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as SellTokenFailure,
    ));
  }
}

/// @nodoc

class _$SellTokenFailureImpl extends _SellTokenFailure {
  const _$SellTokenFailureImpl(this.failure) : super._();

  @override
  final SellTokenFailure failure;

  @override
  String toString() {
    return 'SellTokenStatus.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellTokenFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SellTokenFailureImplCopyWith<_$SellTokenFailureImpl> get copyWith =>
      __$$SellTokenFailureImplCopyWithImpl<_$SellTokenFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(SellTokenFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(SellTokenFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(SellTokenFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SellTokenInitial value) initial,
    required TResult Function(_SellTokenLoading value) loading,
    required TResult Function(_SellTokenSuccess value) success,
    required TResult Function(_SellTokenFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SellTokenInitial value)? initial,
    TResult? Function(_SellTokenLoading value)? loading,
    TResult? Function(_SellTokenSuccess value)? success,
    TResult? Function(_SellTokenFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SellTokenInitial value)? initial,
    TResult Function(_SellTokenLoading value)? loading,
    TResult Function(_SellTokenSuccess value)? success,
    TResult Function(_SellTokenFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _SellTokenFailure extends SellTokenStatus {
  const factory _SellTokenFailure(final SellTokenFailure failure) =
      _$SellTokenFailureImpl;
  const _SellTokenFailure._() : super._();

  SellTokenFailure get failure;

  /// Create a copy of SellTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SellTokenFailureImplCopyWith<_$SellTokenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuickTradeState {
  BuyTokenStatus get buyTokenStatus => throw _privateConstructorUsedError;
  SellTokenStatus get sellTokenStatus => throw _privateConstructorUsedError;
  Token? get fromToken =>
      throw _privateConstructorUsedError; // @Default(null) Token? toToken,
  Token? get selectedToken => throw _privateConstructorUsedError;
  String get buyAmount => throw _privateConstructorUsedError;
  String get sellPercent => throw _privateConstructorUsedError;
  QuickTradeMode get mode => throw _privateConstructorUsedError;

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickTradeStateCopyWith<QuickTradeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickTradeStateCopyWith<$Res> {
  factory $QuickTradeStateCopyWith(
          QuickTradeState value, $Res Function(QuickTradeState) then) =
      _$QuickTradeStateCopyWithImpl<$Res, QuickTradeState>;
  @useResult
  $Res call(
      {BuyTokenStatus buyTokenStatus,
      SellTokenStatus sellTokenStatus,
      Token? fromToken,
      Token? selectedToken,
      String buyAmount,
      String sellPercent,
      QuickTradeMode mode});

  $BuyTokenStatusCopyWith<$Res> get buyTokenStatus;
  $SellTokenStatusCopyWith<$Res> get sellTokenStatus;
  $TokenCopyWith<$Res>? get fromToken;
  $TokenCopyWith<$Res>? get selectedToken;
}

/// @nodoc
class _$QuickTradeStateCopyWithImpl<$Res, $Val extends QuickTradeState>
    implements $QuickTradeStateCopyWith<$Res> {
  _$QuickTradeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buyTokenStatus = null,
    Object? sellTokenStatus = null,
    Object? fromToken = freezed,
    Object? selectedToken = freezed,
    Object? buyAmount = null,
    Object? sellPercent = null,
    Object? mode = null,
  }) {
    return _then(_value.copyWith(
      buyTokenStatus: null == buyTokenStatus
          ? _value.buyTokenStatus
          : buyTokenStatus // ignore: cast_nullable_to_non_nullable
              as BuyTokenStatus,
      sellTokenStatus: null == sellTokenStatus
          ? _value.sellTokenStatus
          : sellTokenStatus // ignore: cast_nullable_to_non_nullable
              as SellTokenStatus,
      fromToken: freezed == fromToken
          ? _value.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      buyAmount: null == buyAmount
          ? _value.buyAmount
          : buyAmount // ignore: cast_nullable_to_non_nullable
              as String,
      sellPercent: null == sellPercent
          ? _value.sellPercent
          : sellPercent // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as QuickTradeMode,
    ) as $Val);
  }

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BuyTokenStatusCopyWith<$Res> get buyTokenStatus {
    return $BuyTokenStatusCopyWith<$Res>(_value.buyTokenStatus, (value) {
      return _then(_value.copyWith(buyTokenStatus: value) as $Val);
    });
  }

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SellTokenStatusCopyWith<$Res> get sellTokenStatus {
    return $SellTokenStatusCopyWith<$Res>(_value.sellTokenStatus, (value) {
      return _then(_value.copyWith(sellTokenStatus: value) as $Val);
    });
  }

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res>? get fromToken {
    if (_value.fromToken == null) {
      return null;
    }

    return $TokenCopyWith<$Res>(_value.fromToken!, (value) {
      return _then(_value.copyWith(fromToken: value) as $Val);
    });
  }

  /// Create a copy of QuickTradeState
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
}

/// @nodoc
abstract class _$$QuickTradeStateImplCopyWith<$Res>
    implements $QuickTradeStateCopyWith<$Res> {
  factory _$$QuickTradeStateImplCopyWith(_$QuickTradeStateImpl value,
          $Res Function(_$QuickTradeStateImpl) then) =
      __$$QuickTradeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuyTokenStatus buyTokenStatus,
      SellTokenStatus sellTokenStatus,
      Token? fromToken,
      Token? selectedToken,
      String buyAmount,
      String sellPercent,
      QuickTradeMode mode});

  @override
  $BuyTokenStatusCopyWith<$Res> get buyTokenStatus;
  @override
  $SellTokenStatusCopyWith<$Res> get sellTokenStatus;
  @override
  $TokenCopyWith<$Res>? get fromToken;
  @override
  $TokenCopyWith<$Res>? get selectedToken;
}

/// @nodoc
class __$$QuickTradeStateImplCopyWithImpl<$Res>
    extends _$QuickTradeStateCopyWithImpl<$Res, _$QuickTradeStateImpl>
    implements _$$QuickTradeStateImplCopyWith<$Res> {
  __$$QuickTradeStateImplCopyWithImpl(
      _$QuickTradeStateImpl _value, $Res Function(_$QuickTradeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buyTokenStatus = null,
    Object? sellTokenStatus = null,
    Object? fromToken = freezed,
    Object? selectedToken = freezed,
    Object? buyAmount = null,
    Object? sellPercent = null,
    Object? mode = null,
  }) {
    return _then(_$QuickTradeStateImpl(
      buyTokenStatus: null == buyTokenStatus
          ? _value.buyTokenStatus
          : buyTokenStatus // ignore: cast_nullable_to_non_nullable
              as BuyTokenStatus,
      sellTokenStatus: null == sellTokenStatus
          ? _value.sellTokenStatus
          : sellTokenStatus // ignore: cast_nullable_to_non_nullable
              as SellTokenStatus,
      fromToken: freezed == fromToken
          ? _value.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      buyAmount: null == buyAmount
          ? _value.buyAmount
          : buyAmount // ignore: cast_nullable_to_non_nullable
              as String,
      sellPercent: null == sellPercent
          ? _value.sellPercent
          : sellPercent // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as QuickTradeMode,
    ));
  }
}

/// @nodoc

class _$QuickTradeStateImpl implements _QuickTradeState {
  const _$QuickTradeStateImpl(
      {this.buyTokenStatus = const BuyTokenStatus.initial(),
      this.sellTokenStatus = const SellTokenStatus.initial(),
      this.fromToken = null,
      this.selectedToken = null,
      this.buyAmount = "",
      this.sellPercent = "",
      this.mode = QuickTradeMode.buy});

  @override
  @JsonKey()
  final BuyTokenStatus buyTokenStatus;
  @override
  @JsonKey()
  final SellTokenStatus sellTokenStatus;
  @override
  @JsonKey()
  final Token? fromToken;
// @Default(null) Token? toToken,
  @override
  @JsonKey()
  final Token? selectedToken;
  @override
  @JsonKey()
  final String buyAmount;
  @override
  @JsonKey()
  final String sellPercent;
  @override
  @JsonKey()
  final QuickTradeMode mode;

  @override
  String toString() {
    return 'QuickTradeState(buyTokenStatus: $buyTokenStatus, sellTokenStatus: $sellTokenStatus, fromToken: $fromToken, selectedToken: $selectedToken, buyAmount: $buyAmount, sellPercent: $sellPercent, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickTradeStateImpl &&
            (identical(other.buyTokenStatus, buyTokenStatus) ||
                other.buyTokenStatus == buyTokenStatus) &&
            (identical(other.sellTokenStatus, sellTokenStatus) ||
                other.sellTokenStatus == sellTokenStatus) &&
            (identical(other.fromToken, fromToken) ||
                other.fromToken == fromToken) &&
            (identical(other.selectedToken, selectedToken) ||
                other.selectedToken == selectedToken) &&
            (identical(other.buyAmount, buyAmount) ||
                other.buyAmount == buyAmount) &&
            (identical(other.sellPercent, sellPercent) ||
                other.sellPercent == sellPercent) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, buyTokenStatus, sellTokenStatus,
      fromToken, selectedToken, buyAmount, sellPercent, mode);

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickTradeStateImplCopyWith<_$QuickTradeStateImpl> get copyWith =>
      __$$QuickTradeStateImplCopyWithImpl<_$QuickTradeStateImpl>(
          this, _$identity);
}

abstract class _QuickTradeState implements QuickTradeState {
  const factory _QuickTradeState(
      {final BuyTokenStatus buyTokenStatus,
      final SellTokenStatus sellTokenStatus,
      final Token? fromToken,
      final Token? selectedToken,
      final String buyAmount,
      final String sellPercent,
      final QuickTradeMode mode}) = _$QuickTradeStateImpl;

  @override
  BuyTokenStatus get buyTokenStatus;
  @override
  SellTokenStatus get sellTokenStatus;
  @override
  Token? get fromToken; // @Default(null) Token? toToken,
  @override
  Token? get selectedToken;
  @override
  String get buyAmount;
  @override
  String get sellPercent;
  @override
  QuickTradeMode get mode;

  /// Create a copy of QuickTradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickTradeStateImplCopyWith<_$QuickTradeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
