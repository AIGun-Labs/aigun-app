// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeConfig _$TradeConfigFromJson(Map<String, dynamic> json) {
  return _TradeConfig.fromJson(json);
}

/// @nodoc
mixin _$TradeConfig {
  @JsonKey(name: "network")
  String get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "mode")
  String get mode => throw _privateConstructorUsedError;
  @JsonKey(name: "config")
  TradeCustomSetting get config => throw _privateConstructorUsedError;

  /// Serializes this TradeConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeConfigCopyWith<TradeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeConfigCopyWith<$Res> {
  factory $TradeConfigCopyWith(
          TradeConfig value, $Res Function(TradeConfig) then) =
      _$TradeConfigCopyWithImpl<$Res, TradeConfig>;
  @useResult
  $Res call(
      {@JsonKey(name: "network") String chainName,
      @JsonKey(name: "mode") String mode,
      @JsonKey(name: "config") TradeCustomSetting config});

  $TradeCustomSettingCopyWith<$Res> get config;
}

/// @nodoc
class _$TradeConfigCopyWithImpl<$Res, $Val extends TradeConfig>
    implements $TradeConfigCopyWith<$Res> {
  _$TradeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainName = null,
    Object? mode = null,
    Object? config = null,
  }) {
    return _then(_value.copyWith(
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
    ) as $Val);
  }

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeCustomSettingCopyWith<$Res> get config {
    return $TradeCustomSettingCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeConfigImplCopyWith<$Res>
    implements $TradeConfigCopyWith<$Res> {
  factory _$$TradeConfigImplCopyWith(
          _$TradeConfigImpl value, $Res Function(_$TradeConfigImpl) then) =
      __$$TradeConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "network") String chainName,
      @JsonKey(name: "mode") String mode,
      @JsonKey(name: "config") TradeCustomSetting config});

  @override
  $TradeCustomSettingCopyWith<$Res> get config;
}

/// @nodoc
class __$$TradeConfigImplCopyWithImpl<$Res>
    extends _$TradeConfigCopyWithImpl<$Res, _$TradeConfigImpl>
    implements _$$TradeConfigImplCopyWith<$Res> {
  __$$TradeConfigImplCopyWithImpl(
      _$TradeConfigImpl _value, $Res Function(_$TradeConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainName = null,
    Object? mode = null,
    Object? config = null,
  }) {
    return _then(_$TradeConfigImpl(
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeConfigImpl implements _TradeConfig {
  const _$TradeConfigImpl(
      {@JsonKey(name: "network") required this.chainName,
      @JsonKey(name: "mode") required this.mode,
      @JsonKey(name: "config") required this.config});

  factory _$TradeConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeConfigImplFromJson(json);

  @override
  @JsonKey(name: "network")
  final String chainName;
  @override
  @JsonKey(name: "mode")
  final String mode;
  @override
  @JsonKey(name: "config")
  final TradeCustomSetting config;

  @override
  String toString() {
    return 'TradeConfig(chainName: $chainName, mode: $mode, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeConfigImpl &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.config, config) || other.config == config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainName, mode, config);

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeConfigImplCopyWith<_$TradeConfigImpl> get copyWith =>
      __$$TradeConfigImplCopyWithImpl<_$TradeConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeConfigImplToJson(
      this,
    );
  }
}

abstract class _TradeConfig implements TradeConfig {
  const factory _TradeConfig(
          {@JsonKey(name: "network") required final String chainName,
          @JsonKey(name: "mode") required final String mode,
          @JsonKey(name: "config") required final TradeCustomSetting config}) =
      _$TradeConfigImpl;

  factory _TradeConfig.fromJson(Map<String, dynamic> json) =
      _$TradeConfigImpl.fromJson;

  @override
  @JsonKey(name: "network")
  String get chainName;
  @override
  @JsonKey(name: "mode")
  String get mode;
  @override
  @JsonKey(name: "config")
  TradeCustomSetting get config;

  /// Create a copy of TradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeConfigImplCopyWith<_$TradeConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
