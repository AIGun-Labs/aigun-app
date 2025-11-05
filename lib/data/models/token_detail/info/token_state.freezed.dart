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
  double? get priceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: "market_cap")
  double? get marketCap => throw _privateConstructorUsedError;
  @JsonKey(name: "liquidity")
  double? get liquidity => throw _privateConstructorUsedError;
  @JsonKey(name: "volume_24h")
  double? get volume24h => throw _privateConstructorUsedError;
  @JsonKey(name: "holders")
  int? get holders => throw _privateConstructorUsedError;
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  String? get highestIncreaseRate => throw _privateConstructorUsedError;
  @JsonKey(name: "narrative")
  Multilingual? get narrative => throw _privateConstructorUsedError;
  @JsonKey(name: "is_native", defaultValue: false)
  bool? get isNative => throw _privateConstructorUsedError;
  @JsonKey(name: "price_change_24h")
  double? get priceChange24h => throw _privateConstructorUsedError;
  @JsonKey(name: "is_mainstream", defaultValue: false)
  bool? get isMainStream => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {@JsonKey(name: "price_usd") double? priceUsd,
      @JsonKey(name: "market_cap") double? marketCap,
      @JsonKey(name: "liquidity") double? liquidity,
      @JsonKey(name: "volume_24h") double? volume24h,
      @JsonKey(name: "holders") int? holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      String? highestIncreaseRate,
      @JsonKey(name: "narrative") Multilingual? narrative,
      @JsonKey(name: "is_native", defaultValue: false) bool? isNative,
      @JsonKey(name: "price_change_24h") double? priceChange24h,
      @JsonKey(name: "is_mainstream", defaultValue: false) bool? isMainStream});

  $MultilingualCopyWith<$Res>? get narrative;
}

