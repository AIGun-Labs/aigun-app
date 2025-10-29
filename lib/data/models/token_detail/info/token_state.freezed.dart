// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenDetailInfo _$TokenDetailInfoFromJson(Map<String, dynamic> json) {
  return _TokenDetailInfo.fromJson(json);
}

/// @nodoc
mixin _$TokenDetailInfo {
  @JsonKey(name: "price_usd")
  double get priceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: "market_cap")
  double get marketCap => throw _privateConstructorUsedError;
  @JsonKey(name: "liquidity")
  double get liquidity => throw _privateConstructorUsedError;
  @JsonKey(name: "volume_24h")
  double get volume24h => throw _privateConstructorUsedError;
  @JsonKey(name: "holders")
  int get holders => throw _privateConstructorUsedError;
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  String? get highestIncreaseRate => throw _privateConstructorUsedError;
  @JsonKey(name: "narrative")
  String? get narrative => throw _privateConstructorUsedError;
  @JsonKey(name: "is_native")
  bool get isNative => throw _privateConstructorUsedError;
  @JsonKey(name: "price_change_24h")
  double get priceChange24h => throw _privateConstructorUsedError;

  /// Serializes this TokenDetailInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenDetailInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenDetailInfoCopyWith<TokenDetailInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDetailInfoCopyWith<$Res> {
  factory $TokenDetailInfoCopyWith(
          TokenDetailInfo value, $Res Function(TokenDetailInfo) then) =
      _$TokenDetailInfoCopyWithImpl<$Res, TokenDetailInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "price_usd") double priceUsd,
      @JsonKey(name: "market_cap") double marketCap,
      @JsonKey(name: "liquidity") double liquidity,
      @JsonKey(name: "volume_24h") double volume24h,
      @JsonKey(name: "holders") int holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      String? highestIncreaseRate,
      @JsonKey(name: "narrative") String? narrative,
      @JsonKey(name: "is_native") bool isNative,
      @JsonKey(name: "price_change_24h") double priceChange24h});
}

/// @nodoc
class _$TokenDetailInfoCopyWithImpl<$Res, $Val extends TokenDetailInfo>
    implements $TokenDetailInfoCopyWith<$Res> {
  _$TokenDetailInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenDetailInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceUsd = null,
    Object? marketCap = null,
    Object? liquidity = null,
    Object? volume24h = null,
    Object? holders = null,
    Object? highestIncreaseRate = freezed,
    Object? narrative = freezed,
    Object? isNative = null,
    Object? priceChange24h = null,
  }) {
    return _then(_value.copyWith(
      priceUsd: null == priceUsd
          ? _value.priceUsd
          : priceUsd // ignore: cast_nullable_to_non_nullable
              as double,
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double,
      liquidity: null == liquidity
          ? _value.liquidity
          : liquidity // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      holders: null == holders
          ? _value.holders
          : holders // ignore: cast_nullable_to_non_nullable
              as int,
      highestIncreaseRate: freezed == highestIncreaseRate
          ? _value.highestIncreaseRate
          : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      narrative: freezed == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String?,
      isNative: null == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
      priceChange24h: null == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenDetailInfoImplCopyWith<$Res>
    implements $TokenDetailInfoCopyWith<$Res> {
  factory _$$TokenDetailInfoImplCopyWith(_$TokenDetailInfoImpl value,
          $Res Function(_$TokenDetailInfoImpl) then) =
      __$$TokenDetailInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "price_usd") double priceUsd,
      @JsonKey(name: "market_cap") double marketCap,
      @JsonKey(name: "liquidity") double liquidity,
      @JsonKey(name: "volume_24h") double volume24h,
      @JsonKey(name: "holders") int holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      String? highestIncreaseRate,
      @JsonKey(name: "narrative") String? narrative,
      @JsonKey(name: "is_native") bool isNative,
      @JsonKey(name: "price_change_24h") double priceChange24h});
}

