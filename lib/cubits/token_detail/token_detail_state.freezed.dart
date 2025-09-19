// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenDetailState {
  Token? get token => throw _privateConstructorUsedError;

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenDetailStateCopyWith<TokenDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDetailStateCopyWith<$Res> {
  factory $TokenDetailStateCopyWith(
          TokenDetailState value, $Res Function(TokenDetailState) then) =
      _$TokenDetailStateCopyWithImpl<$Res, TokenDetailState>;
  @useResult
  $Res call({Token? token});

  $TokenCopyWith<$Res>? get token;
}

/// @nodoc
class _$TokenDetailStateCopyWithImpl<$Res, $Val extends TokenDetailState>
    implements $TokenDetailStateCopyWith<$Res> {
  _$TokenDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token?,
    ) as $Val);
  }

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res>? get token {
    if (_value.token == null) {
      return null;
    }

    return $TokenCopyWith<$Res>(_value.token!, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenDetailStateImplCopyWith<$Res>
    implements $TokenDetailStateCopyWith<$Res> {
  factory _$$TokenDetailStateImplCopyWith(_$TokenDetailStateImpl value,
          $Res Function(_$TokenDetailStateImpl) then) =
      __$$TokenDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Token? token});

  @override
  $TokenCopyWith<$Res>? get token;
}

/// @nodoc
class __$$TokenDetailStateImplCopyWithImpl<$Res>
    extends _$TokenDetailStateCopyWithImpl<$Res, _$TokenDetailStateImpl>
    implements _$$TokenDetailStateImplCopyWith<$Res> {
  __$$TokenDetailStateImplCopyWithImpl(_$TokenDetailStateImpl _value,
      $Res Function(_$TokenDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_$TokenDetailStateImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token?,
    ));
  }
}

/// @nodoc

class _$TokenDetailStateImpl implements _TokenDetailState {
  const _$TokenDetailStateImpl({this.token = null});

  @override
  @JsonKey()
  final Token? token;

  @override
  String toString() {
    return 'TokenDetailState(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDetailStateImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDetailStateImplCopyWith<_$TokenDetailStateImpl> get copyWith =>
      __$$TokenDetailStateImplCopyWithImpl<_$TokenDetailStateImpl>(
          this, _$identity);
}

abstract class _TokenDetailState implements TokenDetailState {
  const factory _TokenDetailState({final Token? token}) =
      _$TokenDetailStateImpl;

  @override
  Token? get token;

  /// Create a copy of TokenDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenDetailStateImplCopyWith<_$TokenDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
