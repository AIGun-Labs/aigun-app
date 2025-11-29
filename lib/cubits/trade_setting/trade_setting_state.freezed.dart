// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_setting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetTradeSettingStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTradeSettingStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetTradeSettingStatus()';
}


}

/// @nodoc
class $GetTradeSettingStatusCopyWith<$Res>  {
$GetTradeSettingStatusCopyWith(GetTradeSettingStatus _, $Res Function(GetTradeSettingStatus) __);
}


/// Adds pattern-matching-related methods to [GetTradeSettingStatus].
extension GetTradeSettingStatusPatterns on GetTradeSettingStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetTradeSettingInitial value)?  initial,TResult Function( _GetTradeSettingLoading value)?  loading,TResult Function( _GetTradeSettingSuccess value)?  success,TResult Function( _GetTradeSettingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetTradeSettingInitial() when initial != null:
return initial(_that);case _GetTradeSettingLoading() when loading != null:
return loading(_that);case _GetTradeSettingSuccess() when success != null:
return success(_that);case _GetTradeSettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetTradeSettingInitial value)  initial,required TResult Function( _GetTradeSettingLoading value)  loading,required TResult Function( _GetTradeSettingSuccess value)  success,required TResult Function( _GetTradeSettingError value)  error,}){
final _that = this;
switch (_that) {
case _GetTradeSettingInitial():
return initial(_that);case _GetTradeSettingLoading():
return loading(_that);case _GetTradeSettingSuccess():
return success(_that);case _GetTradeSettingError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetTradeSettingInitial value)?  initial,TResult? Function( _GetTradeSettingLoading value)?  loading,TResult? Function( _GetTradeSettingSuccess value)?  success,TResult? Function( _GetTradeSettingError value)?  error,}){
final _that = this;
switch (_that) {
case _GetTradeSettingInitial() when initial != null:
return initial(_that);case _GetTradeSettingLoading() when loading != null:
return loading(_that);case _GetTradeSettingSuccess() when success != null:
return success(_that);case _GetTradeSettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TradeConfig tradeConfig)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetTradeSettingInitial() when initial != null:
return initial();case _GetTradeSettingLoading() when loading != null:
return loading();case _GetTradeSettingSuccess() when success != null:
return success(_that.tradeConfig);case _GetTradeSettingError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TradeConfig tradeConfig)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _GetTradeSettingInitial():
return initial();case _GetTradeSettingLoading():
return loading();case _GetTradeSettingSuccess():
return success(_that.tradeConfig);case _GetTradeSettingError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TradeConfig tradeConfig)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _GetTradeSettingInitial() when initial != null:
return initial();case _GetTradeSettingLoading() when loading != null:
return loading();case _GetTradeSettingSuccess() when success != null:
return success(_that.tradeConfig);case _GetTradeSettingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _GetTradeSettingInitial implements GetTradeSettingStatus {
  const _GetTradeSettingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTradeSettingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetTradeSettingStatus.initial()';
}


}




/// @nodoc


class _GetTradeSettingLoading implements GetTradeSettingStatus {
  const _GetTradeSettingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTradeSettingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetTradeSettingStatus.loading()';
}


}




/// @nodoc


class _GetTradeSettingSuccess implements GetTradeSettingStatus {
  const _GetTradeSettingSuccess(this.tradeConfig);
  

 final  TradeConfig tradeConfig;

/// Create a copy of GetTradeSettingStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTradeSettingSuccessCopyWith<_GetTradeSettingSuccess> get copyWith => __$GetTradeSettingSuccessCopyWithImpl<_GetTradeSettingSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTradeSettingSuccess&&(identical(other.tradeConfig, tradeConfig) || other.tradeConfig == tradeConfig));
}


@override
int get hashCode => Object.hash(runtimeType,tradeConfig);

@override
String toString() {
  return 'GetTradeSettingStatus.success(tradeConfig: $tradeConfig)';
}


}

