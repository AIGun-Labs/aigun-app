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

/// @nodoc
mixin _$TradeCustomSetting {
  String? get slippage => throw _privateConstructorUsedError;
  String? get gasPrice => throw _privateConstructorUsedError;
  String? get gasLimit => throw _privateConstructorUsedError;
  String? get BriberyFee => throw _privateConstructorUsedError;

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
      {String? slippage,
      String? gasPrice,
      String? gasLimit,
      String? BriberyFee});
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
    Object? slippage = freezed,
    Object? gasPrice = freezed,
    Object? gasLimit = freezed,
    Object? BriberyFee = freezed,
  }) {
    return _then(_value.copyWith(
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      gasLimit: freezed == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String?,
      BriberyFee: freezed == BriberyFee
          ? _value.BriberyFee
          : BriberyFee // ignore: cast_nullable_to_non_nullable
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
      {String? slippage,
      String? gasPrice,
      String? gasLimit,
      String? BriberyFee});
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
    Object? slippage = freezed,
    Object? gasPrice = freezed,
    Object? gasLimit = freezed,
    Object? BriberyFee = freezed,
  }) {
    return _then(_$TradeCustomSettingImpl(
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      gasLimit: freezed == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String?,
      BriberyFee: freezed == BriberyFee
          ? _value.BriberyFee
          : BriberyFee // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TradeCustomSettingImpl implements _TradeCustomSetting {
  const _$TradeCustomSettingImpl(
      {this.slippage = "",
      this.gasPrice = "",
      this.gasLimit = "",
      this.BriberyFee = ""});

  @override
  @JsonKey()
  final String? slippage;
  @override
  @JsonKey()
  final String? gasPrice;
  @override
  @JsonKey()
  final String? gasLimit;
  @override
  @JsonKey()
  final String? BriberyFee;

  @override
  String toString() {
    return 'TradeCustomSetting(slippage: $slippage, gasPrice: $gasPrice, gasLimit: $gasLimit, BriberyFee: $BriberyFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeCustomSettingImpl &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.BriberyFee, BriberyFee) ||
                other.BriberyFee == BriberyFee));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, slippage, gasPrice, gasLimit, BriberyFee);

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeCustomSettingImplCopyWith<_$TradeCustomSettingImpl> get copyWith =>
      __$$TradeCustomSettingImplCopyWithImpl<_$TradeCustomSettingImpl>(
          this, _$identity);
}

abstract class _TradeCustomSetting implements TradeCustomSetting {
  const factory _TradeCustomSetting(
      {final String? slippage,
      final String? gasPrice,
      final String? gasLimit,
      final String? BriberyFee}) = _$TradeCustomSettingImpl;

  @override
  String? get slippage;
  @override
  String? get gasPrice;
  @override
  String? get gasLimit;
  @override
  String? get BriberyFee;

  /// Create a copy of TradeCustomSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeCustomSettingImplCopyWith<_$TradeCustomSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TradeSettingState {
  TradeMode get tradeMode => throw _privateConstructorUsedError;
  TradeCustomSetting get solana => throw _privateConstructorUsedError;
  TradeCustomSetting get ethereum => throw _privateConstructorUsedError;
  TradeCustomSetting get bnb => throw _privateConstructorUsedError;

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
  $Res call(
      {TradeMode tradeMode,
      TradeCustomSetting solana,
      TradeCustomSetting ethereum,
      TradeCustomSetting bnb});