/// @nodoc
class __$$TokenDetailInfoImplCopyWithImpl<$Res>
    extends _$TokenDetailInfoCopyWithImpl<$Res, _$TokenDetailInfoImpl>
    implements _$$TokenDetailInfoImplCopyWith<$Res> {
  __$$TokenDetailInfoImplCopyWithImpl(
      _$TokenDetailInfoImpl _value, $Res Function(_$TokenDetailInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenDetailInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceUsd = null,
    Object? marketCap = null,
    Object? liquidity = null,
    Object? volume24h = null,
    Object? holders = null,
    Object? highestIncreaseRate = freezed,
    Object? narrative = freezed,
    Object? isNative = null,
    Object? priceChange24h = null,
  }) {
    return _then(_$TokenDetailInfoImpl(
      priceUsd: null == priceUsd
          ? _value.priceUsd
          : priceUsd // ignore: cast_nullable_to_non_nullable
              as double,
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double,
      liquidity: null == liquidity
          ? _value.liquidity
          : liquidity // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      holders: null == holders
          ? _value.holders
          : holders // ignore: cast_nullable_to_non_nullable
              as int,
      highestIncreaseRate: freezed == highestIncreaseRate
          ? _value.highestIncreaseRate
          : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      narrative: freezed == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String?,
      isNative: null == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
      priceChange24h: null == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenDetailInfoImpl implements _TokenDetailInfo {
  const _$TokenDetailInfoImpl(
      {@JsonKey(name: "price_usd") required this.priceUsd,
      @JsonKey(name: "market_cap") required this.marketCap,
      @JsonKey(name: "liquidity") required this.liquidity,
      @JsonKey(name: "volume_24h") required this.volume24h,
      @JsonKey(name: "holders") required this.holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      this.highestIncreaseRate,
      @JsonKey(name: "narrative") this.narrative = "",
      @JsonKey(name: "is_native") required this.isNative,
      @JsonKey(name: "price_change_24h") required this.priceChange24h});

  factory _$TokenDetailInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenDetailInfoImplFromJson(json);

  @override
  @JsonKey(name: "price_usd")
  final double priceUsd;
  @override
  @JsonKey(name: "market_cap")
  final double marketCap;
  @override
  @JsonKey(name: "liquidity")
  final double liquidity;
  @override
  @JsonKey(name: "volume_24h")
  final double volume24h;
  @override
  @JsonKey(name: "holders")
  final int holders;
  @override
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  final String? highestIncreaseRate;
  @override
  @JsonKey(name: "narrative")
  final String? narrative;
  @override
  @JsonKey(name: "is_native")
  final bool isNative;
  @override
  @JsonKey(name: "price_change_24h")
  final double priceChange24h;

  @override
  String toString() {
    return 'TokenDetailInfo(priceUsd: $priceUsd, marketCap: $marketCap, liquidity: $liquidity, volume24h: $volume24h, holders: $holders, highestIncreaseRate: $highestIncreaseRate, narrative: $narrative, isNative: $isNative, priceChange24h: $priceChange24h)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDetailInfoImpl &&
            (identical(other.priceUsd, priceUsd) ||
                other.priceUsd == priceUsd) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.liquidity, liquidity) ||
                other.liquidity == liquidity) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.holders, holders) || other.holders == holders) &&
            (identical(other.highestIncreaseRate, highestIncreaseRate) ||
                other.highestIncreaseRate == highestIncreaseRate) &&
            (identical(other.narrative, narrative) ||
                other.narrative == narrative) &&
            (identical(other.isNative, isNative) ||
                other.isNative == isNative) &&
            (identical(other.priceChange24h, priceChange24h) ||
                other.priceChange24h == priceChange24h));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      priceUsd,
      marketCap,
      liquidity,
      volume24h,
      holders,
      highestIncreaseRate,
      narrative,
      isNative,
      priceChange24h);

  /// Create a copy of TokenDetailInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDetailInfoImplCopyWith<_$TokenDetailInfoImpl> get copyWith =>
      __$$TokenDetailInfoImplCopyWithImpl<_$TokenDetailInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenDetailInfoImplToJson(
      this,
    );
  }
}

abstract class _TokenDetailInfo implements TokenDetailInfo {
  const factory _TokenDetailInfo(
      {@JsonKey(name: "price_usd") required final double priceUsd,
      @JsonKey(name: "market_cap") required final double marketCap,
      @JsonKey(name: "liquidity") required final double liquidity,
      @JsonKey(name: "volume_24h") required final double volume24h,
      @JsonKey(name: "holders") required final int holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      final String? highestIncreaseRate,
      @JsonKey(name: "narrative") final String? narrative,
      @JsonKey(name: "is_native") required final bool isNative,
      @JsonKey(name: "price_change_24h")
      required final double priceChange24h}) = _$TokenDetailInfoImpl;

  factory _TokenDetailInfo.fromJson(Map<String, dynamic> json) =
      _$TokenDetailInfoImpl.fromJson;

  @override
  @JsonKey(name: "price_usd")
  double get priceUsd;
  @override
  @JsonKey(name: "market_cap")
  double get marketCap;
  @override
  @JsonKey(name: "liquidity")
  double get liquidity;
  @override
  @JsonKey(name: "volume_24h")
  double get volume24h;
  @override
  @JsonKey(name: "holders")
  int get holders;
  @override
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  String? get highestIncreaseRate;
  @override
  @JsonKey(name: "narrative")
  String? get narrative;
  @override
  @JsonKey(name: "is_native")
  bool get isNative;
  @override
  @JsonKey(name: "price_change_24h")
  double get priceChange24h;

  /// Create a copy of TokenDetailInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenDetailInfoImplCopyWith<_$TokenDetailInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
