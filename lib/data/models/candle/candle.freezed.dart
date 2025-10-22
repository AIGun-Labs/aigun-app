// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Candle _$CandleFromJson(Map<String, dynamic> json) {
  return _Candle.fromJson(json);
}

/// @nodoc
mixin _$Candle {
  @JsonKey(name: "time")
  String get time => throw _privateConstructorUsedError;
  @JsonKey(name: "open")
  String get open => throw _privateConstructorUsedError;
  @JsonKey(name: "high")
  String get high => throw _privateConstructorUsedError;
  @JsonKey(name: "low")
  String get low => throw _privateConstructorUsedError;
  @JsonKey(name: "close")
  String get close => throw _privateConstructorUsedError;
  @JsonKey(name: "volume")
  String get volume => throw _privateConstructorUsedError;

  /// Serializes this Candle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CandleCopyWith<Candle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleCopyWith<$Res> {
  factory $CandleCopyWith(Candle value, $Res Function(Candle) then) =
      _$CandleCopyWithImpl<$Res, Candle>;
  @useResult
  $Res call(
      {@JsonKey(name: "time") String time,
      @JsonKey(name: "open") String open,
      @JsonKey(name: "high") String high,
      @JsonKey(name: "low") String low,
      @JsonKey(name: "close") String close,
      @JsonKey(name: "volume") String volume});
}

/// @nodoc
class _$CandleCopyWithImpl<$Res, $Val extends Candle>
    implements $CandleCopyWith<$Res> {
  _$CandleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandleImplCopyWith<$Res> implements $CandleCopyWith<$Res> {
  factory _$$CandleImplCopyWith(
          _$CandleImpl value, $Res Function(_$CandleImpl) then) =
      __$$CandleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "time") String time,
      @JsonKey(name: "open") String open,
      @JsonKey(name: "high") String high,
      @JsonKey(name: "low") String low,
      @JsonKey(name: "close") String close,
      @JsonKey(name: "volume") String volume});
}

/// @nodoc
class __$$CandleImplCopyWithImpl<$Res>
    extends _$CandleCopyWithImpl<$Res, _$CandleImpl>
    implements _$$CandleImplCopyWith<$Res> {
  __$$CandleImplCopyWithImpl(
      _$CandleImpl _value, $Res Function(_$CandleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
  }) {
    return _then(_$CandleImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandleImpl implements _Candle {
  const _$CandleImpl(
      {@JsonKey(name: "time") required this.time,
      @JsonKey(name: "open") required this.open,
      @JsonKey(name: "high") required this.high,
      @JsonKey(name: "low") required this.low,
      @JsonKey(name: "close") required this.close,
      @JsonKey(name: "volume") required this.volume});

  factory _$CandleImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandleImplFromJson(json);

  @override
  @JsonKey(name: "time")
  final String time;
  @override
  @JsonKey(name: "open")
  final String open;
  @override
  @JsonKey(name: "high")
  final String high;
  @override
  @JsonKey(name: "low")
  final String low;
  @override
  @JsonKey(name: "close")
  final String close;
  @override
  @JsonKey(name: "volume")
  final String volume;

  @override
  String toString() {
    return 'Candle(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandleImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, time, open, high, low, close, volume);

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CandleImplCopyWith<_$CandleImpl> get copyWith =>
      __$$CandleImplCopyWithImpl<_$CandleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandleImplToJson(
      this,
    );
  }
}

abstract class _Candle implements Candle {
  const factory _Candle(
      {@JsonKey(name: "time") required final String time,
      @JsonKey(name: "open") required final String open,
      @JsonKey(name: "high") required final String high,
      @JsonKey(name: "low") required final String low,
      @JsonKey(name: "close") required final String close,
      @JsonKey(name: "volume") required final String volume}) = _$CandleImpl;

  factory _Candle.fromJson(Map<String, dynamic> json) = _$CandleImpl.fromJson;

  @override
  @JsonKey(name: "time")
  String get time;
  @override
  @JsonKey(name: "open")
  String get open;
  @override
  @JsonKey(name: "high")
  String get high;
  @override
  @JsonKey(name: "low")
  String get low;
  @override
  @JsonKey(name: "close")
  String get close;
  @override
  @JsonKey(name: "volume")
  String get volume;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CandleImplCopyWith<_$CandleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
