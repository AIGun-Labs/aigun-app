// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_setting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeSettingState _$TradeSettingStateFromJson(Map<String, dynamic> json) {
  return _TradeSettingState.fromJson(json);
}

/// @nodoc
mixin _$TradeSettingState {
  TradeMode get mode => throw _privateConstructorUsedError;
  Map<String, TradeCustomSetting> get customSettings =>
      throw _privateConstructorUsedError;

  /// Serializes this TradeSettingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSettingStateCopyWith<TradeSettingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSettingStateCopyWith<$Res> {
  factory $TradeSettingStateCopyWith(
          TradeSettingState value, $Res Function(TradeSettingState) then) =
      _$TradeSettingStateCopyWithImpl<$Res, TradeSettingState>;
  @useResult
  $Res call({TradeMode mode, Map<String, TradeCustomSetting> customSettings});
}

/// @nodoc
class _$TradeSettingStateCopyWithImpl<$Res, $Val extends TradeSettingState>
    implements $TradeSettingStateCopyWith<$Res> {
  _$TradeSettingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? customSettings = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TradeMode,
      customSettings: null == customSettings
          ? _value.customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, TradeCustomSetting>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeSettingStateImplCopyWith<$Res>
    implements $TradeSettingStateCopyWith<$Res> {
  factory _$$TradeSettingStateImplCopyWith(_$TradeSettingStateImpl value,
          $Res Function(_$TradeSettingStateImpl) then) =
      __$$TradeSettingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TradeMode mode, Map<String, TradeCustomSetting> customSettings});
}

/// @nodoc
class __$$TradeSettingStateImplCopyWithImpl<$Res>
    extends _$TradeSettingStateCopyWithImpl<$Res, _$TradeSettingStateImpl>
    implements _$$TradeSettingStateImplCopyWith<$Res> {
  __$$TradeSettingStateImplCopyWithImpl(_$TradeSettingStateImpl _value,
      $Res Function(_$TradeSettingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? customSettings = null,
  }) {
    return _then(_$TradeSettingStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TradeMode,
      customSettings: null == customSettings
          ? _value._customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, TradeCustomSetting>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSettingStateImpl implements _TradeSettingState {
  const _$TradeSettingStateImpl(
      {this.mode = TradeMode.lightning,
      required final Map<String, TradeCustomSetting> customSettings})
      : _customSettings = customSettings;

  factory _$TradeSettingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSettingStateImplFromJson(json);

  @override
  @JsonKey()
  final TradeMode mode;
  final Map<String, TradeCustomSetting> _customSettings;
  @override
  Map<String, TradeCustomSetting> get customSettings {
    if (_customSettings is EqualUnmodifiableMapView) return _customSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customSettings);
  }

  @override
  String toString() {
    return 'TradeSettingState(mode: $mode, customSettings: $customSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSettingStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality()
                .equals(other._customSettings, _customSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, mode, const DeepCollectionEquality().hash(_customSettings));

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSettingStateImplCopyWith<_$TradeSettingStateImpl> get copyWith =>
      __$$TradeSettingStateImplCopyWithImpl<_$TradeSettingStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSettingStateImplToJson(
      this,
    );
  }
}

abstract class _TradeSettingState implements TradeSettingState {
  const factory _TradeSettingState(
          {final TradeMode mode,
          required final Map<String, TradeCustomSetting> customSettings}) =
      _$TradeSettingStateImpl;

  factory _TradeSettingState.fromJson(Map<String, dynamic> json) =
      _$TradeSettingStateImpl.fromJson;

  @override
  TradeMode get mode;
  @override
  Map<String, TradeCustomSetting> get customSettings;

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSettingStateImplCopyWith<_$TradeSettingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
