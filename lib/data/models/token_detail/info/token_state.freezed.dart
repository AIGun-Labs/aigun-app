// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenDetailInfo {

@JsonKey(name: 'price_usd')@FlexibleDoubleConverter() double? get priceUsd;@JsonKey(name: 'market_cap')@FlexibleDoubleConverter() double? get marketCap;@JsonKey(name: 'liquidity')@FlexibleDoubleConverter() double? get liquidity;@JsonKey(name: 'volume_24h')@FlexibleDoubleConverter() double? get volume24h;@JsonKey(name: 'holders')@FlexibleIntConverter() int? get holders;@JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter() String? get highestIncreaseRate;@MultilingualListConverter()@JsonKey(name: 'narrative') Multilingual? get narrative;@JsonKey(name: 'is_native') bool? get isNative;@JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter() double? get priceChange24h;@JsonKey(name: 'is_mainstream') bool? get isMainStream;
/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenDetailInfoCopyWith<TokenDetailInfo> get copyWith => _$TokenDetailInfoCopyWithImpl<TokenDetailInfo>(this as TokenDetailInfo, _$identity);

  /// Serializes this TokenDetailInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenDetailInfo&&(identical(other.priceUsd, priceUsd) || other.priceUsd == priceUsd)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.liquidity, liquidity) || other.liquidity == liquidity)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.holders, holders) || other.holders == holders)&&(identical(other.highestIncreaseRate, highestIncreaseRate) || other.highestIncreaseRate == highestIncreaseRate)&&(identical(other.narrative, narrative) || other.narrative == narrative)&&(identical(other.isNative, isNative) || other.isNative == isNative)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.isMainStream, isMainStream) || other.isMainStream == isMainStream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,priceUsd,marketCap,liquidity,volume24h,holders,highestIncreaseRate,narrative,isNative,priceChange24h,isMainStream);

@override
String toString() {
  return 'TokenDetailInfo(priceUsd: $priceUsd, marketCap: $marketCap, liquidity: $liquidity, volume24h: $volume24h, holders: $holders, highestIncreaseRate: $highestIncreaseRate, narrative: $narrative, isNative: $isNative, priceChange24h: $priceChange24h, isMainStream: $isMainStream)';
}


}

/// @nodoc
abstract mixin class $TokenDetailInfoCopyWith<$Res>  {
  factory $TokenDetailInfoCopyWith(TokenDetailInfo value, $Res Function(TokenDetailInfo) _then) = _$TokenDetailInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'price_usd')@FlexibleDoubleConverter() double? priceUsd,@JsonKey(name: 'market_cap')@FlexibleDoubleConverter() double? marketCap,@JsonKey(name: 'liquidity')@FlexibleDoubleConverter() double? liquidity,@JsonKey(name: 'volume_24h')@FlexibleDoubleConverter() double? volume24h,@JsonKey(name: 'holders')@FlexibleIntConverter() int? holders,@JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter() String? highestIncreaseRate,@MultilingualListConverter()@JsonKey(name: 'narrative') Multilingual? narrative,@JsonKey(name: 'is_native') bool? isNative,@JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter() double? priceChange24h,@JsonKey(name: 'is_mainstream') bool? isMainStream
});


