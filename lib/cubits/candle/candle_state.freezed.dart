// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CandleState {

 List<KLineEntity> get candles; dynamic get network; dynamic get tokenAddress; dynamic get bar; dynamic get limit; dynamic get from; dynamic get to; bool get isLoadingLatest; bool get isLoading; CandlestickLoadingState get loadingState;
/// Create a copy of CandleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandleStateCopyWith<CandleState> get copyWith => _$CandleStateCopyWithImpl<CandleState>(this as CandleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandleState&&const DeepCollectionEquality().equals(other.candles, candles)&&const DeepCollectionEquality().equals(other.network, network)&&const DeepCollectionEquality().equals(other.tokenAddress, tokenAddress)&&const DeepCollectionEquality().equals(other.bar, bar)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.from, from)&&const DeepCollectionEquality().equals(other.to, to)&&(identical(other.isLoadingLatest, isLoadingLatest) || other.isLoadingLatest == isLoadingLatest)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingState, loadingState) || other.loadingState == loadingState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(candles),const DeepCollectionEquality().hash(network),const DeepCollectionEquality().hash(tokenAddress),const DeepCollectionEquality().hash(bar),const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(from),const DeepCollectionEquality().hash(to),isLoadingLatest,isLoading,loadingState);

@override
String toString() {
  return 'CandleState(candles: $candles, network: $network, tokenAddress: $tokenAddress, bar: $bar, limit: $limit, from: $from, to: $to, isLoadingLatest: $isLoadingLatest, isLoading: $isLoading, loadingState: $loadingState)';
}


}

/// @nodoc
abstract mixin class $CandleStateCopyWith<$Res>  {
  factory $CandleStateCopyWith(CandleState value, $Res Function(CandleState) _then) = _$CandleStateCopyWithImpl;
@useResult
$Res call({
 List<KLineEntity> candles, dynamic network, dynamic tokenAddress, dynamic bar, dynamic limit, dynamic from, dynamic to, bool isLoadingLatest, bool isLoading, CandlestickLoadingState loadingState
});




}
/// @nodoc
class _$CandleStateCopyWithImpl<$Res>
    implements $CandleStateCopyWith<$Res> {
  _$CandleStateCopyWithImpl(this._self, this._then);

  final CandleState _self;
  final $Res Function(CandleState) _then;

/// Create a copy of CandleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? candles = null,Object? network = freezed,Object? tokenAddress = freezed,Object? bar = freezed,Object? limit = freezed,Object? from = freezed,Object? to = freezed,Object? isLoadingLatest = null,Object? isLoading = null,Object? loadingState = null,}) {
  return _then(_self.copyWith(
candles: null == candles ? _self.candles : candles // ignore: cast_nullable_to_non_nullable
as List<KLineEntity>,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as dynamic,tokenAddress: freezed == tokenAddress ? _self.tokenAddress : tokenAddress // ignore: cast_nullable_to_non_nullable
as dynamic,bar: freezed == bar ? _self.bar : bar // ignore: cast_nullable_to_non_nullable
as dynamic,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as dynamic,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as dynamic,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as dynamic,isLoadingLatest: null == isLoadingLatest ? _self.isLoadingLatest : isLoadingLatest // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingState: null == loadingState ? _self.loadingState : loadingState // ignore: cast_nullable_to_non_nullable
as CandlestickLoadingState,
  ));
}

}


/// Adds pattern-matching-related methods to [CandleState].
extension CandleStatePatterns on CandleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandleState value)  $default,){
final _that = this;
switch (_that) {
case _CandleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandleState value)?  $default,){
final _that = this;
switch (_that) {
case _CandleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<KLineEntity> candles,  dynamic network,  dynamic tokenAddress,  dynamic bar,  dynamic limit,  dynamic from,  dynamic to,  bool isLoadingLatest,  bool isLoading,  CandlestickLoadingState loadingState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandleState() when $default != null:
return $default(_that.candles,_that.network,_that.tokenAddress,_that.bar,_that.limit,_that.from,_that.to,_that.isLoadingLatest,_that.isLoading,_that.loadingState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<KLineEntity> candles,  dynamic network,  dynamic tokenAddress,  dynamic bar,  dynamic limit,  dynamic from,  dynamic to,  bool isLoadingLatest,  bool isLoading,  CandlestickLoadingState loadingState)  $default,) {final _that = this;
switch (_that) {
case _CandleState():
return $default(_that.candles,_that.network,_that.tokenAddress,_that.bar,_that.limit,_that.from,_that.to,_that.isLoadingLatest,_that.isLoading,_that.loadingState);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<KLineEntity> candles,  dynamic network,  dynamic tokenAddress,  dynamic bar,  dynamic limit,  dynamic from,  dynamic to,  bool isLoadingLatest,  bool isLoading,  CandlestickLoadingState loadingState)?  $default,) {final _that = this;
switch (_that) {
case _CandleState() when $default != null:
return $default(_that.candles,_that.network,_that.tokenAddress,_that.bar,_that.limit,_that.from,_that.to,_that.isLoadingLatest,_that.isLoading,_that.loadingState);case _:
  return null;

}
}

}

