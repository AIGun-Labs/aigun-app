// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapTransaction data) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapTransaction data)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapTransaction data)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionInitial value) initial,
    required TResult Function(_TransactionLoading value) loading,
    required TResult Function(_TransactionSuccess value) success,
    required TResult Function(_TransactionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionInitial value)? initial,
    TResult? Function(_TransactionLoading value)? loading,
    TResult? Function(_TransactionSuccess value)? success,
    TResult? Function(_TransactionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionInitial value)? initial,
    TResult Function(_TransactionLoading value)? loading,
    TResult Function(_TransactionSuccess value)? success,
    TResult Function(_TransactionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStatusCopyWith<$Res> {
  factory $TransactionStatusCopyWith(
          TransactionStatus value, $Res Function(TransactionStatus) then) =
      _$TransactionStatusCopyWithImpl<$Res, TransactionStatus>;
}

/// @nodoc
class _$TransactionStatusCopyWithImpl<$Res, $Val extends TransactionStatus>
    implements $TransactionStatusCopyWith<$Res> {
  _$TransactionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TransactionInitialImplCopyWith<$Res> {
  factory _$$TransactionInitialImplCopyWith(_$TransactionInitialImpl value,
          $Res Function(_$TransactionInitialImpl) then) =
      __$$TransactionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionInitialImplCopyWithImpl<$Res>
    extends _$TransactionStatusCopyWithImpl<$Res, _$TransactionInitialImpl>
    implements _$$TransactionInitialImplCopyWith<$Res> {
  __$$TransactionInitialImplCopyWithImpl(_$TransactionInitialImpl _value,
      $Res Function(_$TransactionInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TransactionInitialImpl implements _TransactionInitial {
  const _$TransactionInitialImpl();

  @override
  String toString() {
    return 'TransactionStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TransactionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapTransaction data) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapTransaction data)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapTransaction data)? success,
    TResult Function(String message)? error,
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
    required TResult Function(_TransactionInitial value) initial,
    required TResult Function(_TransactionLoading value) loading,
    required TResult Function(_TransactionSuccess value) success,
    required TResult Function(_TransactionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionInitial value)? initial,
    TResult? Function(_TransactionLoading value)? loading,
    TResult? Function(_TransactionSuccess value)? success,
    TResult? Function(_TransactionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionInitial value)? initial,
    TResult Function(_TransactionLoading value)? loading,
    TResult Function(_TransactionSuccess value)? success,
    TResult Function(_TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _TransactionInitial implements TransactionStatus {
  const factory _TransactionInitial() = _$TransactionInitialImpl;
}

/// @nodoc
abstract class _$$TransactionLoadingImplCopyWith<$Res> {
  factory _$$TransactionLoadingImplCopyWith(_$TransactionLoadingImpl value,
          $Res Function(_$TransactionLoadingImpl) then) =
      __$$TransactionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionLoadingImplCopyWithImpl<$Res>
    extends _$TransactionStatusCopyWithImpl<$Res, _$TransactionLoadingImpl>
    implements _$$TransactionLoadingImplCopyWith<$Res> {
  __$$TransactionLoadingImplCopyWithImpl(_$TransactionLoadingImpl _value,
      $Res Function(_$TransactionLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TransactionLoadingImpl implements _TransactionLoading {
  const _$TransactionLoadingImpl();

  @override
  String toString() {
    return 'TransactionStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TransactionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapTransaction data) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapTransaction data)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapTransaction data)? success,
    TResult Function(String message)? error,
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
    required TResult Function(_TransactionInitial value) initial,
    required TResult Function(_TransactionLoading value) loading,
    required TResult Function(_TransactionSuccess value) success,
    required TResult Function(_TransactionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionInitial value)? initial,
    TResult? Function(_TransactionLoading value)? loading,
    TResult? Function(_TransactionSuccess value)? success,
    TResult? Function(_TransactionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionInitial value)? initial,
    TResult Function(_TransactionLoading value)? loading,
    TResult Function(_TransactionSuccess value)? success,
    TResult Function(_TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _TransactionLoading implements TransactionStatus {
  const factory _TransactionLoading() = _$TransactionLoadingImpl;
}

/// @nodoc
abstract class _$$TransactionSuccessImplCopyWith<$Res> {
  factory _$$TransactionSuccessImplCopyWith(_$TransactionSuccessImpl value,
          $Res Function(_$TransactionSuccessImpl) then) =
      __$$TransactionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SwapTransaction data});

  $SwapTransactionCopyWith<$Res> get data;
}

/// @nodoc
class __$$TransactionSuccessImplCopyWithImpl<$Res>
    extends _$TransactionStatusCopyWithImpl<$Res, _$TransactionSuccessImpl>
    implements _$$TransactionSuccessImplCopyWith<$Res> {
  __$$TransactionSuccessImplCopyWithImpl(_$TransactionSuccessImpl _value,
      $Res Function(_$TransactionSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$TransactionSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SwapTransaction,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SwapTransactionCopyWith<$Res> get data {
    return $SwapTransactionCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$TransactionSuccessImpl implements _TransactionSuccess {
  const _$TransactionSuccessImpl(this.data);

  @override
  final SwapTransaction data;

  @override
  String toString() {
    return 'TransactionStatus.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSuccessImplCopyWith<_$TransactionSuccessImpl> get copyWith =>
      __$$TransactionSuccessImplCopyWithImpl<_$TransactionSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapTransaction data) success,
    required TResult Function(String message) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapTransaction data)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapTransaction data)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionInitial value) initial,
    required TResult Function(_TransactionLoading value) loading,
    required TResult Function(_TransactionSuccess value) success,
    required TResult Function(_TransactionError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionInitial value)? initial,
    TResult? Function(_TransactionLoading value)? loading,
    TResult? Function(_TransactionSuccess value)? success,
    TResult? Function(_TransactionError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionInitial value)? initial,
    TResult Function(_TransactionLoading value)? loading,
    TResult Function(_TransactionSuccess value)? success,
    TResult Function(_TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _TransactionSuccess implements TransactionStatus {
  const factory _TransactionSuccess(final SwapTransaction data) =
      _$TransactionSuccessImpl;

  SwapTransaction get data;
  @JsonKey(ignore: true)
  _$$TransactionSuccessImplCopyWith<_$TransactionSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionErrorImplCopyWith<$Res> {
  factory _$$TransactionErrorImplCopyWith(_$TransactionErrorImpl value,
          $Res Function(_$TransactionErrorImpl) then) =
      __$$TransactionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TransactionErrorImplCopyWithImpl<$Res>
    extends _$TransactionStatusCopyWithImpl<$Res, _$TransactionErrorImpl>
    implements _$$TransactionErrorImplCopyWith<$Res> {
  __$$TransactionErrorImplCopyWithImpl(_$TransactionErrorImpl _value,
      $Res Function(_$TransactionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TransactionErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionErrorImpl implements _TransactionError {
  const _$TransactionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TransactionStatus.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionErrorImplCopyWith<_$TransactionErrorImpl> get copyWith =>
      __$$TransactionErrorImplCopyWithImpl<_$TransactionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapTransaction data) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapTransaction data)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapTransaction data)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionInitial value) initial,
    required TResult Function(_TransactionLoading value) loading,
    required TResult Function(_TransactionSuccess value) success,
    required TResult Function(_TransactionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionInitial value)? initial,
    TResult? Function(_TransactionLoading value)? loading,
    TResult? Function(_TransactionSuccess value)? success,
    TResult? Function(_TransactionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionInitial value)? initial,
    TResult Function(_TransactionLoading value)? loading,
    TResult Function(_TransactionSuccess value)? success,
    TResult Function(_TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _TransactionError implements TransactionStatus {
  const factory _TransactionError(final String message) =
      _$TransactionErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$TransactionErrorImplCopyWith<_$TransactionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuoteStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapQuote quote) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapQuote quote)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapQuote quote)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteStatusCopyWith<$Res> {
  factory $QuoteStatusCopyWith(
          QuoteStatus value, $Res Function(QuoteStatus) then) =
      _$QuoteStatusCopyWithImpl<$Res, QuoteStatus>;
}

/// @nodoc
class _$QuoteStatusCopyWithImpl<$Res, $Val extends QuoteStatus>
    implements $QuoteStatusCopyWith<$Res> {
  _$QuoteStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$QuoteInitialImplCopyWith<$Res> {
  factory _$$QuoteInitialImplCopyWith(
          _$QuoteInitialImpl value, $Res Function(_$QuoteInitialImpl) then) =
      __$$QuoteInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QuoteInitialImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteInitialImpl>
    implements _$$QuoteInitialImplCopyWith<$Res> {
  __$$QuoteInitialImplCopyWithImpl(
      _$QuoteInitialImpl _value, $Res Function(_$QuoteInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$QuoteInitialImpl implements _QuoteInitial {
  const _$QuoteInitialImpl();

  @override
  String toString() {
    return 'QuoteStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QuoteInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapQuote quote) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapQuote quote)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapQuote quote)? success,
    TResult Function(String message)? error,
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
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _QuoteInitial implements QuoteStatus {
  const factory _QuoteInitial() = _$QuoteInitialImpl;
}

/// @nodoc
abstract class _$$QuoteLoadingImplCopyWith<$Res> {
  factory _$$QuoteLoadingImplCopyWith(
          _$QuoteLoadingImpl value, $Res Function(_$QuoteLoadingImpl) then) =
      __$$QuoteLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QuoteLoadingImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteLoadingImpl>
    implements _$$QuoteLoadingImplCopyWith<$Res> {
  __$$QuoteLoadingImplCopyWithImpl(
      _$QuoteLoadingImpl _value, $Res Function(_$QuoteLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$QuoteLoadingImpl implements _QuoteLoading {
  const _$QuoteLoadingImpl();

  @override
  String toString() {
    return 'QuoteStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QuoteLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapQuote quote) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapQuote quote)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapQuote quote)? success,
    TResult Function(String message)? error,
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
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _QuoteLoading implements QuoteStatus {
  const factory _QuoteLoading() = _$QuoteLoadingImpl;
}

/// @nodoc
abstract class _$$QuoteSuccessImplCopyWith<$Res> {
  factory _$$QuoteSuccessImplCopyWith(
          _$QuoteSuccessImpl value, $Res Function(_$QuoteSuccessImpl) then) =
      __$$QuoteSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SwapQuote quote});

  $SwapQuoteCopyWith<$Res> get quote;
}

/// @nodoc
class __$$QuoteSuccessImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteSuccessImpl>
    implements _$$QuoteSuccessImplCopyWith<$Res> {
  __$$QuoteSuccessImplCopyWithImpl(
      _$QuoteSuccessImpl _value, $Res Function(_$QuoteSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
  }) {
    return _then(_$QuoteSuccessImpl(
      null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as SwapQuote,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SwapQuoteCopyWith<$Res> get quote {
    return $SwapQuoteCopyWith<$Res>(_value.quote, (value) {
      return _then(_value.copyWith(quote: value));
    });
  }
}

/// @nodoc

class _$QuoteSuccessImpl implements _QuoteSuccess {
  const _$QuoteSuccessImpl(this.quote);

  @override
  final SwapQuote quote;

  @override
  String toString() {
    return 'QuoteStatus.success(quote: $quote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteSuccessImpl &&
            (identical(other.quote, quote) || other.quote == quote));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quote);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteSuccessImplCopyWith<_$QuoteSuccessImpl> get copyWith =>
      __$$QuoteSuccessImplCopyWithImpl<_$QuoteSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapQuote quote) success,
    required TResult Function(String message) error,
  }) {
    return success(quote);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapQuote quote)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(quote);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapQuote quote)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(quote);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _QuoteSuccess implements QuoteStatus {
  const factory _QuoteSuccess(final SwapQuote quote) = _$QuoteSuccessImpl;

  SwapQuote get quote;
  @JsonKey(ignore: true)
  _$$QuoteSuccessImplCopyWith<_$QuoteSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuoteErrorImplCopyWith<$Res> {
  factory _$$QuoteErrorImplCopyWith(
          _$QuoteErrorImpl value, $Res Function(_$QuoteErrorImpl) then) =
      __$$QuoteErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$QuoteErrorImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteErrorImpl>
    implements _$$QuoteErrorImplCopyWith<$Res> {
  __$$QuoteErrorImplCopyWithImpl(
      _$QuoteErrorImpl _value, $Res Function(_$QuoteErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$QuoteErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QuoteErrorImpl implements _QuoteError {
  const _$QuoteErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'QuoteStatus.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteErrorImplCopyWith<_$QuoteErrorImpl> get copyWith =>
      __$$QuoteErrorImplCopyWithImpl<_$QuoteErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SwapQuote quote) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SwapQuote quote)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SwapQuote quote)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _QuoteError implements QuoteStatus {
  const factory _QuoteError(final String message) = _$QuoteErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$QuoteErrorImplCopyWith<_$QuoteErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SwapState {
  TransactionStatus get transactionStatus => throw _privateConstructorUsedError;
  QuoteStatus get quoteStatus => throw _privateConstructorUsedError;
  int get fromChainId => throw _privateConstructorUsedError; // 来源链
  String get toChainId => throw _privateConstructorUsedError; // 目标链
  String get inputMint => throw _privateConstructorUsedError; // 输入代币
  String get outputMint => throw _privateConstructorUsedError; // 输出代币
  String get amount => throw _privateConstructorUsedError; // 输入数量
  double get slippage => throw _privateConstructorUsedError; // 滑点
  String get priorityFee => throw _privateConstructorUsedError; // 优先费
  bool get isLoading => throw _privateConstructorUsedError;
  TargetToken? get toToken => throw _privateConstructorUsedError;
  SwapQuote? get quote => throw _privateConstructorUsedError;
  Token? get selectedToken => throw _privateConstructorUsedError;
  Chain? get selectedChain => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SwapStateCopyWith<SwapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapStateCopyWith<$Res> {
  factory $SwapStateCopyWith(SwapState value, $Res Function(SwapState) then) =
      _$SwapStateCopyWithImpl<$Res, SwapState>;
  @useResult
  $Res call(
      {TransactionStatus transactionStatus,
      QuoteStatus quoteStatus,
      int fromChainId,
      String toChainId,
      String inputMint,
      String outputMint,
      String amount,
      double slippage,
      String priorityFee,
      bool isLoading,
      TargetToken? toToken,
      SwapQuote? quote,
      Token? selectedToken,
      Chain? selectedChain});

  $TransactionStatusCopyWith<$Res> get transactionStatus;
  $QuoteStatusCopyWith<$Res> get quoteStatus;
  $TargetTokenCopyWith<$Res>? get toToken;
  $SwapQuoteCopyWith<$Res>? get quote;
  $TokenCopyWith<$Res>? get selectedToken;
  $ChainCopyWith<$Res>? get selectedChain;
}

/// @nodoc
class _$SwapStateCopyWithImpl<$Res, $Val extends SwapState>
    implements $SwapStateCopyWith<$Res> {
  _$SwapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionStatus = null,
    Object? quoteStatus = null,
    Object? fromChainId = null,
    Object? toChainId = null,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? slippage = null,
    Object? priorityFee = null,
    Object? isLoading = null,
    Object? toToken = freezed,
    Object? quote = freezed,
    Object? selectedToken = freezed,
    Object? selectedChain = freezed,
  }) {
    return _then(_value.copyWith(
      transactionStatus: null == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as TransactionStatus,
      quoteStatus: null == quoteStatus
          ? _value.quoteStatus
          : quoteStatus // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      fromChainId: null == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int,
      toChainId: null == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as String,
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFee: null == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      toToken: freezed == toToken
          ? _value.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as TargetToken?,
      quote: freezed == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as SwapQuote?,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      selectedChain: freezed == selectedChain
          ? _value.selectedChain
          : selectedChain // ignore: cast_nullable_to_non_nullable
              as Chain?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionStatusCopyWith<$Res> get transactionStatus {
    return $TransactionStatusCopyWith<$Res>(_value.transactionStatus, (value) {
      return _then(_value.copyWith(transactionStatus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QuoteStatusCopyWith<$Res> get quoteStatus {
    return $QuoteStatusCopyWith<$Res>(_value.quoteStatus, (value) {
      return _then(_value.copyWith(quoteStatus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TargetTokenCopyWith<$Res>? get toToken {
    if (_value.toToken == null) {
      return null;
    }

    return $TargetTokenCopyWith<$Res>(_value.toToken!, (value) {
      return _then(_value.copyWith(toToken: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SwapQuoteCopyWith<$Res>? get quote {
    if (_value.quote == null) {
      return null;
    }

    return $SwapQuoteCopyWith<$Res>(_value.quote!, (value) {
      return _then(_value.copyWith(quote: value) as $Val);
    });
  }

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

  @override
  @pragma('vm:prefer-inline')
  $ChainCopyWith<$Res>? get selectedChain {
    if (_value.selectedChain == null) {
      return null;
    }

    return $ChainCopyWith<$Res>(_value.selectedChain!, (value) {
      return _then(_value.copyWith(selectedChain: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SwapStateImplCopyWith<$Res>
    implements $SwapStateCopyWith<$Res> {
  factory _$$SwapStateImplCopyWith(
          _$SwapStateImpl value, $Res Function(_$SwapStateImpl) then) =
      __$$SwapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionStatus transactionStatus,
      QuoteStatus quoteStatus,
      int fromChainId,
      String toChainId,
      String inputMint,
      String outputMint,
      String amount,
      double slippage,
      String priorityFee,
      bool isLoading,
      TargetToken? toToken,
      SwapQuote? quote,
      Token? selectedToken,
      Chain? selectedChain});

  @override
  $TransactionStatusCopyWith<$Res> get transactionStatus;
  @override
  $QuoteStatusCopyWith<$Res> get quoteStatus;
  @override
  $TargetTokenCopyWith<$Res>? get toToken;
  @override
  $SwapQuoteCopyWith<$Res>? get quote;
  @override
  $TokenCopyWith<$Res>? get selectedToken;
  @override
  $ChainCopyWith<$Res>? get selectedChain;
}

/// @nodoc
class __$$SwapStateImplCopyWithImpl<$Res>
    extends _$SwapStateCopyWithImpl<$Res, _$SwapStateImpl>
    implements _$$SwapStateImplCopyWith<$Res> {
  __$$SwapStateImplCopyWithImpl(
      _$SwapStateImpl _value, $Res Function(_$SwapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionStatus = null,
    Object? quoteStatus = null,
    Object? fromChainId = null,
    Object? toChainId = null,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? slippage = null,
    Object? priorityFee = null,
    Object? isLoading = null,
    Object? toToken = freezed,
    Object? quote = freezed,
    Object? selectedToken = freezed,
    Object? selectedChain = freezed,
  }) {
    return _then(_$SwapStateImpl(
      transactionStatus: null == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as TransactionStatus,
      quoteStatus: null == quoteStatus
          ? _value.quoteStatus
          : quoteStatus // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      fromChainId: null == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int,
      toChainId: null == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as String,
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFee: null == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      toToken: freezed == toToken
          ? _value.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as TargetToken?,
      quote: freezed == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as SwapQuote?,
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as Token?,
      selectedChain: freezed == selectedChain
          ? _value.selectedChain
          : selectedChain // ignore: cast_nullable_to_non_nullable
              as Chain?,
    ));
  }
}

/// @nodoc

class _$SwapStateImpl implements _SwapState {
  const _$SwapStateImpl(
      {this.transactionStatus = const TransactionStatus.initial(),
      this.quoteStatus = const QuoteStatus.initial(),
      this.fromChainId = 56,
      this.toChainId = "56",
      this.inputMint = "",
      this.outputMint = "0xba2ae424d960c26247dd6c32edc70b295c744c43",
      this.amount = "0",
      this.slippage = 100,
      this.priorityFee = "0",
      this.isLoading = false,
      this.toToken,
      this.quote,
      this.selectedToken,
      this.selectedChain});

  @override
  @JsonKey()
  final TransactionStatus transactionStatus;
  @override
  @JsonKey()
  final QuoteStatus quoteStatus;
  @override
  @JsonKey()
  final int fromChainId;
// 来源链
  @override
  @JsonKey()
  final String toChainId;
// 目标链
  @override
  @JsonKey()
  final String inputMint;
// 输入代币
  @override
  @JsonKey()
  final String outputMint;
// 输出代币
  @override
  @JsonKey()
  final String amount;
// 输入数量
  @override
  @JsonKey()
  final double slippage;
// 滑点
  @override
  @JsonKey()
  final String priorityFee;
// 优先费
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final TargetToken? toToken;
  @override
  final SwapQuote? quote;
  @override
  final Token? selectedToken;
  @override
  final Chain? selectedChain;

  @override
  String toString() {
    return 'SwapState(transactionStatus: $transactionStatus, quoteStatus: $quoteStatus, fromChainId: $fromChainId, toChainId: $toChainId, inputMint: $inputMint, outputMint: $outputMint, amount: $amount, slippage: $slippage, priorityFee: $priorityFee, isLoading: $isLoading, toToken: $toToken, quote: $quote, selectedToken: $selectedToken, selectedChain: $selectedChain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapStateImpl &&
            (identical(other.transactionStatus, transactionStatus) ||
                other.transactionStatus == transactionStatus) &&
            (identical(other.quoteStatus, quoteStatus) ||
                other.quoteStatus == quoteStatus) &&
            (identical(other.fromChainId, fromChainId) ||
                other.fromChainId == fromChainId) &&
            (identical(other.toChainId, toChainId) ||
                other.toChainId == toChainId) &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.priorityFee, priorityFee) ||
                other.priorityFee == priorityFee) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.toToken, toToken) || other.toToken == toToken) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.selectedToken, selectedToken) ||
                other.selectedToken == selectedToken) &&
            (identical(other.selectedChain, selectedChain) ||
                other.selectedChain == selectedChain));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionStatus,
      quoteStatus,
      fromChainId,
      toChainId,
      inputMint,
      outputMint,
      amount,
      slippage,
      priorityFee,
      isLoading,
      toToken,
      quote,
      selectedToken,
      selectedChain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapStateImplCopyWith<_$SwapStateImpl> get copyWith =>
      __$$SwapStateImplCopyWithImpl<_$SwapStateImpl>(this, _$identity);
}

abstract class _SwapState implements SwapState {
  const factory _SwapState(
      {final TransactionStatus transactionStatus,
      final QuoteStatus quoteStatus,
      final int fromChainId,
      final String toChainId,
      final String inputMint,
      final String outputMint,
      final String amount,
      final double slippage,
      final String priorityFee,
      final bool isLoading,
      final TargetToken? toToken,
      final SwapQuote? quote,
      final Token? selectedToken,
      final Chain? selectedChain}) = _$SwapStateImpl;

  @override
  TransactionStatus get transactionStatus;
  @override
  QuoteStatus get quoteStatus;
  @override
  int get fromChainId;
  @override // 来源链
  String get toChainId;
  @override // 目标链
  String get inputMint;
  @override // 输入代币
  String get outputMint;
  @override // 输出代币
  String get amount;
  @override // 输入数量
  double get slippage;
  @override // 滑点
  String get priorityFee;
  @override // 优先费
  bool get isLoading;
  @override
  TargetToken? get toToken;
  @override
  SwapQuote? get quote;
  @override
  Token? get selectedToken;
  @override
  Chain? get selectedChain;
  @override
  @JsonKey(ignore: true)
  _$$SwapStateImplCopyWith<_$SwapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