$MultilingualCopyWith<$Res>? get narrative;

}
/// @nodoc
class _$TokenDetailInfoCopyWithImpl<$Res>
    implements $TokenDetailInfoCopyWith<$Res> {
  _$TokenDetailInfoCopyWithImpl(this._self, this._then);

  final TokenDetailInfo _self;
  final $Res Function(TokenDetailInfo) _then;

/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priceUsd = freezed,Object? marketCap = freezed,Object? liquidity = freezed,Object? volume24h = freezed,Object? holders = freezed,Object? highestIncreaseRate = freezed,Object? narrative = freezed,Object? isNative = freezed,Object? priceChange24h = freezed,Object? isMainStream = freezed,}) {
  return _then(_self.copyWith(
priceUsd: freezed == priceUsd ? _self.priceUsd : priceUsd // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,liquidity: freezed == liquidity ? _self.liquidity : liquidity // ignore: cast_nullable_to_non_nullable
as double?,volume24h: freezed == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as double?,holders: freezed == holders ? _self.holders : holders // ignore: cast_nullable_to_non_nullable
as int?,highestIncreaseRate: freezed == highestIncreaseRate ? _self.highestIncreaseRate : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
as String?,narrative: freezed == narrative ? _self.narrative : narrative // ignore: cast_nullable_to_non_nullable
as Multilingual?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as double?,isMainStream: freezed == isMainStream ? _self.isMainStream : isMainStream // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get narrative {
    if (_self.narrative == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.narrative!, (value) {
    return _then(_self.copyWith(narrative: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenDetailInfo].
extension TokenDetailInfoPatterns on TokenDetailInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenDetailInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenDetailInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenDetailInfo value)  $default,){
final _that = this;
switch (_that) {
case _TokenDetailInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenDetailInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TokenDetailInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'price_usd')@FlexibleDoubleConverter()  double? priceUsd, @JsonKey(name: 'market_cap')@FlexibleDoubleConverter()  double? marketCap, @JsonKey(name: 'liquidity')@FlexibleDoubleConverter()  double? liquidity, @JsonKey(name: 'volume_24h')@FlexibleDoubleConverter()  double? volume24h, @JsonKey(name: 'holders')@FlexibleIntConverter()  int? holders, @JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter()  String? highestIncreaseRate, @MultilingualListConverter()@JsonKey(name: 'narrative')  Multilingual? narrative, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter()  double? priceChange24h, @JsonKey(name: 'is_mainstream')  bool? isMainStream)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenDetailInfo() when $default != null:
return $default(_that.priceUsd,_that.marketCap,_that.liquidity,_that.volume24h,_that.holders,_that.highestIncreaseRate,_that.narrative,_that.isNative,_that.priceChange24h,_that.isMainStream);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'price_usd')@FlexibleDoubleConverter()  double? priceUsd, @JsonKey(name: 'market_cap')@FlexibleDoubleConverter()  double? marketCap, @JsonKey(name: 'liquidity')@FlexibleDoubleConverter()  double? liquidity, @JsonKey(name: 'volume_24h')@FlexibleDoubleConverter()  double? volume24h, @JsonKey(name: 'holders')@FlexibleIntConverter()  int? holders, @JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter()  String? highestIncreaseRate, @MultilingualListConverter()@JsonKey(name: 'narrative')  Multilingual? narrative, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter()  double? priceChange24h, @JsonKey(name: 'is_mainstream')  bool? isMainStream)  $default,) {final _that = this;
switch (_that) {
case _TokenDetailInfo():
return $default(_that.priceUsd,_that.marketCap,_that.liquidity,_that.volume24h,_that.holders,_that.highestIncreaseRate,_that.narrative,_that.isNative,_that.priceChange24h,_that.isMainStream);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'price_usd')@FlexibleDoubleConverter()  double? priceUsd, @JsonKey(name: 'market_cap')@FlexibleDoubleConverter()  double? marketCap, @JsonKey(name: 'liquidity')@FlexibleDoubleConverter()  double? liquidity, @JsonKey(name: 'volume_24h')@FlexibleDoubleConverter()  double? volume24h, @JsonKey(name: 'holders')@FlexibleIntConverter()  int? holders, @JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter()  String? highestIncreaseRate, @MultilingualListConverter()@JsonKey(name: 'narrative')  Multilingual? narrative, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter()  double? priceChange24h, @JsonKey(name: 'is_mainstream')  bool? isMainStream)?  $default,) {final _that = this;
switch (_that) {
case _TokenDetailInfo() when $default != null:
return $default(_that.priceUsd,_that.marketCap,_that.liquidity,_that.volume24h,_that.holders,_that.highestIncreaseRate,_that.narrative,_that.isNative,_that.priceChange24h,_that.isMainStream);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenDetailInfo extends TokenDetailInfo {
  const _TokenDetailInfo({@JsonKey(name: 'price_usd')@FlexibleDoubleConverter() this.priceUsd = 0, @JsonKey(name: 'market_cap')@FlexibleDoubleConverter() this.marketCap = 0, @JsonKey(name: 'liquidity')@FlexibleDoubleConverter() this.liquidity = 0, @JsonKey(name: 'volume_24h')@FlexibleDoubleConverter() this.volume24h = 0, @JsonKey(name: 'holders')@FlexibleIntConverter() this.holders = 0, @JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter() this.highestIncreaseRate, @MultilingualListConverter()@JsonKey(name: 'narrative') this.narrative, @JsonKey(name: 'is_native') this.isNative = false, @JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter() this.priceChange24h = 0, @JsonKey(name: 'is_mainstream') this.isMainStream = false}): super._();
  factory _TokenDetailInfo.fromJson(Map<String, dynamic> json) => _$TokenDetailInfoFromJson(json);

@override@JsonKey(name: 'price_usd')@FlexibleDoubleConverter() final  double? priceUsd;
@override@JsonKey(name: 'market_cap')@FlexibleDoubleConverter() final  double? marketCap;
@override@JsonKey(name: 'liquidity')@FlexibleDoubleConverter() final  double? liquidity;
@override@JsonKey(name: 'volume_24h')@FlexibleDoubleConverter() final  double? volume24h;
@override@JsonKey(name: 'holders')@FlexibleIntConverter() final  int? holders;
@override@JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter() final  String? highestIncreaseRate;
@override@MultilingualListConverter()@JsonKey(name: 'narrative') final  Multilingual? narrative;
@override@JsonKey(name: 'is_native') final  bool? isNative;
@override@JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter() final  double? priceChange24h;
@override@JsonKey(name: 'is_mainstream') final  bool? isMainStream;

/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenDetailInfoCopyWith<_TokenDetailInfo> get copyWith => __$TokenDetailInfoCopyWithImpl<_TokenDetailInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenDetailInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenDetailInfo&&(identical(other.priceUsd, priceUsd) || other.priceUsd == priceUsd)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.liquidity, liquidity) || other.liquidity == liquidity)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.holders, holders) || other.holders == holders)&&(identical(other.highestIncreaseRate, highestIncreaseRate) || other.highestIncreaseRate == highestIncreaseRate)&&(identical(other.narrative, narrative) || other.narrative == narrative)&&(identical(other.isNative, isNative) || other.isNative == isNative)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.isMainStream, isMainStream) || other.isMainStream == isMainStream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,priceUsd,marketCap,liquidity,volume24h,holders,highestIncreaseRate,narrative,isNative,priceChange24h,isMainStream);