  $TradeCustomSettingCopyWith<$Res> get solana;
  $TradeCustomSettingCopyWith<$Res> get ethereum;
  $TradeCustomSettingCopyWith<$Res> get bnb;
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
    Object? tradeMode = null,
    Object? solana = null,
    Object? ethereum = null,
    Object? bnb = null,
  }) {
    return _then(_value.copyWith(
      tradeMode: null == tradeMode
          ? _value.tradeMode
          : tradeMode // ignore: cast_nullable_to_non_nullable
              as TradeMode,
      solana: null == solana
          ? _value.solana
          : solana // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
      ethereum: null == ethereum
          ? _value.ethereum
          : ethereum // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
      bnb: null == bnb
          ? _value.bnb
          : bnb // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
    ) as $Val);
  }

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeCustomSettingCopyWith<$Res> get solana {
    return $TradeCustomSettingCopyWith<$Res>(_value.solana, (value) {
      return _then(_value.copyWith(solana: value) as $Val);
    });
  }

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeCustomSettingCopyWith<$Res> get ethereum {
    return $TradeCustomSettingCopyWith<$Res>(_value.ethereum, (value) {
      return _then(_value.copyWith(ethereum: value) as $Val);
    });
  }

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeCustomSettingCopyWith<$Res> get bnb {
    return $TradeCustomSettingCopyWith<$Res>(_value.bnb, (value) {
      return _then(_value.copyWith(bnb: value) as $Val);
    });
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
  $Res call(
      {TradeMode tradeMode,
      TradeCustomSetting solana,
      TradeCustomSetting ethereum,
      TradeCustomSetting bnb});

  @override
  $TradeCustomSettingCopyWith<$Res> get solana;
  @override
  $TradeCustomSettingCopyWith<$Res> get ethereum;
  @override
  $TradeCustomSettingCopyWith<$Res> get bnb;
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
    Object? tradeMode = null,
    Object? solana = null,
    Object? ethereum = null,
    Object? bnb = null,
  }) {
    return _then(_$TradeSettingStateImpl(
      tradeMode: null == tradeMode
          ? _value.tradeMode
          : tradeMode // ignore: cast_nullable_to_non_nullable
              as TradeMode,
      solana: null == solana
          ? _value.solana
          : solana // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
      ethereum: null == ethereum
          ? _value.ethereum
          : ethereum // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
      bnb: null == bnb
          ? _value.bnb
          : bnb // ignore: cast_nullable_to_non_nullable
              as TradeCustomSetting,
    ));
  }
}

/// @nodoc

class _$TradeSettingStateImpl implements _TradeSettingState {
  const _$TradeSettingStateImpl(
      {this.tradeMode = TradeMode.lightning,
      this.solana = const TradeCustomSetting(),
      this.ethereum = const TradeCustomSetting(),
      this.bnb = const TradeCustomSetting()});

  @override
  @JsonKey()
  final TradeMode tradeMode;
  @override
  @JsonKey()
  final TradeCustomSetting solana;
  @override
  @JsonKey()
  final TradeCustomSetting ethereum;
  @override
  @JsonKey()
  final TradeCustomSetting bnb;

  @override
  String toString() {
    return 'TradeSettingState(tradeMode: $tradeMode, solana: $solana, ethereum: $ethereum, bnb: $bnb)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSettingStateImpl &&
            (identical(other.tradeMode, tradeMode) ||
                other.tradeMode == tradeMode) &&
            (identical(other.solana, solana) || other.solana == solana) &&
            (identical(other.ethereum, ethereum) ||
                other.ethereum == ethereum) &&
            (identical(other.bnb, bnb) || other.bnb == bnb));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tradeMode, solana, ethereum, bnb);

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSettingStateImplCopyWith<_$TradeSettingStateImpl> get copyWith =>
      __$$TradeSettingStateImplCopyWithImpl<_$TradeSettingStateImpl>(
          this, _$identity);
}

abstract class _TradeSettingState implements TradeSettingState {
  const factory _TradeSettingState(
      {final TradeMode tradeMode,
      final TradeCustomSetting solana,
      final TradeCustomSetting ethereum,
      final TradeCustomSetting bnb}) = _$TradeSettingStateImpl;

  @override
  TradeMode get tradeMode;
  @override
  TradeCustomSetting get solana;
  @override
  TradeCustomSetting get ethereum;
  @override
  TradeCustomSetting get bnb;

  /// Create a copy of TradeSettingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSettingStateImplCopyWith<_$TradeSettingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
