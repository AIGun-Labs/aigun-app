// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hot_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HotTokenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotTokenStateCopyWith<$Res> {
  factory $HotTokenStateCopyWith(
          HotTokenState value, $Res Function(HotTokenState) then) =
      _$HotTokenStateCopyWithImpl<$Res, HotTokenState>;
}

/// @nodoc
class _$HotTokenStateCopyWithImpl<$Res, $Val extends HotTokenState>
    implements $HotTokenStateCopyWith<$Res> {
  _$HotTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HotTokenInitialImplCopyWith<$Res> {
  factory _$$HotTokenInitialImplCopyWith(_$HotTokenInitialImpl value,
          $Res Function(_$HotTokenInitialImpl) then) =
      __$$HotTokenInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HotTokenInitialImplCopyWithImpl<$Res>
    extends _$HotTokenStateCopyWithImpl<$Res, _$HotTokenInitialImpl>
    implements _$$HotTokenInitialImplCopyWith<$Res> {
  __$$HotTokenInitialImplCopyWithImpl(
      _$HotTokenInitialImpl _value, $Res Function(_$HotTokenInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HotTokenInitialImpl implements HotTokenInitial {
  const _$HotTokenInitialImpl();

  @override
  String toString() {
    return 'HotTokenState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HotTokenInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
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
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HotTokenInitial implements HotTokenState {
  const factory HotTokenInitial() = _$HotTokenInitialImpl;
}

/// @nodoc
abstract class _$$HotTokenLoadingImplCopyWith<$Res> {
  factory _$$HotTokenLoadingImplCopyWith(_$HotTokenLoadingImpl value,
          $Res Function(_$HotTokenLoadingImpl) then) =
      __$$HotTokenLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<HotTokenEntity>? previousTokens, String? selectedNetwork});
}

/// @nodoc
class __$$HotTokenLoadingImplCopyWithImpl<$Res>
    extends _$HotTokenStateCopyWithImpl<$Res, _$HotTokenLoadingImpl>
    implements _$$HotTokenLoadingImplCopyWith<$Res> {
  __$$HotTokenLoadingImplCopyWithImpl(
      _$HotTokenLoadingImpl _value, $Res Function(_$HotTokenLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousTokens = freezed,
    Object? selectedNetwork = freezed,
  }) {
    return _then(_$HotTokenLoadingImpl(
      previousTokens: freezed == previousTokens
          ? _value._previousTokens
          : previousTokens // ignore: cast_nullable_to_non_nullable
              as List<HotTokenEntity>?,
      selectedNetwork: freezed == selectedNetwork
          ? _value.selectedNetwork
          : selectedNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HotTokenLoadingImpl implements HotTokenLoading {
  const _$HotTokenLoadingImpl(
      {final List<HotTokenEntity>? previousTokens, this.selectedNetwork})
      : _previousTokens = previousTokens;

  final List<HotTokenEntity>? _previousTokens;
  @override
  List<HotTokenEntity>? get previousTokens {
    final value = _previousTokens;
    if (value == null) return null;
    if (_previousTokens is EqualUnmodifiableListView) return _previousTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 保留旧数据
  @override
  final String? selectedNetwork;

  @override
  String toString() {
    return 'HotTokenState.loading(previousTokens: $previousTokens, selectedNetwork: $selectedNetwork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotTokenLoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._previousTokens, _previousTokens) &&
            (identical(other.selectedNetwork, selectedNetwork) ||
                other.selectedNetwork == selectedNetwork));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_previousTokens), selectedNetwork);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotTokenLoadingImplCopyWith<_$HotTokenLoadingImpl> get copyWith =>
      __$$HotTokenLoadingImplCopyWithImpl<_$HotTokenLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) {
    return loading(previousTokens, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) {
    return loading?.call(previousTokens, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(previousTokens, selectedNetwork);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HotTokenLoading implements HotTokenState {
  const factory HotTokenLoading(
      {final List<HotTokenEntity>? previousTokens,
      final String? selectedNetwork}) = _$HotTokenLoadingImpl;

  List<HotTokenEntity>? get previousTokens; // 保留旧数据
  String? get selectedNetwork;
  @JsonKey(ignore: true)
  _$$HotTokenLoadingImplCopyWith<_$HotTokenLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotTokenLoadedImplCopyWith<$Res> {
  factory _$$HotTokenLoadedImplCopyWith(_$HotTokenLoadedImpl value,
          $Res Function(_$HotTokenLoadedImpl) then) =
      __$$HotTokenLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<HotTokenEntity> tokens, String selectedNetwork});
}

/// @nodoc
class __$$HotTokenLoadedImplCopyWithImpl<$Res>
    extends _$HotTokenStateCopyWithImpl<$Res, _$HotTokenLoadedImpl>
    implements _$$HotTokenLoadedImplCopyWith<$Res> {
  __$$HotTokenLoadedImplCopyWithImpl(
      _$HotTokenLoadedImpl _value, $Res Function(_$HotTokenLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? selectedNetwork = null,
  }) {
    return _then(_$HotTokenLoadedImpl(
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<HotTokenEntity>,
      selectedNetwork: null == selectedNetwork
          ? _value.selectedNetwork
          : selectedNetwork // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HotTokenLoadedImpl implements HotTokenLoaded {
  const _$HotTokenLoadedImpl(
      {required final List<HotTokenEntity> tokens,
      required this.selectedNetwork})
      : _tokens = tokens;

  final List<HotTokenEntity> _tokens;
  @override
  List<HotTokenEntity> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  final String selectedNetwork;

  @override
  String toString() {
    return 'HotTokenState.loaded(tokens: $tokens, selectedNetwork: $selectedNetwork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotTokenLoadedImpl &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.selectedNetwork, selectedNetwork) ||
                other.selectedNetwork == selectedNetwork));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_tokens), selectedNetwork);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotTokenLoadedImplCopyWith<_$HotTokenLoadedImpl> get copyWith =>
      __$$HotTokenLoadedImplCopyWithImpl<_$HotTokenLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) {
    return loaded(tokens, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) {
    return loaded?.call(tokens, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tokens, selectedNetwork);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class HotTokenLoaded implements HotTokenState {
  const factory HotTokenLoaded(
      {required final List<HotTokenEntity> tokens,
      required final String selectedNetwork}) = _$HotTokenLoadedImpl;

  List<HotTokenEntity> get tokens;
  String get selectedNetwork;
  @JsonKey(ignore: true)
  _$$HotTokenLoadedImplCopyWith<_$HotTokenLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotTokenEmptyImplCopyWith<$Res> {
  factory _$$HotTokenEmptyImplCopyWith(
          _$HotTokenEmptyImpl value, $Res Function(_$HotTokenEmptyImpl) then) =
      __$$HotTokenEmptyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedNetwork});
}

/// @nodoc
class __$$HotTokenEmptyImplCopyWithImpl<$Res>
    extends _$HotTokenStateCopyWithImpl<$Res, _$HotTokenEmptyImpl>
    implements _$$HotTokenEmptyImplCopyWith<$Res> {
  __$$HotTokenEmptyImplCopyWithImpl(
      _$HotTokenEmptyImpl _value, $Res Function(_$HotTokenEmptyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedNetwork = null,
  }) {
    return _then(_$HotTokenEmptyImpl(
      selectedNetwork: null == selectedNetwork
          ? _value.selectedNetwork
          : selectedNetwork // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HotTokenEmptyImpl implements HotTokenEmpty {
  const _$HotTokenEmptyImpl({required this.selectedNetwork});

  @override
  final String selectedNetwork;

  @override
  String toString() {
    return 'HotTokenState.empty(selectedNetwork: $selectedNetwork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotTokenEmptyImpl &&
            (identical(other.selectedNetwork, selectedNetwork) ||
                other.selectedNetwork == selectedNetwork));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedNetwork);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotTokenEmptyImplCopyWith<_$HotTokenEmptyImpl> get copyWith =>
      __$$HotTokenEmptyImplCopyWithImpl<_$HotTokenEmptyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) {
    return empty(selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) {
    return empty?.call(selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(selectedNetwork);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class HotTokenEmpty implements HotTokenState {
  const factory HotTokenEmpty({required final String selectedNetwork}) =
      _$HotTokenEmptyImpl;

  String get selectedNetwork;
  @JsonKey(ignore: true)
  _$$HotTokenEmptyImplCopyWith<_$HotTokenEmptyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotTokenErrorImplCopyWith<$Res> {
  factory _$$HotTokenErrorImplCopyWith(
          _$HotTokenErrorImpl value, $Res Function(_$HotTokenErrorImpl) then) =
      __$$HotTokenErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? selectedNetwork});
}

/// @nodoc
class __$$HotTokenErrorImplCopyWithImpl<$Res>
    extends _$HotTokenStateCopyWithImpl<$Res, _$HotTokenErrorImpl>
    implements _$$HotTokenErrorImplCopyWith<$Res> {
  __$$HotTokenErrorImplCopyWithImpl(
      _$HotTokenErrorImpl _value, $Res Function(_$HotTokenErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? selectedNetwork = freezed,
  }) {
    return _then(_$HotTokenErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      selectedNetwork: freezed == selectedNetwork
          ? _value.selectedNetwork
          : selectedNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HotTokenErrorImpl implements HotTokenError {
  const _$HotTokenErrorImpl({required this.message, this.selectedNetwork});

  @override
  final String message;
  @override
  final String? selectedNetwork;

  @override
  String toString() {
    return 'HotTokenState.error(message: $message, selectedNetwork: $selectedNetwork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotTokenErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedNetwork, selectedNetwork) ||
                other.selectedNetwork == selectedNetwork));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, selectedNetwork);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotTokenErrorImplCopyWith<_$HotTokenErrorImpl> get copyWith =>
      __$$HotTokenErrorImplCopyWithImpl<_$HotTokenErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)
        loading,
    required TResult Function(
            List<HotTokenEntity> tokens, String selectedNetwork)
        loaded,
    required TResult Function(String selectedNetwork) empty,
    required TResult Function(String message, String? selectedNetwork) error,
  }) {
    return error(message, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult? Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult? Function(String selectedNetwork)? empty,
    TResult? Function(String message, String? selectedNetwork)? error,
  }) {
    return error?.call(message, selectedNetwork);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<HotTokenEntity>? previousTokens, String? selectedNetwork)?
        loading,
    TResult Function(List<HotTokenEntity> tokens, String selectedNetwork)?
        loaded,
    TResult Function(String selectedNetwork)? empty,
    TResult Function(String message, String? selectedNetwork)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, selectedNetwork);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotTokenInitial value) initial,
    required TResult Function(HotTokenLoading value) loading,
    required TResult Function(HotTokenLoaded value) loaded,
    required TResult Function(HotTokenEmpty value) empty,
    required TResult Function(HotTokenError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotTokenInitial value)? initial,
    TResult? Function(HotTokenLoading value)? loading,
    TResult? Function(HotTokenLoaded value)? loaded,
    TResult? Function(HotTokenEmpty value)? empty,
    TResult? Function(HotTokenError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotTokenInitial value)? initial,
    TResult Function(HotTokenLoading value)? loading,
    TResult Function(HotTokenLoaded value)? loaded,
    TResult Function(HotTokenEmpty value)? empty,
    TResult Function(HotTokenError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HotTokenError implements HotTokenState {
  const factory HotTokenError(
      {required final String message,
      final String? selectedNetwork}) = _$HotTokenErrorImpl;

  String get message;
  String? get selectedNetwork;
  @JsonKey(ignore: true)
  _$$HotTokenErrorImplCopyWith<_$HotTokenErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