@override
String toString() {
  return 'TokenDetailInfo(priceUsd: $priceUsd, marketCap: $marketCap, liquidity: $liquidity, volume24h: $volume24h, holders: $holders, highestIncreaseRate: $highestIncreaseRate, narrative: $narrative, isNative: $isNative, priceChange24h: $priceChange24h, isMainStream: $isMainStream)';
}


}

/// @nodoc
abstract mixin class _$TokenDetailInfoCopyWith<$Res> implements $TokenDetailInfoCopyWith<$Res> {
  factory _$TokenDetailInfoCopyWith(_TokenDetailInfo value, $Res Function(_TokenDetailInfo) _then) = __$TokenDetailInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'price_usd')@FlexibleDoubleConverter() double? priceUsd,@JsonKey(name: 'market_cap')@FlexibleDoubleConverter() double? marketCap,@JsonKey(name: 'liquidity')@FlexibleDoubleConverter() double? liquidity,@JsonKey(name: 'volume_24h')@FlexibleDoubleConverter() double? volume24h,@JsonKey(name: 'holders')@FlexibleIntConverter() int? holders,@JsonKey(name: 'highest_increase_rate')@FlexibleStringConverter() String? highestIncreaseRate,@MultilingualListConverter()@JsonKey(name: 'narrative') Multilingual? narrative,@JsonKey(name: 'is_native') bool? isNative,@JsonKey(name: 'price_change_24h')@FlexibleDoubleConverter() double? priceChange24h,@JsonKey(name: 'is_mainstream') bool? isMainStream
});


@override $MultilingualCopyWith<$Res>? get narrative;

}
/// @nodoc
class __$TokenDetailInfoCopyWithImpl<$Res>
    implements _$TokenDetailInfoCopyWith<$Res> {
  __$TokenDetailInfoCopyWithImpl(this._self, this._then);

  final _TokenDetailInfo _self;
  final $Res Function(_TokenDetailInfo) _then;

/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priceUsd = freezed,Object? marketCap = freezed,Object? liquidity = freezed,Object? volume24h = freezed,Object? holders = freezed,Object? highestIncreaseRate = freezed,Object? narrative = freezed,Object? isNative = freezed,Object? priceChange24h = freezed,Object? isMainStream = freezed,}) {
  return _then(_TokenDetailInfo(
priceUsd: freezed == priceUsd ? _self.priceUsd : priceUsd // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,liquidity: freezed == liquidity ? _self.liquidity : liquidity // ignore: cast_nullable_to_non_nullable
as double?,volume24h: freezed == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as double?,holders: freezed == holders ? _self.holders : holders // ignore: cast_nullable_to_non_nullable
as int?,highestIncreaseRate: freezed == highestIncreaseRate ? _self.highestIncreaseRate : highestIncreaseRate // ignore: cast_nullable_to_non_nullable
as String?,narrative: freezed == narrative ? _self.narrative : narrative // ignore: cast_nullable_to_non_nullable
as Multilingual?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as double?,isMainStream: freezed == isMainStream ? _self.isMainStream : isMainStream // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of TokenDetailInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get narrative {
    if (_self.narrative == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.narrative!, (value) {
    return _then(_self.copyWith(narrative: value));
  });
}
}

// dart format on
