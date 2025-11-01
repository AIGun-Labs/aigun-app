// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_effect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SoundEffectState {
  SoundEffectStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SoundEffectStateCopyWith<SoundEffectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundEffectStateCopyWith<$Res> {
  factory $SoundEffectStateCopyWith(
          SoundEffectState value, $Res Function(SoundEffectState) then) =
      _$SoundEffectStateCopyWithImpl<$Res, SoundEffectState>;
  @useResult
  $Res call({SoundEffectStatus status});
}

/// @nodoc
class _$SoundEffectStateCopyWithImpl<$Res, $Val extends SoundEffectState>
    implements $SoundEffectStateCopyWith<$Res> {
  _$SoundEffectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SoundEffectStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SoundEffectStateImplCopyWith<$Res>
    implements $SoundEffectStateCopyWith<$Res> {
  factory _$$SoundEffectStateImplCopyWith(_$SoundEffectStateImpl value,
          $Res Function(_$SoundEffectStateImpl) then) =
      __$$SoundEffectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SoundEffectStatus status});
}

/// @nodoc
class __$$SoundEffectStateImplCopyWithImpl<$Res>
    extends _$SoundEffectStateCopyWithImpl<$Res, _$SoundEffectStateImpl>
    implements _$$SoundEffectStateImplCopyWith<$Res> {
  __$$SoundEffectStateImplCopyWithImpl(_$SoundEffectStateImpl _value,
      $Res Function(_$SoundEffectStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$SoundEffectStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SoundEffectStatus,
    ));
  }
}

/// @nodoc

class _$SoundEffectStateImpl implements _SoundEffectState {
  const _$SoundEffectStateImpl({this.status = SoundEffectStatus.initial});

  @override
  @JsonKey()
  final SoundEffectStatus status;

  @override
  String toString() {
    return 'SoundEffectState(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundEffectStateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundEffectStateImplCopyWith<_$SoundEffectStateImpl> get copyWith =>
      __$$SoundEffectStateImplCopyWithImpl<_$SoundEffectStateImpl>(
          this, _$identity);
}

abstract class _SoundEffectState implements SoundEffectState {
  const factory _SoundEffectState({final SoundEffectStatus status}) =
      _$SoundEffectStateImpl;

  @override
  SoundEffectStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$SoundEffectStateImplCopyWith<_$SoundEffectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
