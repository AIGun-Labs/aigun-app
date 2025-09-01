// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chain_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChainState {
  List<Chain> get chains => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  /// Create a copy of ChainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChainStateCopyWith<ChainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChainStateCopyWith<$Res> {
  factory $ChainStateCopyWith(
          ChainState value, $Res Function(ChainState) then) =
      _$ChainStateCopyWithImpl<$Res, ChainState>;
  @useResult
  $Res call({List<Chain> chains, bool isLoading, String error});
}

/// @nodoc
class _$ChainStateCopyWithImpl<$Res, $Val extends ChainState>
    implements $ChainStateCopyWith<$Res> {
  _$ChainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      chains: null == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<Chain>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChainStateImplCopyWith<$Res>
    implements $ChainStateCopyWith<$Res> {
  factory _$$ChainStateImplCopyWith(
          _$ChainStateImpl value, $Res Function(_$ChainStateImpl) then) =
      __$$ChainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Chain> chains, bool isLoading, String error});
}

/// @nodoc
class __$$ChainStateImplCopyWithImpl<$Res>
    extends _$ChainStateCopyWithImpl<$Res, _$ChainStateImpl>
    implements _$$ChainStateImplCopyWith<$Res> {
  __$$ChainStateImplCopyWithImpl(
      _$ChainStateImpl _value, $Res Function(_$ChainStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_$ChainStateImpl(
      chains: null == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<Chain>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChainStateImpl implements _ChainState {
  const _$ChainStateImpl(
      {final List<Chain> chains = const [],
      this.isLoading = false,
      this.error = ''})
      : _chains = chains;

  final List<Chain> _chains;
  @override
  @JsonKey()
  List<Chain> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'ChainState(chains: $chains, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChainStateImpl &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_chains), isLoading, error);

  /// Create a copy of ChainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChainStateImplCopyWith<_$ChainStateImpl> get copyWith =>
      __$$ChainStateImplCopyWithImpl<_$ChainStateImpl>(this, _$identity);
}

abstract class _ChainState implements ChainState {
  const factory _ChainState(
      {final List<Chain> chains,
      final bool isLoading,
      final String error}) = _$ChainStateImpl;

  @override
  List<Chain> get chains;
  @override
  bool get isLoading;
  @override
  String get error;

  /// Create a copy of ChainState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChainStateImplCopyWith<_$ChainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
