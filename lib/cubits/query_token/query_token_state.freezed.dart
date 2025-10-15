// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QueryTokenStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QueryToken> tokens) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QueryToken> tokens)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QueryToken> tokens)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QueryTokenInitial value) initial,
    required TResult Function(_QueryTokenLoading value) loading,
    required TResult Function(_QueryTokenSuccess value) success,
    required TResult Function(_QueryTokenError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QueryTokenInitial value)? initial,
    TResult? Function(_QueryTokenLoading value)? loading,
    TResult? Function(_QueryTokenSuccess value)? success,
    TResult? Function(_QueryTokenError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QueryTokenInitial value)? initial,
    TResult Function(_QueryTokenLoading value)? loading,
    TResult Function(_QueryTokenSuccess value)? success,
    TResult Function(_QueryTokenError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryTokenStatusCopyWith<$Res> {
  factory $QueryTokenStatusCopyWith(
          QueryTokenStatus value, $Res Function(QueryTokenStatus) then) =
      _$QueryTokenStatusCopyWithImpl<$Res, QueryTokenStatus>;
}

/// @nodoc
class _$QueryTokenStatusCopyWithImpl<$Res, $Val extends QueryTokenStatus>
    implements $QueryTokenStatusCopyWith<$Res> {
  _$QueryTokenStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$QueryTokenInitialImplCopyWith<$Res> {
  factory _$$QueryTokenInitialImplCopyWith(_$QueryTokenInitialImpl value,
          $Res Function(_$QueryTokenInitialImpl) then) =
      __$$QueryTokenInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QueryTokenInitialImplCopyWithImpl<$Res>
    extends _$QueryTokenStatusCopyWithImpl<$Res, _$QueryTokenInitialImpl>
    implements _$$QueryTokenInitialImplCopyWith<$Res> {
  __$$QueryTokenInitialImplCopyWithImpl(_$QueryTokenInitialImpl _value,
      $Res Function(_$QueryTokenInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QueryTokenInitialImpl implements _QueryTokenInitial {
  const _$QueryTokenInitialImpl();

  @override
  String toString() {
    return 'QueryTokenStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QueryTokenInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QueryToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QueryToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QueryToken> tokens)? success,
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
    required TResult Function(_QueryTokenInitial value) initial,
    required TResult Function(_QueryTokenLoading value) loading,
    required TResult Function(_QueryTokenSuccess value) success,
    required TResult Function(_QueryTokenError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QueryTokenInitial value)? initial,
    TResult? Function(_QueryTokenLoading value)? loading,
    TResult? Function(_QueryTokenSuccess value)? success,
    TResult? Function(_QueryTokenError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QueryTokenInitial value)? initial,
    TResult Function(_QueryTokenLoading value)? loading,
    TResult Function(_QueryTokenSuccess value)? success,
    TResult Function(_QueryTokenError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _QueryTokenInitial implements QueryTokenStatus {
  const factory _QueryTokenInitial() = _$QueryTokenInitialImpl;
}

/// @nodoc
abstract class _$$QueryTokenLoadingImplCopyWith<$Res> {
  factory _$$QueryTokenLoadingImplCopyWith(_$QueryTokenLoadingImpl value,
          $Res Function(_$QueryTokenLoadingImpl) then) =
      __$$QueryTokenLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QueryTokenLoadingImplCopyWithImpl<$Res>
    extends _$QueryTokenStatusCopyWithImpl<$Res, _$QueryTokenLoadingImpl>
    implements _$$QueryTokenLoadingImplCopyWith<$Res> {
  __$$QueryTokenLoadingImplCopyWithImpl(_$QueryTokenLoadingImpl _value,
      $Res Function(_$QueryTokenLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QueryTokenLoadingImpl implements _QueryTokenLoading {
  const _$QueryTokenLoadingImpl();

  @override
  String toString() {
    return 'QueryTokenStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QueryTokenLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QueryToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QueryToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QueryToken> tokens)? success,
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
    required TResult Function(_QueryTokenInitial value) initial,
    required TResult Function(_QueryTokenLoading value) loading,
    required TResult Function(_QueryTokenSuccess value) success,
    required TResult Function(_QueryTokenError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QueryTokenInitial value)? initial,
    TResult? Function(_QueryTokenLoading value)? loading,
    TResult? Function(_QueryTokenSuccess value)? success,
    TResult? Function(_QueryTokenError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QueryTokenInitial value)? initial,
    TResult Function(_QueryTokenLoading value)? loading,
    TResult Function(_QueryTokenSuccess value)? success,
    TResult Function(_QueryTokenError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _QueryTokenLoading implements QueryTokenStatus {
  const factory _QueryTokenLoading() = _$QueryTokenLoadingImpl;
}

/// @nodoc
abstract class _$$QueryTokenSuccessImplCopyWith<$Res> {
  factory _$$QueryTokenSuccessImplCopyWith(_$QueryTokenSuccessImpl value,
          $Res Function(_$QueryTokenSuccessImpl) then) =
      __$$QueryTokenSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<QueryToken> tokens});
}

/// @nodoc
class __$$QueryTokenSuccessImplCopyWithImpl<$Res>
    extends _$QueryTokenStatusCopyWithImpl<$Res, _$QueryTokenSuccessImpl>
    implements _$$QueryTokenSuccessImplCopyWith<$Res> {
  __$$QueryTokenSuccessImplCopyWithImpl(_$QueryTokenSuccessImpl _value,
      $Res Function(_$QueryTokenSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
  }) {
    return _then(_$QueryTokenSuccessImpl(
      null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<QueryToken>,
    ));
  }
}

/// @nodoc

class _$QueryTokenSuccessImpl implements _QueryTokenSuccess {
  const _$QueryTokenSuccessImpl(final List<QueryToken> tokens)
      : _tokens = tokens;

  final List<QueryToken> _tokens;
  @override
  List<QueryToken> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString() {
    return 'QueryTokenStatus.success(tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryTokenSuccessImpl &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryTokenSuccessImplCopyWith<_$QueryTokenSuccessImpl> get copyWith =>
      __$$QueryTokenSuccessImplCopyWithImpl<_$QueryTokenSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QueryToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return success(tokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QueryToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(tokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QueryToken> tokens)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(tokens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QueryTokenInitial value) initial,
    required TResult Function(_QueryTokenLoading value) loading,
    required TResult Function(_QueryTokenSuccess value) success,
    required TResult Function(_QueryTokenError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QueryTokenInitial value)? initial,
    TResult? Function(_QueryTokenLoading value)? loading,
    TResult? Function(_QueryTokenSuccess value)? success,
    TResult? Function(_QueryTokenError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QueryTokenInitial value)? initial,
    TResult Function(_QueryTokenLoading value)? loading,
    TResult Function(_QueryTokenSuccess value)? success,
    TResult Function(_QueryTokenError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _QueryTokenSuccess implements QueryTokenStatus {
  const factory _QueryTokenSuccess(final List<QueryToken> tokens) =
      _$QueryTokenSuccessImpl;

  List<QueryToken> get tokens;

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryTokenSuccessImplCopyWith<_$QueryTokenSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueryTokenErrorImplCopyWith<$Res> {
  factory _$$QueryTokenErrorImplCopyWith(_$QueryTokenErrorImpl value,
          $Res Function(_$QueryTokenErrorImpl) then) =
      __$$QueryTokenErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$QueryTokenErrorImplCopyWithImpl<$Res>
    extends _$QueryTokenStatusCopyWithImpl<$Res, _$QueryTokenErrorImpl>
    implements _$$QueryTokenErrorImplCopyWith<$Res> {
  __$$QueryTokenErrorImplCopyWithImpl(
      _$QueryTokenErrorImpl _value, $Res Function(_$QueryTokenErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$QueryTokenErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueryTokenErrorImpl implements _QueryTokenError {
  const _$QueryTokenErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'QueryTokenStatus.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryTokenErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryTokenErrorImplCopyWith<_$QueryTokenErrorImpl> get copyWith =>
      __$$QueryTokenErrorImplCopyWithImpl<_$QueryTokenErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QueryToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QueryToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QueryToken> tokens)? success,
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
    required TResult Function(_QueryTokenInitial value) initial,
    required TResult Function(_QueryTokenLoading value) loading,
    required TResult Function(_QueryTokenSuccess value) success,
    required TResult Function(_QueryTokenError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QueryTokenInitial value)? initial,
    TResult? Function(_QueryTokenLoading value)? loading,
    TResult? Function(_QueryTokenSuccess value)? success,
    TResult? Function(_QueryTokenError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QueryTokenInitial value)? initial,
    TResult Function(_QueryTokenLoading value)? loading,
    TResult Function(_QueryTokenSuccess value)? success,
    TResult Function(_QueryTokenError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _QueryTokenError implements QueryTokenStatus {
  const factory _QueryTokenError(final String message) = _$QueryTokenErrorImpl;

  String get message;

  /// Create a copy of QueryTokenStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryTokenErrorImplCopyWith<_$QueryTokenErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QueryTokenState {
  QueryTokenStatus get status => throw _privateConstructorUsedError;
  List<QueryToken> get tokens => throw _privateConstructorUsedError;
  String? get keyWord => throw _privateConstructorUsedError;
  QueryToken? get queryToken => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryTokenStateCopyWith<QueryTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryTokenStateCopyWith<$Res> {
  factory $QueryTokenStateCopyWith(
          QueryTokenState value, $Res Function(QueryTokenState) then) =
      _$QueryTokenStateCopyWithImpl<$Res, QueryTokenState>;
  @useResult
  $Res call(
      {QueryTokenStatus status,
      List<QueryToken> tokens,
      String? keyWord,
      QueryToken? queryToken,
      bool isLoading});

  $QueryTokenStatusCopyWith<$Res> get status;
  $QueryTokenCopyWith<$Res>? get queryToken;
}

/// @nodoc
class _$QueryTokenStateCopyWithImpl<$Res, $Val extends QueryTokenState>
    implements $QueryTokenStateCopyWith<$Res> {
  _$QueryTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tokens = null,
    Object? keyWord = freezed,
    Object? queryToken = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueryTokenStatus,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<QueryToken>,
      keyWord: freezed == keyWord
          ? _value.keyWord
          : keyWord // ignore: cast_nullable_to_non_nullable
              as String?,
      queryToken: freezed == queryToken
          ? _value.queryToken
          : queryToken // ignore: cast_nullable_to_non_nullable
              as QueryToken?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueryTokenStatusCopyWith<$Res> get status {
    return $QueryTokenStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueryTokenCopyWith<$Res>? get queryToken {
    if (_value.queryToken == null) {
      return null;
    }

    return $QueryTokenCopyWith<$Res>(_value.queryToken!, (value) {
      return _then(_value.copyWith(queryToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueryTokenStateImplCopyWith<$Res>
    implements $QueryTokenStateCopyWith<$Res> {
  factory _$$QueryTokenStateImplCopyWith(_$QueryTokenStateImpl value,
          $Res Function(_$QueryTokenStateImpl) then) =
      __$$QueryTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QueryTokenStatus status,
      List<QueryToken> tokens,
      String? keyWord,
      QueryToken? queryToken,
      bool isLoading});

  @override
  $QueryTokenStatusCopyWith<$Res> get status;
  @override
  $QueryTokenCopyWith<$Res>? get queryToken;
}

/// @nodoc
class __$$QueryTokenStateImplCopyWithImpl<$Res>
    extends _$QueryTokenStateCopyWithImpl<$Res, _$QueryTokenStateImpl>
    implements _$$QueryTokenStateImplCopyWith<$Res> {
  __$$QueryTokenStateImplCopyWithImpl(
      _$QueryTokenStateImpl _value, $Res Function(_$QueryTokenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tokens = null,
    Object? keyWord = freezed,
    Object? queryToken = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$QueryTokenStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueryTokenStatus,
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<QueryToken>,
      keyWord: freezed == keyWord
          ? _value.keyWord
          : keyWord // ignore: cast_nullable_to_non_nullable
              as String?,
      queryToken: freezed == queryToken
          ? _value.queryToken
          : queryToken // ignore: cast_nullable_to_non_nullable
              as QueryToken?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$QueryTokenStateImpl implements _QueryTokenState {
  const _$QueryTokenStateImpl(
      {this.status = const QueryTokenStatus.initial(),
      final List<QueryToken> tokens = const [],
      this.keyWord = null,
      this.queryToken = null,
      this.isLoading = false})
      : _tokens = tokens;

  @override
  @JsonKey()
  final QueryTokenStatus status;
  final List<QueryToken> _tokens;
  @override
  @JsonKey()
  List<QueryToken> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  @JsonKey()
  final String? keyWord;
  @override
  @JsonKey()
  final QueryToken? queryToken;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'QueryTokenState(status: $status, tokens: $tokens, keyWord: $keyWord, queryToken: $queryToken, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryTokenStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.keyWord, keyWord) || other.keyWord == keyWord) &&
            (identical(other.queryToken, queryToken) ||
                other.queryToken == queryToken) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_tokens),
      keyWord,
      queryToken,
      isLoading);

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryTokenStateImplCopyWith<_$QueryTokenStateImpl> get copyWith =>
      __$$QueryTokenStateImplCopyWithImpl<_$QueryTokenStateImpl>(
          this, _$identity);
}

abstract class _QueryTokenState implements QueryTokenState {
  const factory _QueryTokenState(
      {final QueryTokenStatus status,
      final List<QueryToken> tokens,
      final String? keyWord,
      final QueryToken? queryToken,
      final bool isLoading}) = _$QueryTokenStateImpl;

  @override
  QueryTokenStatus get status;
  @override
  List<QueryToken> get tokens;
  @override
  String? get keyWord;
  @override
  QueryToken? get queryToken;
  @override
  bool get isLoading;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryTokenStateImplCopyWith<_$QueryTokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