/// @nodoc
abstract mixin class _$GetTradeSettingSuccessCopyWith<$Res> implements $GetTradeSettingStatusCopyWith<$Res> {
  factory _$GetTradeSettingSuccessCopyWith(_GetTradeSettingSuccess value, $Res Function(_GetTradeSettingSuccess) _then) = __$GetTradeSettingSuccessCopyWithImpl;
@useResult
$Res call({
 TradeConfig tradeConfig
});


$TradeConfigCopyWith<$Res> get tradeConfig;

}
/// @nodoc
class __$GetTradeSettingSuccessCopyWithImpl<$Res>
    implements _$GetTradeSettingSuccessCopyWith<$Res> {
  __$GetTradeSettingSuccessCopyWithImpl(this._self, this._then);

  final _GetTradeSettingSuccess _self;
  final $Res Function(_GetTradeSettingSuccess) _then;

/// Create a copy of GetTradeSettingStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tradeConfig = null,}) {
  return _then(_GetTradeSettingSuccess(
null == tradeConfig ? _self.tradeConfig : tradeConfig // ignore: cast_nullable_to_non_nullable
as TradeConfig,
  ));
}

/// Create a copy of GetTradeSettingStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeConfigCopyWith<$Res> get tradeConfig {
  
  return $TradeConfigCopyWith<$Res>(_self.tradeConfig, (value) {
    return _then(_self.copyWith(tradeConfig: value));
  });
}
}

/// @nodoc


class _GetTradeSettingError implements GetTradeSettingStatus {
  const _GetTradeSettingError(this.message);
  

 final  String message;

/// Create a copy of GetTradeSettingStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTradeSettingErrorCopyWith<_GetTradeSettingError> get copyWith => __$GetTradeSettingErrorCopyWithImpl<_GetTradeSettingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTradeSettingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GetTradeSettingStatus.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$GetTradeSettingErrorCopyWith<$Res> implements $GetTradeSettingStatusCopyWith<$Res> {
  factory _$GetTradeSettingErrorCopyWith(_GetTradeSettingError value, $Res Function(_GetTradeSettingError) _then) = __$GetTradeSettingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$GetTradeSettingErrorCopyWithImpl<$Res>
    implements _$GetTradeSettingErrorCopyWith<$Res> {
  __$GetTradeSettingErrorCopyWithImpl(this._self, this._then);

  final _GetTradeSettingError _self;
  final $Res Function(_GetTradeSettingError) _then;

/// Create a copy of GetTradeSettingStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_GetTradeSettingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TradeSettingStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TradeSettingStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeSettingStatus()';
}


}

/// @nodoc
class $TradeSettingStatusCopyWith<$Res>  {
$TradeSettingStatusCopyWith(TradeSettingStatus _, $Res Function(TradeSettingStatus) __);
}


/// Adds pattern-matching-related methods to [TradeSettingStatus].
extension TradeSettingStatusPatterns on TradeSettingStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TradeSettingInitial value)?  initial,TResult Function( _TradeSettingLoading value)?  loading,TResult Function( _TradeSettingSuccess value)?  success,TResult Function( _TradeSettingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TradeSettingInitial() when initial != null:
return initial(_that);case _TradeSettingLoading() when loading != null:
return loading(_that);case _TradeSettingSuccess() when success != null:
return success(_that);case _TradeSettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TradeSettingInitial value)  initial,required TResult Function( _TradeSettingLoading value)  loading,required TResult Function( _TradeSettingSuccess value)  success,required TResult Function( _TradeSettingError value)  error,}){
final _that = this;
switch (_that) {
case _TradeSettingInitial():
return initial(_that);case _TradeSettingLoading():
return loading(_that);case _TradeSettingSuccess():
return success(_that);case _TradeSettingError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TradeSettingInitial value)?  initial,TResult? Function( _TradeSettingLoading value)?  loading,TResult? Function( _TradeSettingSuccess value)?  success,TResult? Function( _TradeSettingError value)?  error,}){
final _that = this;
switch (_that) {
case _TradeSettingInitial() when initial != null:
return initial(_that);case _TradeSettingLoading() when loading != null:
return loading(_that);case _TradeSettingSuccess() when success != null:
return success(_that);case _TradeSettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TradeSettingInitial() when initial != null:
return initial();case _TradeSettingLoading() when loading != null:
return loading();case _TradeSettingSuccess() when success != null:
return success();case _TradeSettingError() when error != null:
return error();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case _TradeSettingInitial():
return initial();case _TradeSettingLoading():
return loading();case _TradeSettingSuccess():
return success();case _TradeSettingError():
return error();case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case _TradeSettingInitial() when initial != null:
return initial();case _TradeSettingLoading() when loading != null:
return loading();case _TradeSettingSuccess() when success != null:
return success();case _TradeSettingError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class _TradeSettingInitial implements TradeSettingStatus {
  const _TradeSettingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeSettingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeSettingStatus.initial()';
}


}




/// @nodoc


class _TradeSettingLoading implements TradeSettingStatus {
  const _TradeSettingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeSettingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeSettingStatus.loading()';
}


}




