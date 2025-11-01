// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoriteTokenListStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteToken> tokens) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteToken> tokens)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteToken> tokens)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial value) initial,
    required TResult Function(_ListLoading value) loading,
    required TResult Function(ListSuccess value) success,
    required TResult Function(ListError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial value)? initial,
    TResult? Function(_ListLoading value)? loading,
    TResult? Function(ListSuccess value)? success,
    TResult? Function(ListError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial value)? initial,
    TResult Function(_ListLoading value)? loading,
    TResult Function(ListSuccess value)? success,
    TResult Function(ListError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteTokenListStatusCopyWith<$Res> {
  factory $FavoriteTokenListStatusCopyWith(FavoriteTokenListStatus value,
          $Res Function(FavoriteTokenListStatus) then) =
      _$FavoriteTokenListStatusCopyWithImpl<$Res, FavoriteTokenListStatus>;
}

/// @nodoc
class _$FavoriteTokenListStatusCopyWithImpl<$Res,
        $Val extends FavoriteTokenListStatus>
    implements $FavoriteTokenListStatusCopyWith<$Res> {
  _$FavoriteTokenListStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ListInitialImplCopyWith<$Res> {
  factory _$$ListInitialImplCopyWith(
          _$ListInitialImpl value, $Res Function(_$ListInitialImpl) then) =
      __$$ListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListInitialImplCopyWithImpl<$Res>
    extends _$FavoriteTokenListStatusCopyWithImpl<$Res, _$ListInitialImpl>
    implements _$$ListInitialImplCopyWith<$Res> {
  __$$ListInitialImplCopyWithImpl(
      _$ListInitialImpl _value, $Res Function(_$ListInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListInitialImpl implements _ListInitial {
  const _$ListInitialImpl();

  @override
  String toString() {
    return 'FavoriteTokenListStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteToken> tokens)? success,
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
    required TResult Function(_ListInitial value) initial,
    required TResult Function(_ListLoading value) loading,
    required TResult Function(ListSuccess value) success,
    required TResult Function(ListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial value)? initial,
    TResult? Function(_ListLoading value)? loading,
    TResult? Function(ListSuccess value)? success,
    TResult? Function(ListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial value)? initial,
    TResult Function(_ListLoading value)? loading,
    TResult Function(ListSuccess value)? success,
    TResult Function(ListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ListInitial implements FavoriteTokenListStatus {
  const factory _ListInitial() = _$ListInitialImpl;
}

/// @nodoc
abstract class _$$ListLoadingImplCopyWith<$Res> {
  factory _$$ListLoadingImplCopyWith(
          _$ListLoadingImpl value, $Res Function(_$ListLoadingImpl) then) =
      __$$ListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListLoadingImplCopyWithImpl<$Res>
    extends _$FavoriteTokenListStatusCopyWithImpl<$Res, _$ListLoadingImpl>
    implements _$$ListLoadingImplCopyWith<$Res> {
  __$$ListLoadingImplCopyWithImpl(
      _$ListLoadingImpl _value, $Res Function(_$ListLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListLoadingImpl implements _ListLoading {
  const _$ListLoadingImpl();

  @override
  String toString() {
    return 'FavoriteTokenListStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteToken> tokens)? success,
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
    required TResult Function(_ListInitial value) initial,
    required TResult Function(_ListLoading value) loading,
    required TResult Function(ListSuccess value) success,
    required TResult Function(ListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial value)? initial,
    TResult? Function(_ListLoading value)? loading,
    TResult? Function(ListSuccess value)? success,
    TResult? Function(ListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial value)? initial,
    TResult Function(_ListLoading value)? loading,
    TResult Function(ListSuccess value)? success,
    TResult Function(ListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ListLoading implements FavoriteTokenListStatus {
  const factory _ListLoading() = _$ListLoadingImpl;
}

/// @nodoc
abstract class _$$ListSuccessImplCopyWith<$Res> {
  factory _$$ListSuccessImplCopyWith(
          _$ListSuccessImpl value, $Res Function(_$ListSuccessImpl) then) =
      __$$ListSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FavoriteToken> tokens});
}

/// @nodoc
class __$$ListSuccessImplCopyWithImpl<$Res>
    extends _$FavoriteTokenListStatusCopyWithImpl<$Res, _$ListSuccessImpl>
    implements _$$ListSuccessImplCopyWith<$Res> {
  __$$ListSuccessImplCopyWithImpl(
      _$ListSuccessImpl _value, $Res Function(_$ListSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
  }) {
    return _then(_$ListSuccessImpl(
      null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<FavoriteToken>,
    ));
  }
}

/// @nodoc

class _$ListSuccessImpl implements ListSuccess {
  const _$ListSuccessImpl(final List<FavoriteToken> tokens) : _tokens = tokens;

  final List<FavoriteToken> _tokens;
  @override
  List<FavoriteToken> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString() {
    return 'FavoriteTokenListStatus.success(tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListSuccessImpl &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListSuccessImplCopyWith<_$ListSuccessImpl> get copyWith =>
      __$$ListSuccessImplCopyWithImpl<_$ListSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return success(tokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(tokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteToken> tokens)? success,
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
    required TResult Function(_ListInitial value) initial,
    required TResult Function(_ListLoading value) loading,
    required TResult Function(ListSuccess value) success,
    required TResult Function(ListError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial value)? initial,
    TResult? Function(_ListLoading value)? loading,
    TResult? Function(ListSuccess value)? success,
    TResult? Function(ListError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial value)? initial,
    TResult Function(_ListLoading value)? loading,
    TResult Function(ListSuccess value)? success,
    TResult Function(ListError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ListSuccess implements FavoriteTokenListStatus {
  const factory ListSuccess(final List<FavoriteToken> tokens) =
      _$ListSuccessImpl;

  List<FavoriteToken> get tokens;
  @JsonKey(ignore: true)
  _$$ListSuccessImplCopyWith<_$ListSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListErrorImplCopyWith<$Res> {
  factory _$$ListErrorImplCopyWith(
          _$ListErrorImpl value, $Res Function(_$ListErrorImpl) then) =
      __$$ListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ListErrorImplCopyWithImpl<$Res>
    extends _$FavoriteTokenListStatusCopyWithImpl<$Res, _$ListErrorImpl>
    implements _$$ListErrorImplCopyWith<$Res> {
  __$$ListErrorImplCopyWithImpl(
      _$ListErrorImpl _value, $Res Function(_$ListErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ListErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ListErrorImpl implements ListError {
  const _$ListErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FavoriteTokenListStatus.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListErrorImplCopyWith<_$ListErrorImpl> get copyWith =>
      __$$ListErrorImplCopyWithImpl<_$ListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteToken> tokens) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteToken> tokens)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteToken> tokens)? success,
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
    required TResult Function(_ListInitial value) initial,
    required TResult Function(_ListLoading value) loading,
    required TResult Function(ListSuccess value) success,
    required TResult Function(ListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial value)? initial,
    TResult? Function(_ListLoading value)? loading,
    TResult? Function(ListSuccess value)? success,
    TResult? Function(ListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial value)? initial,
    TResult Function(_ListLoading value)? loading,
    TResult Function(ListSuccess value)? success,
    TResult Function(ListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ListError implements FavoriteTokenListStatus {
  const factory ListError(final String message) = _$ListErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ListErrorImplCopyWith<_$ListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FavoriteTokenActionStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteTokenActionStatusCopyWith<$Res> {
  factory $FavoriteTokenActionStatusCopyWith(FavoriteTokenActionStatus value,
          $Res Function(FavoriteTokenActionStatus) then) =
      _$FavoriteTokenActionStatusCopyWithImpl<$Res, FavoriteTokenActionStatus>;
}

/// @nodoc
class _$FavoriteTokenActionStatusCopyWithImpl<$Res,
        $Val extends FavoriteTokenActionStatus>
    implements $FavoriteTokenActionStatusCopyWith<$Res> {
  _$FavoriteTokenActionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActionIdleImplCopyWith<$Res> {
  factory _$$ActionIdleImplCopyWith(
          _$ActionIdleImpl value, $Res Function(_$ActionIdleImpl) then) =
      __$$ActionIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionIdleImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionIdleImpl>
    implements _$$ActionIdleImplCopyWith<$Res> {
  __$$ActionIdleImplCopyWithImpl(
      _$ActionIdleImpl _value, $Res Function(_$ActionIdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActionIdleImpl implements ActionIdle {
  const _$ActionIdleImpl();

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ActionIdle implements FavoriteTokenActionStatus {
  const factory ActionIdle() = _$ActionIdleImpl;
}

/// @nodoc
abstract class _$$ActionAddingImplCopyWith<$Res> {
  factory _$$ActionAddingImplCopyWith(
          _$ActionAddingImpl value, $Res Function(_$ActionAddingImpl) then) =
      __$$ActionAddingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionAddingImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionAddingImpl>
    implements _$$ActionAddingImplCopyWith<$Res> {
  __$$ActionAddingImplCopyWithImpl(
      _$ActionAddingImpl _value, $Res Function(_$ActionAddingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActionAddingImpl implements ActionAdding {
  const _$ActionAddingImpl();

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.adding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionAddingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return adding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return adding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return adding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return adding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding(this);
    }
    return orElse();
  }
}

abstract class ActionAdding implements FavoriteTokenActionStatus {
  const factory ActionAdding() = _$ActionAddingImpl;
}

/// @nodoc
abstract class _$$ActionRemovingImplCopyWith<$Res> {
  factory _$$ActionRemovingImplCopyWith(_$ActionRemovingImpl value,
          $Res Function(_$ActionRemovingImpl) then) =
      __$$ActionRemovingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionRemovingImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionRemovingImpl>
    implements _$$ActionRemovingImplCopyWith<$Res> {
  __$$ActionRemovingImplCopyWithImpl(
      _$ActionRemovingImpl _value, $Res Function(_$ActionRemovingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActionRemovingImpl implements ActionRemoving {
  const _$ActionRemovingImpl();

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.removing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionRemovingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return removing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return removing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (removing != null) {
      return removing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return removing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return removing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (removing != null) {
      return removing(this);
    }
    return orElse();
  }
}

abstract class ActionRemoving implements FavoriteTokenActionStatus {
  const factory ActionRemoving() = _$ActionRemovingImpl;
}

/// @nodoc
abstract class _$$ActionPinningImplCopyWith<$Res> {
  factory _$$ActionPinningImplCopyWith(
          _$ActionPinningImpl value, $Res Function(_$ActionPinningImpl) then) =
      __$$ActionPinningImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionPinningImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionPinningImpl>
    implements _$$ActionPinningImplCopyWith<$Res> {
  __$$ActionPinningImplCopyWithImpl(
      _$ActionPinningImpl _value, $Res Function(_$ActionPinningImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActionPinningImpl implements ActionPinning {
  const _$ActionPinningImpl();

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.pinning()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionPinningImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return pinning();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return pinning?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (pinning != null) {
      return pinning();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return pinning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return pinning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (pinning != null) {
      return pinning(this);
    }
    return orElse();
  }
}

abstract class ActionPinning implements FavoriteTokenActionStatus {
  const factory ActionPinning() = _$ActionPinningImpl;
}

/// @nodoc
abstract class _$$ActionSuccessImplCopyWith<$Res> {
  factory _$$ActionSuccessImplCopyWith(
          _$ActionSuccessImpl value, $Res Function(_$ActionSuccessImpl) then) =
      __$$ActionSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionSuccessImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionSuccessImpl>
    implements _$$ActionSuccessImplCopyWith<$Res> {
  __$$ActionSuccessImplCopyWithImpl(
      _$ActionSuccessImpl _value, $Res Function(_$ActionSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActionSuccessImpl implements ActionSuccess {
  const _$ActionSuccessImpl();

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
    TResult Function(String message)? error,
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
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ActionSuccess implements FavoriteTokenActionStatus {
  const factory ActionSuccess() = _$ActionSuccessImpl;
}

/// @nodoc
abstract class _$$ActionErrorImplCopyWith<$Res> {
  factory _$$ActionErrorImplCopyWith(
          _$ActionErrorImpl value, $Res Function(_$ActionErrorImpl) then) =
      __$$ActionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ActionErrorImplCopyWithImpl<$Res>
    extends _$FavoriteTokenActionStatusCopyWithImpl<$Res, _$ActionErrorImpl>
    implements _$$ActionErrorImplCopyWith<$Res> {
  __$$ActionErrorImplCopyWithImpl(
      _$ActionErrorImpl _value, $Res Function(_$ActionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ActionErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ActionErrorImpl implements ActionError {
  const _$ActionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FavoriteTokenActionStatus.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionErrorImplCopyWith<_$ActionErrorImpl> get copyWith =>
      __$$ActionErrorImplCopyWithImpl<_$ActionErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() adding,
    required TResult Function() removing,
    required TResult Function() pinning,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? adding,
    TResult? Function()? removing,
    TResult? Function()? pinning,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? adding,
    TResult Function()? removing,
    TResult Function()? pinning,
    TResult Function()? success,
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
    required TResult Function(ActionIdle value) idle,
    required TResult Function(ActionAdding value) adding,
    required TResult Function(ActionRemoving value) removing,
    required TResult Function(ActionPinning value) pinning,
    required TResult Function(ActionSuccess value) success,
    required TResult Function(ActionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActionIdle value)? idle,
    TResult? Function(ActionAdding value)? adding,
    TResult? Function(ActionRemoving value)? removing,
    TResult? Function(ActionPinning value)? pinning,
    TResult? Function(ActionSuccess value)? success,
    TResult? Function(ActionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActionIdle value)? idle,
    TResult Function(ActionAdding value)? adding,
    TResult Function(ActionRemoving value)? removing,
    TResult Function(ActionPinning value)? pinning,
    TResult Function(ActionSuccess value)? success,
    TResult Function(ActionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ActionError implements FavoriteTokenActionStatus {
  const factory ActionError(final String message) = _$ActionErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ActionErrorImplCopyWith<_$ActionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FavoriteTokenState {
  List<FavoriteToken> get tokens => throw _privateConstructorUsedError;
  List<FavoriteToken> get favoriteTokens => throw _privateConstructorUsedError;
  FavoriteTokenListStatus get listStatus => throw _privateConstructorUsedError;
  FavoriteTokenActionStatus get actionStatus =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoriteTokenStateCopyWith<FavoriteTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteTokenStateCopyWith<$Res> {
  factory $FavoriteTokenStateCopyWith(
          FavoriteTokenState value, $Res Function(FavoriteTokenState) then) =
      _$FavoriteTokenStateCopyWithImpl<$Res, FavoriteTokenState>;
  @useResult
  $Res call(
      {List<FavoriteToken> tokens,
      List<FavoriteToken> favoriteTokens,
      FavoriteTokenListStatus listStatus,
      FavoriteTokenActionStatus actionStatus});

  $FavoriteTokenListStatusCopyWith<$Res> get listStatus;
  $FavoriteTokenActionStatusCopyWith<$Res> get actionStatus;
}

/// @nodoc
class _$FavoriteTokenStateCopyWithImpl<$Res, $Val extends FavoriteTokenState>
    implements $FavoriteTokenStateCopyWith<$Res> {
  _$FavoriteTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? favoriteTokens = null,
    Object? listStatus = null,
    Object? actionStatus = null,
  }) {
    return _then(_value.copyWith(
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<FavoriteToken>,
      favoriteTokens: null == favoriteTokens
          ? _value.favoriteTokens
          : favoriteTokens // ignore: cast_nullable_to_non_nullable
              as List<FavoriteToken>,
      listStatus: null == listStatus
          ? _value.listStatus
          : listStatus // ignore: cast_nullable_to_non_nullable
              as FavoriteTokenListStatus,
      actionStatus: null == actionStatus
          ? _value.actionStatus
          : actionStatus // ignore: cast_nullable_to_non_nullable
              as FavoriteTokenActionStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FavoriteTokenListStatusCopyWith<$Res> get listStatus {
    return $FavoriteTokenListStatusCopyWith<$Res>(_value.listStatus, (value) {
      return _then(_value.copyWith(listStatus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FavoriteTokenActionStatusCopyWith<$Res> get actionStatus {
    return $FavoriteTokenActionStatusCopyWith<$Res>(_value.actionStatus,
        (value) {
      return _then(_value.copyWith(actionStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FavoriteTokenStateImplCopyWith<$Res>
    implements $FavoriteTokenStateCopyWith<$Res> {
  factory _$$FavoriteTokenStateImplCopyWith(_$FavoriteTokenStateImpl value,
          $Res Function(_$FavoriteTokenStateImpl) then) =
      __$$FavoriteTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FavoriteToken> tokens,
      List<FavoriteToken> favoriteTokens,
      FavoriteTokenListStatus listStatus,
      FavoriteTokenActionStatus actionStatus});

  @override
  $FavoriteTokenListStatusCopyWith<$Res> get listStatus;
  @override
  $FavoriteTokenActionStatusCopyWith<$Res> get actionStatus;
}

/// @nodoc
class __$$FavoriteTokenStateImplCopyWithImpl<$Res>
    extends _$FavoriteTokenStateCopyWithImpl<$Res, _$FavoriteTokenStateImpl>
    implements _$$FavoriteTokenStateImplCopyWith<$Res> {
  __$$FavoriteTokenStateImplCopyWithImpl(_$FavoriteTokenStateImpl _value,
      $Res Function(_$FavoriteTokenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? favoriteTokens = null,
    Object? listStatus = null,
    Object? actionStatus = null,
  }) {
    return _then(_$FavoriteTokenStateImpl(
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<FavoriteToken>,
      favoriteTokens: null == favoriteTokens
          ? _value._favoriteTokens
          : favoriteTokens // ignore: cast_nullable_to_non_nullable
              as List<FavoriteToken>,
      listStatus: null == listStatus
          ? _value.listStatus
          : listStatus // ignore: cast_nullable_to_non_nullable
              as FavoriteTokenListStatus,
      actionStatus: null == actionStatus
          ? _value.actionStatus
          : actionStatus // ignore: cast_nullable_to_non_nullable
              as FavoriteTokenActionStatus,
    ));
  }
}

/// @nodoc

class _$FavoriteTokenStateImpl implements _FavoriteTokenState {
  const _$FavoriteTokenStateImpl(
      {final List<FavoriteToken> tokens = const [],
      final List<FavoriteToken> favoriteTokens = const [],
      this.listStatus = const FavoriteTokenListStatus.initial(),
      this.actionStatus = const FavoriteTokenActionStatus.idle()})
      : _tokens = tokens,
        _favoriteTokens = favoriteTokens;

  final List<FavoriteToken> _tokens;
  @override
  @JsonKey()
  List<FavoriteToken> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  final List<FavoriteToken> _favoriteTokens;
  @override
  @JsonKey()
  List<FavoriteToken> get favoriteTokens {
    if (_favoriteTokens is EqualUnmodifiableListView) return _favoriteTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteTokens);
  }

  @override
  @JsonKey()
  final FavoriteTokenListStatus listStatus;
  @override
  @JsonKey()
  final FavoriteTokenActionStatus actionStatus;

  @override
  String toString() {
    return 'FavoriteTokenState(tokens: $tokens, favoriteTokens: $favoriteTokens, listStatus: $listStatus, actionStatus: $actionStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteTokenStateImpl &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            const DeepCollectionEquality()
                .equals(other._favoriteTokens, _favoriteTokens) &&
            (identical(other.listStatus, listStatus) ||
                other.listStatus == listStatus) &&
            (identical(other.actionStatus, actionStatus) ||
                other.actionStatus == actionStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tokens),
      const DeepCollectionEquality().hash(_favoriteTokens),
      listStatus,
      actionStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteTokenStateImplCopyWith<_$FavoriteTokenStateImpl> get copyWith =>
      __$$FavoriteTokenStateImplCopyWithImpl<_$FavoriteTokenStateImpl>(
          this, _$identity);
}

abstract class _FavoriteTokenState implements FavoriteTokenState {
  const factory _FavoriteTokenState(
      {final List<FavoriteToken> tokens,
      final List<FavoriteToken> favoriteTokens,
      final FavoriteTokenListStatus listStatus,
      final FavoriteTokenActionStatus actionStatus}) = _$FavoriteTokenStateImpl;

  @override
  List<FavoriteToken> get tokens;
  @override
  List<FavoriteToken> get favoriteTokens;
  @override
  FavoriteTokenListStatus get listStatus;
  @override
  FavoriteTokenActionStatus get actionStatus;
  @override
  @JsonKey(ignore: true)
  _$$FavoriteTokenStateImplCopyWith<_$FavoriteTokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
