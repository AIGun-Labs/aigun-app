// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Candle {

@JsonKey(name: 'time') String get time;@JsonKey(name: 'open') String get open;@JsonKey(name: 'high') String get high;@JsonKey(name: 'low') String get low;@JsonKey(name: 'close') String get close;@JsonKey(name: 'volume') String get volume;
/// Create a copy of Candle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandleCopyWith<Candle> get copyWith => _$CandleCopyWithImpl<Candle>(this as Candle, _$identity);

  /// Serializes this Candle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Candle&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close,volume);

@override
String toString() {
  return 'Candle(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $CandleCopyWith<$Res>  {
  factory $CandleCopyWith(Candle value, $Res Function(Candle) _then) = _$CandleCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'time') String time,@JsonKey(name: 'open') String open,@JsonKey(name: 'high') String high,@JsonKey(name: 'low') String low,@JsonKey(name: 'close') String close,@JsonKey(name: 'volume') String volume
});




}
/// @nodoc
class _$CandleCopyWithImpl<$Res>
    implements $CandleCopyWith<$Res> {
  _$CandleCopyWithImpl(this._self, this._then);

  final Candle _self;
  final $Res Function(Candle) _then;

/// Create a copy of Candle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,Object? volume = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as String,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as String,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Candle].
extension CandlePatterns on Candle {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Candle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Candle() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Candle value)  $default,){
final _that = this;
switch (_that) {
case _Candle():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Candle value)?  $default,){
final _that = this;
switch (_that) {
case _Candle() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  String time, @JsonKey(name: 'open')  String open, @JsonKey(name: 'high')  String high, @JsonKey(name: 'low')  String low, @JsonKey(name: 'close')  String close, @JsonKey(name: 'volume')  String volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Candle() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  String time, @JsonKey(name: 'open')  String open, @JsonKey(name: 'high')  String high, @JsonKey(name: 'low')  String low, @JsonKey(name: 'close')  String close, @JsonKey(name: 'volume')  String volume)  $default,) {final _that = this;
switch (_that) {
case _Candle():
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'time')  String time, @JsonKey(name: 'open')  String open, @JsonKey(name: 'high')  String high, @JsonKey(name: 'low')  String low, @JsonKey(name: 'close')  String close, @JsonKey(name: 'volume')  String volume)?  $default,) {final _that = this;
switch (_that) {
case _Candle() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Candle implements Candle {
  const _Candle({@JsonKey(name: 'time') required this.time, @JsonKey(name: 'open') required this.open, @JsonKey(name: 'high') required this.high, @JsonKey(name: 'low') required this.low, @JsonKey(name: 'close') required this.close, @JsonKey(name: 'volume') required this.volume});
  factory _Candle.fromJson(Map<String, dynamic> json) => _$CandleFromJson(json);

@override@JsonKey(name: 'time') final  String time;
@override@JsonKey(name: 'open') final  String open;
@override@JsonKey(name: 'high') final  String high;
@override@JsonKey(name: 'low') final  String low;
@override@JsonKey(name: 'close') final  String close;
@override@JsonKey(name: 'volume') final  String volume;

/// Create a copy of Candle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandleCopyWith<_Candle> get copyWith => __$CandleCopyWithImpl<_Candle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Candle&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close,volume);

@override
String toString() {
  return 'Candle(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$CandleCopyWith<$Res> implements $CandleCopyWith<$Res> {
  factory _$CandleCopyWith(_Candle value, $Res Function(_Candle) _then) = __$CandleCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'time') String time,@JsonKey(name: 'open') String open,@JsonKey(name: 'high') String high,@JsonKey(name: 'low') String low,@JsonKey(name: 'close') String close,@JsonKey(name: 'volume') String volume
});




}
/// @nodoc
class __$CandleCopyWithImpl<$Res>
    implements _$CandleCopyWith<$Res> {
  __$CandleCopyWithImpl(this._self, this._then);

  final _Candle _self;
  final $Res Function(_Candle) _then;

/// Create a copy of Candle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,Object? volume = null,}) {
  return _then(_Candle(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as String,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as String,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
