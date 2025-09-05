// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_custom_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeCustomSetting _$TradeCustomSettingFromJson(Map<String, dynamic> json) {
  return _TradeCustomSetting.fromJson(json);
}

/// @nodoc
mixin _$TradeCustomSetting {
  int get slippage => throw _privateConstructorUsedError; // 滑点
  bool get mevProtect => throw _privateConstructorUsedError; // 是否启用MEV保护(防夹功能)
  String? get priorityFee => throw _privateConstructorUsedError; // for solana
  String? get tipFee => throw _privateConstructorUsedError; // for solana
  String? get gasPrice => throw _privateConstructorUsedError;

  /// Serializes this TradeCustomSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeCustomSettingCopyWith<TradeCustomSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeCustomSettingCopyWith<$Res> {
  factory $TradeCustomSettingCopyWith(
          TradeCustomSetting value, $Res Function(TradeCustomSetting) then) =
      _$TradeCustomSettingCopyWithImpl<$Res, TradeCustomSetting>;
  @useResult
  $Res call(
      {int slippage,
      bool mevProtect,
      String? priorityFee,
      String? tipFee,
      String? gasPrice});
}

/// @nodoc
class _$TradeCustomSettingCopyWithImpl<$Res, $Val extends TradeCustomSetting>
    implements $TradeCustomSettingCopyWith<$Res> {
  _$TradeCustomSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slippage = null,
    Object? mevProtect = null,
    Object? priorityFee = freezed,
    Object? tipFee = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(_value.copyWith(
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int,
      mevProtect: null == mevProtect
          ? _value.mevProtect
          : mevProtect // ignore: cast_nullable_to_non_nullable
              as bool,
      priorityFee: freezed == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String?,
      tipFee: freezed == tipFee
          ? _value.tipFee
          : tipFee // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeCustomSettingImplCopyWith<$Res>
    implements $TradeCustomSettingCopyWith<$Res> {
  factory _$$TradeCustomSettingImplCopyWith(_$TradeCustomSettingImpl value,
          $Res Function(_$TradeCustomSettingImpl) then) =
      __$$TradeCustomSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int slippage,
      bool mevProtect,
      String? priorityFee,
      String? tipFee,
      String? gasPrice});
}

/// @nodoc
class __$$TradeCustomSettingImplCopyWithImpl<$Res>
    extends _$TradeCustomSettingCopyWithImpl<$Res, _$TradeCustomSettingImpl>
    implements _$$TradeCustomSettingImplCopyWith<$Res> {
  __$$TradeCustomSettingImplCopyWithImpl(_$TradeCustomSettingImpl _value,
      $Res Function(_$TradeCustomSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slippage = null,
    Object? mevProtect = null,
    Object? priorityFee = freezed,
    Object? tipFee = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(_$TradeCustomSettingImpl(
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int,
      mevProtect: null == mevProtect
          ? _value.mevProtect
          : mevProtect // ignore: cast_nullable_to_non_nullable
              as bool,
      priorityFee: freezed == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String?,
      tipFee: freezed == tipFee
          ? _value.tipFee
          : tipFee // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeCustomSettingImpl implements _TradeCustomSetting {
  const _$TradeCustomSettingImpl(
      {this.slippage = 0,
      this.mevProtect = false,
      this.priorityFee = '',
      this.tipFee = '',
      this.gasPrice = ''});

  factory _$TradeCustomSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeCustomSettingImplFromJson(json);

  @override
  @JsonKey()
  final int slippage;
// 滑点
  @override
  @JsonKey()
  final bool mevProtect;
// 是否启用MEV保护(防夹功能)
  @override
  @JsonKey()
  final String? priorityFee;
// for solana
  @override
  @JsonKey()
  final String? tipFee;
// for solana
  @override
  @JsonKey()
  final String? gasPrice;

  @override
  String toString() {
    return 'TradeCustomSetting(slippage: $slippage, mevProtect: $mevProtect, priorityFee: $priorityFee, tipFee: $tipFee, gasPrice: $gasPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeCustomSettingImpl &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.mevProtect, mevProtect) ||
                other.mevProtect == mevProtect) &&
            (identical(other.priorityFee, priorityFee) ||
                other.priorityFee == priorityFee) &&
            (identical(other.tipFee, tipFee) || other.tipFee == tipFee) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, slippage, mevProtect, priorityFee, tipFee, gasPrice);

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeCustomSettingImplCopyWith<_$TradeCustomSettingImpl> get copyWith =>
      __$$TradeCustomSettingImplCopyWithImpl<_$TradeCustomSettingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeCustomSettingImplToJson(
      this,
    );
  }
}

abstract class _TradeCustomSetting implements TradeCustomSetting {
  const factory _TradeCustomSetting(
      {final int slippage,
      final bool mevProtect,
      final String? priorityFee,
      final String? tipFee,
      final String? gasPrice}) = _$TradeCustomSettingImpl;

  factory _TradeCustomSetting.fromJson(Map<String, dynamic> json) =
      _$TradeCustomSettingImpl.fromJson;

  @override
  int get slippage; // 滑点
  @override
  bool get mevProtect; // 是否启用MEV保护(防夹功能)
  @override
  String? get priorityFee; // for solana
  @override
  String? get tipFee; // for solana
  @override
  String? get gasPrice;

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeCustomSettingImplCopyWith<_$TradeCustomSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