/// @nodoc


class _TradeSettingSuccess implements TradeSettingStatus {
  const _TradeSettingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeSettingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeSettingStatus.success()';
}


}




/// @nodoc


class _TradeSettingError implements TradeSettingStatus {
  const _TradeSettingError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeSettingError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeSettingStatus.error()';
}


}




/// @nodoc
mixin _$TradeLiveDataStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TradeLiveDataStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeLiveDataStatus()';
}


}

/// @nodoc
class $TradeLiveDataStatusCopyWith<$Res>  {
$TradeLiveDataStatusCopyWith(TradeLiveDataStatus _, $Res Function(TradeLiveDataStatus) __);
}


/// Adds pattern-matching-related methods to [TradeLiveDataStatus].
extension TradeLiveDataStatusPatterns on TradeLiveDataStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TradeLiveDataInitial value)?  initial,TResult Function( _TradeLiveDataLoading value)?  loading,TResult Function( _TradeLiveDataSuccess value)?  success,TResult Function( _TradeLiveDataError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TradeLiveDataInitial() when initial != null:
return initial(_that);case _TradeLiveDataLoading() when loading != null:
return loading(_that);case _TradeLiveDataSuccess() when success != null:
return success(_that);case _TradeLiveDataError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TradeLiveDataInitial value)  initial,required TResult Function( _TradeLiveDataLoading value)  loading,required TResult Function( _TradeLiveDataSuccess value)  success,required TResult Function( _TradeLiveDataError value)  error,}){
final _that = this;
switch (_that) {
case _TradeLiveDataInitial():
return initial(_that);case _TradeLiveDataLoading():
return loading(_that);case _TradeLiveDataSuccess():
return success(_that);case _TradeLiveDataError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TradeLiveDataInitial value)?  initial,TResult? Function( _TradeLiveDataLoading value)?  loading,TResult? Function( _TradeLiveDataSuccess value)?  success,TResult? Function( _TradeLiveDataError value)?  error,}){
final _that = this;
switch (_that) {
case _TradeLiveDataInitial() when initial != null:
return initial(_that);case _TradeLiveDataLoading() when loading != null:
return loading(_that);case _TradeLiveDataSuccess() when success != null:
return success(_that);case _TradeLiveDataError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TradeLiveData liveData)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TradeLiveDataInitial() when initial != null:
return initial();case _TradeLiveDataLoading() when loading != null:
return loading();case _TradeLiveDataSuccess() when success != null:
return success(_that.liveData);case _TradeLiveDataError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TradeLiveData liveData)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _TradeLiveDataInitial():
return initial();case _TradeLiveDataLoading():
return loading();case _TradeLiveDataSuccess():
return success(_that.liveData);case _TradeLiveDataError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TradeLiveData liveData)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _TradeLiveDataInitial() when initial != null:
return initial();case _TradeLiveDataLoading() when loading != null:
return loading();case _TradeLiveDataSuccess() when success != null:
return success(_that.liveData);case _TradeLiveDataError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _TradeLiveDataInitial implements TradeLiveDataStatus {
  const _TradeLiveDataInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeLiveDataInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeLiveDataStatus.initial()';
}


}




/// @nodoc


class _TradeLiveDataLoading implements TradeLiveDataStatus {
  const _TradeLiveDataLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeLiveDataLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TradeLiveDataStatus.loading()';
}


}




