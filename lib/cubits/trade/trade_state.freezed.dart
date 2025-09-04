// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuoteStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferQuote quote) success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferQuote quote)? success,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferQuote quote)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteFailure value)? failure,
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

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
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
    required TResult Function(TransferQuote quote) success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferQuote quote)? success,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferQuote quote)? success,
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
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteFailure value)? failure,
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

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
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
    required TResult Function(TransferQuote quote) success,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferQuote quote)? success,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferQuote quote)? success,
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
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteFailure value)? failure,
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
  $Res call({TransferQuote quote});

  $TransferQuoteCopyWith<$Res> get quote;
}

/// @nodoc
class __$$QuoteSuccessImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteSuccessImpl>
    implements _$$QuoteSuccessImplCopyWith<$Res> {
  __$$QuoteSuccessImplCopyWithImpl(
      _$QuoteSuccessImpl _value, $Res Function(_$QuoteSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
  }) {
    return _then(_$QuoteSuccessImpl(
      null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as TransferQuote,
    ));
  }

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferQuoteCopyWith<$Res> get quote {
    return $TransferQuoteCopyWith<$Res>(_value.quote, (value) {
      return _then(_value.copyWith(quote: value));
    });
  }
}

/// @nodoc

class _$QuoteSuccessImpl implements _QuoteSuccess {
  const _$QuoteSuccessImpl(this.quote);