/// @nodoc
class _$TokenDetailInfoCopyWithImpl<$Res, $Val extends TokenDetailInfo>
    implements $TokenDetailInfoCopyWith<$Res> {
  _$TokenDetailInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceUsd = freezed,
    Object? marketCap = freezed,
    Object? liquidity = freezed,
    Object? volume24h = freezed,
    Object? holders = freezed,
    Object? highestIncreaseRate = freezed,
    Object? narrative = freezed,
    Object? isNative = freezed,
    Object? priceChange24h = freezed,
    Object? isMainStream = freezed,
  }) {
    return _then(_value.copyWith(
      priceUsd: freezed == priceUsd
          ? _value.priceUsd
          : priceUsd // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      liquidity: freezed == liquidity
          ? _value.liquidity
          : liquidity // ignore: cast_nullable_to_non_nullable
              as double?,
      volume24h: freezed == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double?,
      holders: freezed == holders
          ? _value.holders
          : holders // ignore: cast_nullable_to_non_nullable
              as int?,
      highestIncreaseRate: freezed == highestIncreaseRate
          ? _value.highestIncreaseRate
          : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      narrative: freezed == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as Multilingual?,
      isNative: freezed == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceChange24h: freezed == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double?,
      isMainStream: freezed == isMainStream
          ? _value.isMainStream
          : isMainStream // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MultilingualCopyWith<$Res>? get narrative {
    if (_value.narrative == null) {
      return null;
    }

    return $MultilingualCopyWith<$Res>(_value.narrative!, (value) {
      return _then(_value.copyWith(narrative: value) as $Val);
    });
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
      {@JsonKey(name: "price_usd") double? priceUsd,
      @JsonKey(name: "market_cap") double? marketCap,
      @JsonKey(name: "liquidity") double? liquidity,
      @JsonKey(name: "volume_24h") double? volume24h,
      @JsonKey(name: "holders") int? holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      String? highestIncreaseRate,
      @JsonKey(name: "narrative") Multilingual? narrative,
      @JsonKey(name: "is_native", defaultValue: false) bool? isNative,
      @JsonKey(name: "price_change_24h") double? priceChange24h,
      @JsonKey(name: "is_mainstream", defaultValue: false) bool? isMainStream});

  @override
  $MultilingualCopyWith<$Res>? get narrative;
}

/// @nodoc
class __$$TokenDetailInfoImplCopyWithImpl<$Res>
    extends _$TokenDetailInfoCopyWithImpl<$Res, _$TokenDetailInfoImpl>
    implements _$$TokenDetailInfoImplCopyWith<$Res> {
  __$$TokenDetailInfoImplCopyWithImpl(
      _$TokenDetailInfoImpl _value, $Res Function(_$TokenDetailInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceUsd = freezed,
    Object? marketCap = freezed,
    Object? liquidity = freezed,
    Object? volume24h = freezed,
    Object? holders = freezed,
    Object? highestIncreaseRate = freezed,
    Object? narrative = freezed,
    Object? isNative = freezed,
    Object? priceChange24h = freezed,
    Object? isMainStream = freezed,
  }) {
    return _then(_$TokenDetailInfoImpl(
      priceUsd: freezed == priceUsd
          ? _value.priceUsd
          : priceUsd // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      liquidity: freezed == liquidity
          ? _value.liquidity
          : liquidity // ignore: cast_nullable_to_non_nullable
              as double?,
      volume24h: freezed == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double?,
      holders: freezed == holders
          ? _value.holders
          : holders // ignore: cast_nullable_to_non_nullable
              as int?,
      highestIncreaseRate: freezed == highestIncreaseRate
          ? _value.highestIncreaseRate
          : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      narrative: freezed == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as Multilingual?,
      isNative: freezed == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceChange24h: freezed == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double?,
      isMainStream: freezed == isMainStream
          ? _value.isMainStream
          : isMainStream // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenDetailInfoImpl implements _TokenDetailInfo {
  const _$TokenDetailInfoImpl(
      {@JsonKey(name: "price_usd") this.priceUsd,
      @JsonKey(name: "market_cap") this.marketCap,
      @JsonKey(name: "liquidity") this.liquidity,
      @JsonKey(name: "volume_24h") this.volume24h,
      @JsonKey(name: "holders") this.holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      this.highestIncreaseRate,
      @JsonKey(name: "narrative") this.narrative,
      @JsonKey(name: "is_native", defaultValue: false) this.isNative,
      @JsonKey(name: "price_change_24h") this.priceChange24h,
      @JsonKey(name: "is_mainstream", defaultValue: false) this.isMainStream});

  factory _$TokenDetailInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenDetailInfoImplFromJson(json);

  @override
  @JsonKey(name: "price_usd")
  final double? priceUsd;
  @override
  @JsonKey(name: "market_cap")
  final double? marketCap;
  @override
  @JsonKey(name: "liquidity")
  final double? liquidity;
  @override
  @JsonKey(name: "volume_24h")
  final double? volume24h;
  @override
  @JsonKey(name: "holders")
  final int? holders;
  @override
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  final String? highestIncreaseRate;
  @override
  @JsonKey(name: "narrative")
  final Multilingual? narrative;
  @override
  @JsonKey(name: "is_native", defaultValue: false)
  final bool? isNative;
  @override
  @JsonKey(name: "price_change_24h")
  final double? priceChange24h;
  @override
  @JsonKey(name: "is_mainstream", defaultValue: false)
  final bool? isMainStream;

  @override
  String toString() {
    return 'TokenDetailInfo(priceUsd: $priceUsd, marketCap: $marketCap, liquidity: $liquidity, volume24h: $volume24h, holders: $holders, highestIncreaseRate: $highestIncreaseRate, narrative: $narrative, isNative: $isNative, priceChange24h: $priceChange24h, isMainStream: $isMainStream)';
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
                other.priceChange24h == priceChange24h) &&
            (identical(other.isMainStream, isMainStream) ||
                other.isMainStream == isMainStream));
  }

  @JsonKey(ignore: true)
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
      priceChange24h,
      isMainStream);

  @JsonKey(ignore: true)
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
      {@JsonKey(name: "price_usd") final double? priceUsd,
      @JsonKey(name: "market_cap") final double? marketCap,
      @JsonKey(name: "liquidity") final double? liquidity,
      @JsonKey(name: "volume_24h") final double? volume24h,
      @JsonKey(name: "holders") final int? holders,
      @JsonKey(name: "highest_increase_rate")
      @FlexibleStringConverter()
      final String? highestIncreaseRate,
      @JsonKey(name: "narrative") final Multilingual? narrative,
      @JsonKey(name: "is_native", defaultValue: false) final bool? isNative,
      @JsonKey(name: "price_change_24h") final double? priceChange24h,
      @JsonKey(name: "is_mainstream", defaultValue: false)
      final bool? isMainStream}) = _$TokenDetailInfoImpl;

  factory _TokenDetailInfo.fromJson(Map<String, dynamic> json) =
      _$TokenDetailInfoImpl.fromJson;

  @override
  @JsonKey(name: "price_usd")
  double? get priceUsd;
  @override
  @JsonKey(name: "market_cap")
  double? get marketCap;
  @override
  @JsonKey(name: "liquidity")
  double? get liquidity;
  @override
  @JsonKey(name: "volume_24h")
  double? get volume24h;
  @override
  @JsonKey(name: "holders")
  int? get holders;
  @override
  @JsonKey(name: "highest_increase_rate")
  @FlexibleStringConverter()
  String? get highestIncreaseRate;
  @override
  @JsonKey(name: "narrative")
  Multilingual? get narrative;
  @override
  @JsonKey(name: "is_native", defaultValue: false)
  bool? get isNative;
  @override
  @JsonKey(name: "price_change_24h")
  double? get priceChange24h;
  @override
  @JsonKey(name: "is_mainstream", defaultValue: false)
  bool? get isMainStream;
  @override
  @JsonKey(ignore: true)
  _$$TokenDetailInfoImplCopyWith<_$TokenDetailInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