/// @nodoc


class _TradeLiveDataSuccess implements TradeLiveDataStatus {
  const _TradeLiveDataSuccess(this.liveData);
  

 final  TradeLiveData liveData;

/// Create a copy of TradeLiveDataStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeLiveDataSuccessCopyWith<_TradeLiveDataSuccess> get copyWith => __$TradeLiveDataSuccessCopyWithImpl<_TradeLiveDataSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeLiveDataSuccess&&(identical(other.liveData, liveData) || other.liveData == liveData));
}


@override
int get hashCode => Object.hash(runtimeType,liveData);

@override
String toString() {
  return 'TradeLiveDataStatus.success(liveData: $liveData)';
}


}

/// @nodoc
abstract mixin class _$TradeLiveDataSuccessCopyWith<$Res> implements $TradeLiveDataStatusCopyWith<$Res> {
  factory _$TradeLiveDataSuccessCopyWith(_TradeLiveDataSuccess value, $Res Function(_TradeLiveDataSuccess) _then) = __$TradeLiveDataSuccessCopyWithImpl;
@useResult
$Res call({
 TradeLiveData liveData
});


$TradeLiveDataCopyWith<$Res> get liveData;

}
/// @nodoc
class __$TradeLiveDataSuccessCopyWithImpl<$Res>
    implements _$TradeLiveDataSuccessCopyWith<$Res> {
  __$TradeLiveDataSuccessCopyWithImpl(this._self, this._then);

  final _TradeLiveDataSuccess _self;
  final $Res Function(_TradeLiveDataSuccess) _then;

/// Create a copy of TradeLiveDataStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? liveData = null,}) {
  return _then(_TradeLiveDataSuccess(
null == liveData ? _self.liveData : liveData // ignore: cast_nullable_to_non_nullable
as TradeLiveData,
  ));
}

/// Create a copy of TradeLiveDataStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeLiveDataCopyWith<$Res> get liveData {
  
  return $TradeLiveDataCopyWith<$Res>(_self.liveData, (value) {
    return _then(_self.copyWith(liveData: value));
  });
}
}

/// @nodoc


class _TradeLiveDataError implements TradeLiveDataStatus {
  const _TradeLiveDataError(this.message);
  