  @override
  final TransferQuote quote;

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

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteSuccessImplCopyWith<_$QuoteSuccessImpl> get copyWith =>
      __$$QuoteSuccessImplCopyWithImpl<_$QuoteSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferQuote quote) success,
    required TResult Function() failure,
  }) {
    return success(quote);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferQuote quote)? success,
    TResult? Function()? failure,
  }) {
    return success?.call(quote);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferQuote quote)? success,
    TResult Function()? failure,
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
    required TResult Function(_QuoteFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _QuoteSuccess implements QuoteStatus {
  const factory _QuoteSuccess(final TransferQuote quote) = _$QuoteSuccessImpl;

  TransferQuote get quote;

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteSuccessImplCopyWith<_$QuoteSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuoteFailureImplCopyWith<$Res> {
  factory _$$QuoteFailureImplCopyWith(
          _$QuoteFailureImpl value, $Res Function(_$QuoteFailureImpl) then) =
      __$$QuoteFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QuoteFailureImplCopyWithImpl<$Res>
    extends _$QuoteStatusCopyWithImpl<$Res, _$QuoteFailureImpl>
    implements _$$QuoteFailureImplCopyWith<$Res> {
  __$$QuoteFailureImplCopyWithImpl(
      _$QuoteFailureImpl _value, $Res Function(_$QuoteFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuoteStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QuoteFailureImpl implements _QuoteFailure {
  const _$QuoteFailureImpl();

  @override
  String toString() {
    return 'QuoteStatus.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QuoteFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferQuote quote) success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferQuote quote)? success,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferQuote quote)? success,
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
    required TResult Function(_QuoteInitial value) initial,
    required TResult Function(_QuoteLoading value) loading,
    required TResult Function(_QuoteSuccess value) success,
    required TResult Function(_QuoteFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuoteInitial value)? initial,
    TResult? Function(_QuoteLoading value)? loading,
    TResult? Function(_QuoteSuccess value)? success,
    TResult? Function(_QuoteFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuoteInitial value)? initial,
    TResult Function(_QuoteLoading value)? loading,
    TResult Function(_QuoteSuccess value)? success,
    TResult Function(_QuoteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _QuoteFailure implements QuoteStatus {
  const factory _QuoteFailure() = _$QuoteFailureImpl;
}

/// @nodoc
mixin _$TradeStatusMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(TradeStatus failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(TradeStatus failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(TradeStatus failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TradeStatusInitial value) initial,
    required TResult Function(_TradeStatusLoading value) loading,
    required TResult Function(_TradeStatusSuccess value) success,
    required TResult Function(_TradeStatusFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TradeStatusInitial value)? initial,
    TResult? Function(_TradeStatusLoading value)? loading,
    TResult? Function(_TradeStatusSuccess value)? success,
    TResult? Function(_TradeStatusFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TradeStatusInitial value)? initial,
    TResult Function(_TradeStatusLoading value)? loading,
    TResult Function(_TradeStatusSuccess value)? success,
    TResult Function(_TradeStatusFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeStatusMessageCopyWith<$Res> {
  factory $TradeStatusMessageCopyWith(
          TradeStatusMessage value, $Res Function(TradeStatusMessage) then) =
      _$TradeStatusMessageCopyWithImpl<$Res, TradeStatusMessage>;
}

/// @nodoc
class _$TradeStatusMessageCopyWithImpl<$Res, $Val extends TradeStatusMessage>
    implements $TradeStatusMessageCopyWith<$Res> {
  _$TradeStatusMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TradeStatusInitialImplCopyWith<$Res> {
  factory _$$TradeStatusInitialImplCopyWith(_$TradeStatusInitialImpl value,
          $Res Function(_$TradeStatusInitialImpl) then) =
      __$$TradeStatusInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TradeStatusInitialImplCopyWithImpl<$Res>
    extends _$TradeStatusMessageCopyWithImpl<$Res, _$TradeStatusInitialImpl>
    implements _$$TradeStatusInitialImplCopyWith<$Res> {
  __$$TradeStatusInitialImplCopyWithImpl(_$TradeStatusInitialImpl _value,
      $Res Function(_$TradeStatusInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TradeStatusInitialImpl implements _TradeStatusInitial {
  const _$TradeStatusInitialImpl();

  @override
  String toString() {
    return 'TradeStatusMessage.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TradeStatusInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(TradeStatus failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(TradeStatus failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(TradeStatus failure)? failure,
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
    required TResult Function(_TradeStatusInitial value) initial,
    required TResult Function(_TradeStatusLoading value) loading,
    required TResult Function(_TradeStatusSuccess value) success,
    required TResult Function(_TradeStatusFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TradeStatusInitial value)? initial,
    TResult? Function(_TradeStatusLoading value)? loading,
    TResult? Function(_TradeStatusSuccess value)? success,
    TResult? Function(_TradeStatusFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TradeStatusInitial value)? initial,
    TResult Function(_TradeStatusLoading value)? loading,
    TResult Function(_TradeStatusSuccess value)? success,
    TResult Function(_TradeStatusFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _TradeStatusInitial implements TradeStatusMessage {
  const factory _TradeStatusInitial() = _$TradeStatusInitialImpl;
}

/// @nodoc
abstract class _$$TradeStatusLoadingImplCopyWith<$Res> {
  factory _$$TradeStatusLoadingImplCopyWith(_$TradeStatusLoadingImpl value,
          $Res Function(_$TradeStatusLoadingImpl) then) =
      __$$TradeStatusLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TradeStatusLoadingImplCopyWithImpl<$Res>
    extends _$TradeStatusMessageCopyWithImpl<$Res, _$TradeStatusLoadingImpl>
    implements _$$TradeStatusLoadingImplCopyWith<$Res> {
  __$$TradeStatusLoadingImplCopyWithImpl(_$TradeStatusLoadingImpl _value,
      $Res Function(_$TradeStatusLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TradeStatusLoadingImpl implements _TradeStatusLoading {
  const _$TradeStatusLoadingImpl();

  @override
  String toString() {
    return 'TradeStatusMessage.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TradeStatusLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(TradeStatus failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(TradeStatus failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(TradeStatus failure)? failure,
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
    required TResult Function(_TradeStatusInitial value) initial,
    required TResult Function(_TradeStatusLoading value) loading,
    required TResult Function(_TradeStatusSuccess value) success,
    required TResult Function(_TradeStatusFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TradeStatusInitial value)? initial,
    TResult? Function(_TradeStatusLoading value)? loading,
    TResult? Function(_TradeStatusSuccess value)? success,
    TResult? Function(_TradeStatusFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TradeStatusInitial value)? initial,
    TResult Function(_TradeStatusLoading value)? loading,
    TResult Function(_TradeStatusSuccess value)? success,
    TResult Function(_TradeStatusFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _TradeStatusLoading implements TradeStatusMessage {
  const factory _TradeStatusLoading() = _$TradeStatusLoadingImpl;
}

/// @nodoc
abstract class _$$TradeStatusSuccessImplCopyWith<$Res> {
  factory _$$TradeStatusSuccessImplCopyWith(_$TradeStatusSuccessImpl value,
          $Res Function(_$TradeStatusSuccessImpl) then) =
      __$$TradeStatusSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferTransaction transaction});

  $TransferTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$TradeStatusSuccessImplCopyWithImpl<$Res>
    extends _$TradeStatusMessageCopyWithImpl<$Res, _$TradeStatusSuccessImpl>
    implements _$$TradeStatusSuccessImplCopyWith<$Res> {
  __$$TradeStatusSuccessImplCopyWithImpl(_$TradeStatusSuccessImpl _value,
      $Res Function(_$TradeStatusSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$TradeStatusSuccessImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransferTransaction,
    ));
  }

  /// Create a copy of TradeStatusMessage
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

class _$TradeStatusSuccessImpl implements _TradeStatusSuccess {
  const _$TradeStatusSuccessImpl(this.transaction);

  @override
  final TransferTransaction transaction;

  @override
  String toString() {
    return 'TradeStatusMessage.success(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeStatusSuccessImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeStatusSuccessImplCopyWith<_$TradeStatusSuccessImpl> get copyWith =>
      __$$TradeStatusSuccessImplCopyWithImpl<_$TradeStatusSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(TradeStatus failure) failure,
  }) {
    return success(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(TradeStatus failure)? failure,
  }) {
    return success?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(TradeStatus failure)? failure,
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
    required TResult Function(_TradeStatusInitial value) initial,
    required TResult Function(_TradeStatusLoading value) loading,
    required TResult Function(_TradeStatusSuccess value) success,
    required TResult Function(_TradeStatusFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TradeStatusInitial value)? initial,
    TResult? Function(_TradeStatusLoading value)? loading,
    TResult? Function(_TradeStatusSuccess value)? success,
    TResult? Function(_TradeStatusFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TradeStatusInitial value)? initial,
    TResult Function(_TradeStatusLoading value)? loading,
    TResult Function(_TradeStatusSuccess value)? success,
    TResult Function(_TradeStatusFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _TradeStatusSuccess implements TradeStatusMessage {
  const factory _TradeStatusSuccess(final TransferTransaction transaction) =
      _$TradeStatusSuccessImpl;

  TransferTransaction get transaction;

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeStatusSuccessImplCopyWith<_$TradeStatusSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TradeStatusFailureImplCopyWith<$Res> {
  factory _$$TradeStatusFailureImplCopyWith(_$TradeStatusFailureImpl value,
          $Res Function(_$TradeStatusFailureImpl) then) =
      __$$TradeStatusFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TradeStatus failure});
}

/// @nodoc
class __$$TradeStatusFailureImplCopyWithImpl<$Res>
    extends _$TradeStatusMessageCopyWithImpl<$Res, _$TradeStatusFailureImpl>
    implements _$$TradeStatusFailureImplCopyWith<$Res> {
  __$$TradeStatusFailureImplCopyWithImpl(_$TradeStatusFailureImpl _value,
      $Res Function(_$TradeStatusFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$TradeStatusFailureImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as TradeStatus,
    ));
  }
}

/// @nodoc

class _$TradeStatusFailureImpl implements _TradeStatusFailure {
  const _$TradeStatusFailureImpl(this.failure);

  @override
  final TradeStatus failure;

  @override
  String toString() {
    return 'TradeStatusMessage.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeStatusFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeStatusFailureImplCopyWith<_$TradeStatusFailureImpl> get copyWith =>
      __$$TradeStatusFailureImplCopyWithImpl<_$TradeStatusFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransferTransaction transaction) success,
    required TResult Function(TradeStatus failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransferTransaction transaction)? success,
    TResult? Function(TradeStatus failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransferTransaction transaction)? success,
    TResult Function(TradeStatus failure)? failure,
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
    required TResult Function(_TradeStatusInitial value) initial,
    required TResult Function(_TradeStatusLoading value) loading,
    required TResult Function(_TradeStatusSuccess value) success,
    required TResult Function(_TradeStatusFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TradeStatusInitial value)? initial,
    TResult? Function(_TradeStatusLoading value)? loading,
    TResult? Function(_TradeStatusSuccess value)? success,
    TResult? Function(_TradeStatusFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TradeStatusInitial value)? initial,
    TResult Function(_TradeStatusLoading value)? loading,
    TResult Function(_TradeStatusSuccess value)? success,
    TResult Function(_TradeStatusFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _TradeStatusFailure implements TradeStatusMessage {
  const factory _TradeStatusFailure(final TradeStatus failure) =
      _$TradeStatusFailureImpl;

  TradeStatus get failure;

  /// Create a copy of TradeStatusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeStatusFailureImplCopyWith<_$TradeStatusFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TradeToken {
  @JsonKey(name: "chain_id")
  int get chainId =>
      throw _privateConstructorUsedError; // @JsonKey(name: "chain_name") String chainName,
  @JsonKey(name: "chain_logo")
  String get chainLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "token_avatar")
  String get tokenAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: "token_name")
  String get tokenName => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: "decimals")
  int get decimals => throw _privateConstructorUsedError;

  /// Create a copy of TradeToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeTokenCopyWith<TradeToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeTokenCopyWith<$Res> {
  factory $TradeTokenCopyWith(
          TradeToken value, $Res Function(TradeToken) then) =
      _$TradeTokenCopyWithImpl<$Res, TradeToken>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_logo") String chainLogo,
      @JsonKey(name: "token_avatar") String tokenAvatar,
      @JsonKey(name: "token_name") String tokenName,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "decimals") int decimals});
}

/// @nodoc
class _$TradeTokenCopyWithImpl<$Res, $Val extends TradeToken>
    implements $TradeTokenCopyWith<$Res> {
  _$TradeTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainLogo = null,
    Object? tokenAvatar = null,
    Object? tokenName = null,
    Object? address = null,
    Object? decimals = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAvatar: null == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeTokenImplCopyWith<$Res>
    implements $TradeTokenCopyWith<$Res> {
  factory _$$TradeTokenImplCopyWith(
          _$TradeTokenImpl value, $Res Function(_$TradeTokenImpl) then) =
      __$$TradeTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_logo") String chainLogo,
      @JsonKey(name: "token_avatar") String tokenAvatar,
      @JsonKey(name: "token_name") String tokenName,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "decimals") int decimals});
}

/// @nodoc
class __$$TradeTokenImplCopyWithImpl<$Res>
    extends _$TradeTokenCopyWithImpl<$Res, _$TradeTokenImpl>
    implements _$$TradeTokenImplCopyWith<$Res> {
  __$$TradeTokenImplCopyWithImpl(
      _$TradeTokenImpl _value, $Res Function(_$TradeTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainLogo = null,
    Object? tokenAvatar = null,
    Object? tokenName = null,
    Object? address = null,
    Object? decimals = null,
  }) {
    return _then(_$TradeTokenImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAvatar: null == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TradeTokenImpl implements _TradeToken {
  const _$TradeTokenImpl(
      {@JsonKey(name: "chain_id") required this.chainId,
      @JsonKey(name: "chain_logo") required this.chainLogo,
      @JsonKey(name: "token_avatar") required this.tokenAvatar,
      @JsonKey(name: "token_name") required this.tokenName,
      @JsonKey(name: "address") required this.address,
      @JsonKey(name: "decimals") required this.decimals});

  @override
  @JsonKey(name: "chain_id")
  final int chainId;
// @JsonKey(name: "chain_name") String chainName,
  @override
  @JsonKey(name: "chain_logo")
  final String chainLogo;
  @override
  @JsonKey(name: "token_avatar")
  final String tokenAvatar;
  @override
  @JsonKey(name: "token_name")
  final String tokenName;
  @override
  @JsonKey(name: "address")
  final String address;
  @override
  @JsonKey(name: "decimals")
  final int decimals;

  @override
  String toString() {
    return 'TradeToken(chainId: $chainId, chainLogo: $chainLogo, tokenAvatar: $tokenAvatar, tokenName: $tokenName, address: $address, decimals: $decimals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeTokenImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.chainLogo, chainLogo) ||
                other.chainLogo == chainLogo) &&
            (identical(other.tokenAvatar, tokenAvatar) ||
                other.tokenAvatar == tokenAvatar) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chainId, chainLogo, tokenAvatar,
      tokenName, address, decimals);

  /// Create a copy of TradeToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeTokenImplCopyWith<_$TradeTokenImpl> get copyWith =>
      __$$TradeTokenImplCopyWithImpl<_$TradeTokenImpl>(this, _$identity);
}

abstract class _TradeToken implements TradeToken {
  const factory _TradeToken(
          {@JsonKey(name: "chain_id") required final int chainId,
          @JsonKey(name: "chain_logo") required final String chainLogo,
          @JsonKey(name: "token_avatar") required final String tokenAvatar,
          @JsonKey(name: "token_name") required final String tokenName,
          @JsonKey(name: "address") required final String address,
          @JsonKey(name: "decimals") required final int decimals}) =
      _$TradeTokenImpl;

  @override
  @JsonKey(name: "chain_id")
  int get chainId; // @JsonKey(name: "chain_name") String chainName,
  @override
  @JsonKey(name: "chain_logo")
  String get chainLogo;
  @override
  @JsonKey(name: "token_avatar")
  String get tokenAvatar;
  @override
  @JsonKey(name: "token_name")
  String get tokenName;
  @override
  @JsonKey(name: "address")
  String get address;
  @override
  @JsonKey(name: "decimals")
  int get decimals;

  /// Create a copy of TradeToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeTokenImplCopyWith<_$TradeTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TradeState {
  TradeStatusMessage get status => throw _privateConstructorUsedError;
  QuoteStatus get quoteStatus => throw _privateConstructorUsedError;
  int get slippage => throw _privateConstructorUsedError;
  int get priorityFee => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  int get fromChainId => throw _privateConstructorUsedError;
  int get toChainId => throw _privateConstructorUsedError;
  TransferQuote? get quote => throw _privateConstructorUsedError;
  List<Token> get availableTokens => throw _privateConstructorUsedError;
  TradeToken? get fromToken => throw _privateConstructorUsedError;
  TradeToken? get toToken => throw _privateConstructorUsedError;

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeStateCopyWith<TradeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeStateCopyWith<$Res> {
  factory $TradeStateCopyWith(
          TradeState value, $Res Function(TradeState) then) =
      _$TradeStateCopyWithImpl<$Res, TradeState>;
  @useResult
  $Res call(
      {TradeStatusMessage status,
      QuoteStatus quoteStatus,
      int slippage,
      int priorityFee,
      String amount,
      int fromChainId,
      int toChainId,
      TransferQuote? quote,
      List<Token> availableTokens,
      TradeToken? fromToken,
      TradeToken? toToken});

  $TradeStatusMessageCopyWith<$Res> get status;
  $QuoteStatusCopyWith<$Res> get quoteStatus;
  $TransferQuoteCopyWith<$Res>? get quote;
  $TradeTokenCopyWith<$Res>? get fromToken;
  $TradeTokenCopyWith<$Res>? get toToken;
}

/// @nodoc
class _$TradeStateCopyWithImpl<$Res, $Val extends TradeState>
    implements $TradeStateCopyWith<$Res> {
  _$TradeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? quoteStatus = null,
    Object? slippage = null,
    Object? priorityFee = null,
    Object? amount = null,
    Object? fromChainId = null,
    Object? toChainId = null,
    Object? quote = freezed,
    Object? availableTokens = null,
    Object? fromToken = freezed,
    Object? toToken = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TradeStatusMessage,
      quoteStatus: null == quoteStatus
          ? _value.quoteStatus
          : quoteStatus // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int,
      priorityFee: null == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      fromChainId: null == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int,
      toChainId: null == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as int,
      quote: freezed == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as TransferQuote?,
      availableTokens: null == availableTokens
          ? _value.availableTokens
          : availableTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
      fromToken: freezed == fromToken
          ? _value.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as TradeToken?,
      toToken: freezed == toToken
          ? _value.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as TradeToken?,
    ) as $Val);
  }

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeStatusMessageCopyWith<$Res> get status {
    return $TradeStatusMessageCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteStatusCopyWith<$Res> get quoteStatus {
    return $QuoteStatusCopyWith<$Res>(_value.quoteStatus, (value) {
      return _then(_value.copyWith(quoteStatus: value) as $Val);
    });
  }

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferQuoteCopyWith<$Res>? get quote {
    if (_value.quote == null) {
      return null;
    }

    return $TransferQuoteCopyWith<$Res>(_value.quote!, (value) {
      return _then(_value.copyWith(quote: value) as $Val);
    });
  }

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeTokenCopyWith<$Res>? get fromToken {
    if (_value.fromToken == null) {
      return null;
    }

    return $TradeTokenCopyWith<$Res>(_value.fromToken!, (value) {
      return _then(_value.copyWith(fromToken: value) as $Val);
    });
  }

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeTokenCopyWith<$Res>? get toToken {
    if (_value.toToken == null) {
      return null;
    }

    return $TradeTokenCopyWith<$Res>(_value.toToken!, (value) {
      return _then(_value.copyWith(toToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeStateImplCopyWith<$Res>
    implements $TradeStateCopyWith<$Res> {
  factory _$$TradeStateImplCopyWith(
          _$TradeStateImpl value, $Res Function(_$TradeStateImpl) then) =
      __$$TradeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TradeStatusMessage status,
      QuoteStatus quoteStatus,
      int slippage,
      int priorityFee,
      String amount,
      int fromChainId,
      int toChainId,
      TransferQuote? quote,
      List<Token> availableTokens,
      TradeToken? fromToken,
      TradeToken? toToken});

  @override
  $TradeStatusMessageCopyWith<$Res> get status;
  @override
  $QuoteStatusCopyWith<$Res> get quoteStatus;
  @override
  $TransferQuoteCopyWith<$Res>? get quote;
  @override
  $TradeTokenCopyWith<$Res>? get fromToken;
  @override
  $TradeTokenCopyWith<$Res>? get toToken;
}

/// @nodoc
class __$$TradeStateImplCopyWithImpl<$Res>
    extends _$TradeStateCopyWithImpl<$Res, _$TradeStateImpl>
    implements _$$TradeStateImplCopyWith<$Res> {
  __$$TradeStateImplCopyWithImpl(
      _$TradeStateImpl _value, $Res Function(_$TradeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? quoteStatus = null,
    Object? slippage = null,
    Object? priorityFee = null,
    Object? amount = null,
    Object? fromChainId = null,
    Object? toChainId = null,
    Object? quote = freezed,
    Object? availableTokens = null,
    Object? fromToken = freezed,
    Object? toToken = freezed,
  }) {
    return _then(_$TradeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TradeStatusMessage,
      quoteStatus: null == quoteStatus
          ? _value.quoteStatus
          : quoteStatus // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int,
      priorityFee: null == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      fromChainId: null == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int,
      toChainId: null == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as int,
      quote: freezed == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as TransferQuote?,
      availableTokens: null == availableTokens
          ? _value._availableTokens
          : availableTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
      fromToken: freezed == fromToken
          ? _value.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as TradeToken?,
      toToken: freezed == toToken
          ? _value.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as TradeToken?,
    ));
  }
}

/// @nodoc

class _$TradeStateImpl implements _TradeState {
  const _$TradeStateImpl(
      {this.status = const TradeStatusMessage.initial(),
      this.quoteStatus = const QuoteStatus.initial(),
      this.slippage = 100,
      this.priorityFee = 0,
      this.amount = "0",
      this.fromChainId = 56,
      this.toChainId = 56,
      this.quote = null,
      final List<Token> availableTokens = const [],
      this.fromToken = null,
      this.toToken = null})
      : _availableTokens = availableTokens;

  @override
  @JsonKey()
  final TradeStatusMessage status;
  @override
  @JsonKey()
  final QuoteStatus quoteStatus;
  @override
  @JsonKey()
  final int slippage;
  @override
  @JsonKey()
  final int priorityFee;
  @override
  @JsonKey()
  final String amount;
  @override
  @JsonKey()
  final int fromChainId;
  @override
  @JsonKey()
  final int toChainId;
  @override
  @JsonKey()
  final TransferQuote? quote;
  final List<Token> _availableTokens;
  @override
  @JsonKey()
  List<Token> get availableTokens {
    if (_availableTokens is EqualUnmodifiableListView) return _availableTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTokens);
  }

  @override
  @JsonKey()
  final TradeToken? fromToken;
  @override
  @JsonKey()
  final TradeToken? toToken;

  @override
  String toString() {
    return 'TradeState(status: $status, quoteStatus: $quoteStatus, slippage: $slippage, priorityFee: $priorityFee, amount: $amount, fromChainId: $fromChainId, toChainId: $toChainId, quote: $quote, availableTokens: $availableTokens, fromToken: $fromToken, toToken: $toToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quoteStatus, quoteStatus) ||
                other.quoteStatus == quoteStatus) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.priorityFee, priorityFee) ||
                other.priorityFee == priorityFee) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fromChainId, fromChainId) ||
                other.fromChainId == fromChainId) &&
            (identical(other.toChainId, toChainId) ||
                other.toChainId == toChainId) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            const DeepCollectionEquality()
                .equals(other._availableTokens, _availableTokens) &&
            (identical(other.fromToken, fromToken) ||
                other.fromToken == fromToken) &&
            (identical(other.toToken, toToken) || other.toToken == toToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      quoteStatus,
      slippage,
      priorityFee,
      amount,
      fromChainId,
      toChainId,
      quote,
      const DeepCollectionEquality().hash(_availableTokens),
      fromToken,
      toToken);

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeStateImplCopyWith<_$TradeStateImpl> get copyWith =>
      __$$TradeStateImplCopyWithImpl<_$TradeStateImpl>(this, _$identity);
}

abstract class _TradeState implements TradeState {
  const factory _TradeState(
      {final TradeStatusMessage status,
      final QuoteStatus quoteStatus,
      final int slippage,
      final int priorityFee,
      final String amount,
      final int fromChainId,
      final int toChainId,
      final TransferQuote? quote,
      final List<Token> availableTokens,
      final TradeToken? fromToken,
      final TradeToken? toToken}) = _$TradeStateImpl;

  @override
  TradeStatusMessage get status;
  @override
  QuoteStatus get quoteStatus;
  @override
  int get slippage;
  @override
  int get priorityFee;
  @override
  String get amount;
  @override
  int get fromChainId;
  @override
  int get toChainId;
  @override
  TransferQuote? get quote;
  @override
  List<Token> get availableTokens;
  @override
  TradeToken? get fromToken;
  @override
  TradeToken? get toToken;

  /// Create a copy of TradeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeStateImplCopyWith<_$TradeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