/// @nodoc


class _CandleState extends CandleState {
  const _CandleState({final  List<KLineEntity> candles = const [], this.network = '', this.tokenAddress = '', this.bar = 5 * 60, this.limit = 20, this.from = 0, this.to = 0, this.isLoadingLatest = false, this.isLoading = false, this.loadingState = CandlestickLoadingState.initial}): _candles = candles,super._();
  

 final  List<KLineEntity> _candles;
@override@JsonKey() List<KLineEntity> get candles {
  if (_candles is EqualUnmodifiableListView) return _candles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candles);
}

@override@JsonKey() final  dynamic network;
@override@JsonKey() final  dynamic tokenAddress;
@override@JsonKey() final  dynamic bar;
@override@JsonKey() final  dynamic limit;
@override@JsonKey() final  dynamic from;
@override@JsonKey() final  dynamic to;
@override@JsonKey() final  bool isLoadingLatest;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  CandlestickLoadingState loadingState;

/// Create a copy of CandleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandleStateCopyWith<_CandleState> get copyWith => __$CandleStateCopyWithImpl<_CandleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandleState&&const DeepCollectionEquality().equals(other._candles, _candles)&&const DeepCollectionEquality().equals(other.network, network)&&const DeepCollectionEquality().equals(other.tokenAddress, tokenAddress)&&const DeepCollectionEquality().equals(other.bar, bar)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.from, from)&&const DeepCollectionEquality().equals(other.to, to)&&(identical(other.isLoadingLatest, isLoadingLatest) || other.isLoadingLatest == isLoadingLatest)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingState, loadingState) || other.loadingState == loadingState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_candles),const DeepCollectionEquality().hash(network),const DeepCollectionEquality().hash(tokenAddress),const DeepCollectionEquality().hash(bar),const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(from),const DeepCollectionEquality().hash(to),isLoadingLatest,isLoading,loadingState);

@override
String toString() {
  return 'CandleState(candles: $candles, network: $network, tokenAddress: $tokenAddress, bar: $bar, limit: $limit, from: $from, to: $to, isLoadingLatest: $isLoadingLatest, isLoading: $isLoading, loadingState: $loadingState)';
}


}

/// @nodoc
abstract mixin class _$CandleStateCopyWith<$Res> implements $CandleStateCopyWith<$Res> {
  factory _$CandleStateCopyWith(_CandleState value, $Res Function(_CandleState) _then) = __$CandleStateCopyWithImpl;
@override @useResult
$Res call({
 List<KLineEntity> candles, dynamic network, dynamic tokenAddress, dynamic bar, dynamic limit, dynamic from, dynamic to, bool isLoadingLatest, bool isLoading, CandlestickLoadingState loadingState
});




}
/// @nodoc
class __$CandleStateCopyWithImpl<$Res>
    implements _$CandleStateCopyWith<$Res> {
  __$CandleStateCopyWithImpl(this._self, this._then);

  final _CandleState _self;
  final $Res Function(_CandleState) _then;

/// Create a copy of CandleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? candles = null,Object? network = freezed,Object? tokenAddress = freezed,Object? bar = freezed,Object? limit = freezed,Object? from = freezed,Object? to = freezed,Object? isLoadingLatest = null,Object? isLoading = null,Object? loadingState = null,}) {
  return _then(_CandleState(
candles: null == candles ? _self._candles : candles // ignore: cast_nullable_to_non_nullable
as List<KLineEntity>,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as dynamic,tokenAddress: freezed == tokenAddress ? _self.tokenAddress : tokenAddress // ignore: cast_nullable_to_non_nullable
as dynamic,bar: freezed == bar ? _self.bar : bar // ignore: cast_nullable_to_non_nullable
as dynamic,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as dynamic,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as dynamic,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as dynamic,isLoadingLatest: null == isLoadingLatest ? _self.isLoadingLatest : isLoadingLatest // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingState: null == loadingState ? _self.loadingState : loadingState // ignore: cast_nullable_to_non_nullable
as CandlestickLoadingState,
  ));
}


}

// dart format on