 final  String message;

/// Create a copy of TradeLiveDataStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeLiveDataErrorCopyWith<_TradeLiveDataError> get copyWith => __$TradeLiveDataErrorCopyWithImpl<_TradeLiveDataError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeLiveDataError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TradeLiveDataStatus.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$TradeLiveDataErrorCopyWith<$Res> implements $TradeLiveDataStatusCopyWith<$Res> {
  factory _$TradeLiveDataErrorCopyWith(_TradeLiveDataError value, $Res Function(_TradeLiveDataError) _then) = __$TradeLiveDataErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$TradeLiveDataErrorCopyWithImpl<$Res>
    implements _$TradeLiveDataErrorCopyWith<$Res> {
  __$TradeLiveDataErrorCopyWithImpl(this._self, this._then);

  final _TradeLiveDataError _self;
  final $Res Function(_TradeLiveDataError) _then;

/// Create a copy of TradeLiveDataStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_TradeLiveDataError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TradeSettingState {

 String get network; Map<String, TradeCustomSetting> get customSettings;@JsonKey(includeFromJson: false, includeToJson: false) GetTradeSettingStatus get getTradeSettingStatus;@JsonKey(includeFromJson: false, includeToJson: false) TradeSettingStatus get tradeSettingStatus; TradeLiveData get liveData;@JsonKey(includeFromJson: false, includeToJson: false) TradeLiveDataStatus get liveDataStatus;
/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TradeSettingStateCopyWith<TradeSettingState> get copyWith => _$TradeSettingStateCopyWithImpl<TradeSettingState>(this as TradeSettingState, _$identity);

  /// Serializes this TradeSettingState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TradeSettingState&&(identical(other.network, network) || other.network == network)&&const DeepCollectionEquality().equals(other.customSettings, customSettings)&&(identical(other.getTradeSettingStatus, getTradeSettingStatus) || other.getTradeSettingStatus == getTradeSettingStatus)&&(identical(other.tradeSettingStatus, tradeSettingStatus) || other.tradeSettingStatus == tradeSettingStatus)&&(identical(other.liveData, liveData) || other.liveData == liveData)&&(identical(other.liveDataStatus, liveDataStatus) || other.liveDataStatus == liveDataStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,const DeepCollectionEquality().hash(customSettings),getTradeSettingStatus,tradeSettingStatus,liveData,liveDataStatus);

@override
String toString() {
  return 'TradeSettingState(network: $network, customSettings: $customSettings, getTradeSettingStatus: $getTradeSettingStatus, tradeSettingStatus: $tradeSettingStatus, liveData: $liveData, liveDataStatus: $liveDataStatus)';
}


}

/// @nodoc
abstract mixin class $TradeSettingStateCopyWith<$Res>  {
  factory $TradeSettingStateCopyWith(TradeSettingState value, $Res Function(TradeSettingState) _then) = _$TradeSettingStateCopyWithImpl;
@useResult
$Res call({
 String network, Map<String, TradeCustomSetting> customSettings,@JsonKey(includeFromJson: false, includeToJson: false) GetTradeSettingStatus getTradeSettingStatus,@JsonKey(includeFromJson: false, includeToJson: false) TradeSettingStatus tradeSettingStatus, TradeLiveData liveData,@JsonKey(includeFromJson: false, includeToJson: false) TradeLiveDataStatus liveDataStatus
});


$GetTradeSettingStatusCopyWith<$Res> get getTradeSettingStatus;$TradeSettingStatusCopyWith<$Res> get tradeSettingStatus;$TradeLiveDataCopyWith<$Res> get liveData;$TradeLiveDataStatusCopyWith<$Res> get liveDataStatus;

}
/// @nodoc
class _$TradeSettingStateCopyWithImpl<$Res>
    implements $TradeSettingStateCopyWith<$Res> {
  _$TradeSettingStateCopyWithImpl(this._self, this._then);

  final TradeSettingState _self;
  final $Res Function(TradeSettingState) _then;

/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? customSettings = null,Object? getTradeSettingStatus = null,Object? tradeSettingStatus = null,Object? liveData = null,Object? liveDataStatus = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,customSettings: null == customSettings ? _self.customSettings : customSettings // ignore: cast_nullable_to_non_nullable
as Map<String, TradeCustomSetting>,getTradeSettingStatus: null == getTradeSettingStatus ? _self.getTradeSettingStatus : getTradeSettingStatus // ignore: cast_nullable_to_non_nullable
as GetTradeSettingStatus,tradeSettingStatus: null == tradeSettingStatus ? _self.tradeSettingStatus : tradeSettingStatus // ignore: cast_nullable_to_non_nullable
as TradeSettingStatus,liveData: null == liveData ? _self.liveData : liveData // ignore: cast_nullable_to_non_nullable
as TradeLiveData,liveDataStatus: null == liveDataStatus ? _self.liveDataStatus : liveDataStatus // ignore: cast_nullable_to_non_nullable
as TradeLiveDataStatus,
  ));
}
/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetTradeSettingStatusCopyWith<$Res> get getTradeSettingStatus {
  
  return $GetTradeSettingStatusCopyWith<$Res>(_self.getTradeSettingStatus, (value) {
    return _then(_self.copyWith(getTradeSettingStatus: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeSettingStatusCopyWith<$Res> get tradeSettingStatus {
  
  return $TradeSettingStatusCopyWith<$Res>(_self.tradeSettingStatus, (value) {
    return _then(_self.copyWith(tradeSettingStatus: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeLiveDataCopyWith<$Res> get liveData {
  
  return $TradeLiveDataCopyWith<$Res>(_self.liveData, (value) {
    return _then(_self.copyWith(liveData: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeLiveDataStatusCopyWith<$Res> get liveDataStatus {
  
  return $TradeLiveDataStatusCopyWith<$Res>(_self.liveDataStatus, (value) {
    return _then(_self.copyWith(liveDataStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [TradeSettingState].
extension TradeSettingStatePatterns on TradeSettingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TradeSettingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TradeSettingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TradeSettingState value)  $default,){
final _that = this;
switch (_that) {
case _TradeSettingState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TradeSettingState value)?  $default,){
final _that = this;
switch (_that) {
case _TradeSettingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String network,  Map<String, TradeCustomSetting> customSettings, @JsonKey(includeFromJson: false, includeToJson: false)  GetTradeSettingStatus getTradeSettingStatus, @JsonKey(includeFromJson: false, includeToJson: false)  TradeSettingStatus tradeSettingStatus,  TradeLiveData liveData, @JsonKey(includeFromJson: false, includeToJson: false)  TradeLiveDataStatus liveDataStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TradeSettingState() when $default != null:
return $default(_that.network,_that.customSettings,_that.getTradeSettingStatus,_that.tradeSettingStatus,_that.liveData,_that.liveDataStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String network,  Map<String, TradeCustomSetting> customSettings, @JsonKey(includeFromJson: false, includeToJson: false)  GetTradeSettingStatus getTradeSettingStatus, @JsonKey(includeFromJson: false, includeToJson: false)  TradeSettingStatus tradeSettingStatus,  TradeLiveData liveData, @JsonKey(includeFromJson: false, includeToJson: false)  TradeLiveDataStatus liveDataStatus)  $default,) {final _that = this;
switch (_that) {
case _TradeSettingState():
return $default(_that.network,_that.customSettings,_that.getTradeSettingStatus,_that.tradeSettingStatus,_that.liveData,_that.liveDataStatus);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String network,  Map<String, TradeCustomSetting> customSettings, @JsonKey(includeFromJson: false, includeToJson: false)  GetTradeSettingStatus getTradeSettingStatus, @JsonKey(includeFromJson: false, includeToJson: false)  TradeSettingStatus tradeSettingStatus,  TradeLiveData liveData, @JsonKey(includeFromJson: false, includeToJson: false)  TradeLiveDataStatus liveDataStatus)?  $default,) {final _that = this;
switch (_that) {
case _TradeSettingState() when $default != null:
return $default(_that.network,_that.customSettings,_that.getTradeSettingStatus,_that.tradeSettingStatus,_that.liveData,_that.liveDataStatus);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _TradeSettingState extends TradeSettingState {
   _TradeSettingState({this.network = "solana", final  Map<String, TradeCustomSetting> customSettings = const {}, @JsonKey(includeFromJson: false, includeToJson: false) this.getTradeSettingStatus = const GetTradeSettingStatus.initial(), @JsonKey(includeFromJson: false, includeToJson: false) this.tradeSettingStatus = const TradeSettingStatus.initial(), this.liveData = const TradeLiveData(), @JsonKey(includeFromJson: false, includeToJson: false) this.liveDataStatus = const TradeLiveDataStatus.initial()}): _customSettings = customSettings,super._();
  factory _TradeSettingState.fromJson(Map<String, dynamic> json) => _$TradeSettingStateFromJson(json);

@override@JsonKey() final  String network;
 final  Map<String, TradeCustomSetting> _customSettings;
@override@JsonKey() Map<String, TradeCustomSetting> get customSettings {
  if (_customSettings is EqualUnmodifiableMapView) return _customSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customSettings);
}

@override@JsonKey(includeFromJson: false, includeToJson: false) final  GetTradeSettingStatus getTradeSettingStatus;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  TradeSettingStatus tradeSettingStatus;
@override@JsonKey() final  TradeLiveData liveData;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  TradeLiveDataStatus liveDataStatus;

/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeSettingStateCopyWith<_TradeSettingState> get copyWith => __$TradeSettingStateCopyWithImpl<_TradeSettingState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TradeSettingStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeSettingState&&(identical(other.network, network) || other.network == network)&&const DeepCollectionEquality().equals(other._customSettings, _customSettings)&&(identical(other.getTradeSettingStatus, getTradeSettingStatus) || other.getTradeSettingStatus == getTradeSettingStatus)&&(identical(other.tradeSettingStatus, tradeSettingStatus) || other.tradeSettingStatus == tradeSettingStatus)&&(identical(other.liveData, liveData) || other.liveData == liveData)&&(identical(other.liveDataStatus, liveDataStatus) || other.liveDataStatus == liveDataStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,const DeepCollectionEquality().hash(_customSettings),getTradeSettingStatus,tradeSettingStatus,liveData,liveDataStatus);

@override
String toString() {
  return 'TradeSettingState(network: $network, customSettings: $customSettings, getTradeSettingStatus: $getTradeSettingStatus, tradeSettingStatus: $tradeSettingStatus, liveData: $liveData, liveDataStatus: $liveDataStatus)';
}


}

/// @nodoc
abstract mixin class _$TradeSettingStateCopyWith<$Res> implements $TradeSettingStateCopyWith<$Res> {
  factory _$TradeSettingStateCopyWith(_TradeSettingState value, $Res Function(_TradeSettingState) _then) = __$TradeSettingStateCopyWithImpl;
@override @useResult
$Res call({
 String network, Map<String, TradeCustomSetting> customSettings,@JsonKey(includeFromJson: false, includeToJson: false) GetTradeSettingStatus getTradeSettingStatus,@JsonKey(includeFromJson: false, includeToJson: false) TradeSettingStatus tradeSettingStatus, TradeLiveData liveData,@JsonKey(includeFromJson: false, includeToJson: false) TradeLiveDataStatus liveDataStatus
});


@override $GetTradeSettingStatusCopyWith<$Res> get getTradeSettingStatus;@override $TradeSettingStatusCopyWith<$Res> get tradeSettingStatus;@override $TradeLiveDataCopyWith<$Res> get liveData;@override $TradeLiveDataStatusCopyWith<$Res> get liveDataStatus;

}
/// @nodoc
class __$TradeSettingStateCopyWithImpl<$Res>
    implements _$TradeSettingStateCopyWith<$Res> {
  __$TradeSettingStateCopyWithImpl(this._self, this._then);

  final _TradeSettingState _self;
  final $Res Function(_TradeSettingState) _then;

/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? customSettings = null,Object? getTradeSettingStatus = null,Object? tradeSettingStatus = null,Object? liveData = null,Object? liveDataStatus = null,}) {
  return _then(_TradeSettingState(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,customSettings: null == customSettings ? _self._customSettings : customSettings // ignore: cast_nullable_to_non_nullable
as Map<String, TradeCustomSetting>,getTradeSettingStatus: null == getTradeSettingStatus ? _self.getTradeSettingStatus : getTradeSettingStatus // ignore: cast_nullable_to_non_nullable
as GetTradeSettingStatus,tradeSettingStatus: null == tradeSettingStatus ? _self.tradeSettingStatus : tradeSettingStatus // ignore: cast_nullable_to_non_nullable
as TradeSettingStatus,liveData: null == liveData ? _self.liveData : liveData // ignore: cast_nullable_to_non_nullable
as TradeLiveData,liveDataStatus: null == liveDataStatus ? _self.liveDataStatus : liveDataStatus // ignore: cast_nullable_to_non_nullable
as TradeLiveDataStatus,
  ));
}

/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetTradeSettingStatusCopyWith<$Res> get getTradeSettingStatus {
  
  return $GetTradeSettingStatusCopyWith<$Res>(_self.getTradeSettingStatus, (value) {
    return _then(_self.copyWith(getTradeSettingStatus: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeSettingStatusCopyWith<$Res> get tradeSettingStatus {
  
  return $TradeSettingStatusCopyWith<$Res>(_self.tradeSettingStatus, (value) {
    return _then(_self.copyWith(tradeSettingStatus: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeLiveDataCopyWith<$Res> get liveData {
  
  return $TradeLiveDataCopyWith<$Res>(_self.liveData, (value) {
    return _then(_self.copyWith(liveData: value));
  });
}/// Create a copy of TradeSettingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeLiveDataStatusCopyWith<$Res> get liveDataStatus {
  
  return $TradeLiveDataStatusCopyWith<$Res>(_self.liveDataStatus, (value) {
    return _then(_self.copyWith(liveDataStatus: value));
  });
}
}

// dart format on
