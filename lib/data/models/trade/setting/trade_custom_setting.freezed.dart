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
  @JsonKey(name: "slippage", fromJson: _slippageFromJson)
  int get slippage => throw _privateConstructorUsedError; // 滑点
  @JsonKey(name: "mev_protect")
  bool get mevProtect => throw _privateConstructorUsedError; // 是否启用MEV保护(防夹功能)
  @JsonKey(name: "priority_fee")
  String? get priorityFee => throw _privateConstructorUsedError; // for solana
  @JsonKey(name: "tip_fee")
  String? get tipFee => throw _privateConstructorUsedError; // for solana
  @JsonKey(name: "gas_price")
  String? get gasPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {@JsonKey(name: "slippage", fromJson: _slippageFromJson) int slippage,
      @JsonKey(name: "mev_protect") bool mevProtect,
      @JsonKey(name: "priority_fee") String? priorityFee,
      @JsonKey(name: "tip_fee") String? tipFee,
      @JsonKey(name: "gas_price") String? gasPrice});
}

/// @nodoc
class _$TradeCustomSettingCopyWithImpl<$Res, $Val extends TradeCustomSetting>
    implements $TradeCustomSettingCopyWith<$Res> {
  _$TradeCustomSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      {@JsonKey(name: "slippage", fromJson: _slippageFromJson) int slippage,
      @JsonKey(name: "mev_protect") bool mevProtect,
      @JsonKey(name: "priority_fee") String? priorityFee,
      @JsonKey(name: "tip_fee") String? tipFee,
      @JsonKey(name: "gas_price") String? gasPrice});
}

/// @nodoc
class __$$TradeCustomSettingImplCopyWithImpl<$Res>
    extends _$TradeCustomSettingCopyWithImpl<$Res, _$TradeCustomSettingImpl>
    implements _$$TradeCustomSettingImplCopyWith<$Res> {
  __$$TradeCustomSettingImplCopyWithImpl(_$TradeCustomSettingImpl _value,
      $Res Function(_$TradeCustomSettingImpl) _then)
      : super(_value, _then);

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
      {@JsonKey(name: "slippage", fromJson: _slippageFromJson)
      this.slippage = 0,
      @JsonKey(name: "mev_protect") this.mevProtect = false,
      @JsonKey(name: "priority_fee") this.priorityFee = '',
      @JsonKey(name: "tip_fee") this.tipFee = '',
      @JsonKey(name: "gas_price") this.gasPrice = ''});

  factory _$TradeCustomSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeCustomSettingImplFromJson(json);

  @override
  @JsonKey(name: "slippage", fromJson: _slippageFromJson)
  final int slippage;
// 滑点
  @override
  @JsonKey(name: "mev_protect")
  final bool mevProtect;
// 是否启用MEV保护(防夹功能)
  @override
  @JsonKey(name: "priority_fee")
  final String? priorityFee;
// for solana
  @override
  @JsonKey(name: "tip_fee")
  final String? tipFee;
// for solana
  @override
  @JsonKey(name: "gas_price")
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, slippage, mevProtect, priorityFee, tipFee, gasPrice);

  @JsonKey(ignore: true)
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
          {@JsonKey(name: "slippage", fromJson: _slippageFromJson)
          final int slippage,
          @JsonKey(name: "mev_protect") final bool mevProtect,
          @JsonKey(name: "priority_fee") final String? priorityFee,
          @JsonKey(name: "tip_fee") final String? tipFee,
          @JsonKey(name: "gas_price") final String? gasPrice}) =
      _$TradeCustomSettingImpl;

  factory _TradeCustomSetting.fromJson(Map<String, dynamic> json) =
      _$TradeCustomSettingImpl.fromJson;

  @override
  @JsonKey(name: "slippage", fromJson: _slippageFromJson)
  int get slippage;
  @override // 滑点
  @JsonKey(name: "mev_protect")
  bool get mevProtect;
  @override // 是否启用MEV保护(防夹功能)
  @JsonKey(name: "priority_fee")
  String? get priorityFee;
  @override // for solana
  @JsonKey(name: "tip_fee")
  String? get tipFee;
  @override // for solana
  @JsonKey(name: "gas_price")
  String? get gasPrice;
  @override
  @JsonKey(ignore: true)
  _$$TradeCustomSettingImplCopyWith<_$TradeCustomSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
