// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkStatus {

 ServerHealthyStatus? get status; String? get details;@JsonKey(name: 'response_time') int? get responseTime;
/// Create a copy of NetworkStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<NetworkStatus> get copyWith => _$NetworkStatusCopyWithImpl<NetworkStatus>(this as NetworkStatus, _$identity);

  /// Serializes this NetworkStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkStatus&&(identical(other.status, status) || other.status == status)&&(identical(other.details, details) || other.details == details)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,details,responseTime);

@override
String toString() {
  return 'NetworkStatus(status: $status, details: $details, responseTime: $responseTime)';
}


}

/// @nodoc
abstract mixin class $NetworkStatusCopyWith<$Res>  {
  factory $NetworkStatusCopyWith(NetworkStatus value, $Res Function(NetworkStatus) _then) = _$NetworkStatusCopyWithImpl;
@useResult
$Res call({
 ServerHealthyStatus? status, String? details,@JsonKey(name: 'response_time') int? responseTime
});




}
/// @nodoc
class _$NetworkStatusCopyWithImpl<$Res>
    implements $NetworkStatusCopyWith<$Res> {
  _$NetworkStatusCopyWithImpl(this._self, this._then);

  final NetworkStatus _self;
  final $Res Function(NetworkStatus) _then;

/// Create a copy of NetworkStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? details = freezed,Object? responseTime = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerHealthyStatus?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,responseTime: freezed == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkStatus].
extension NetworkStatusPatterns on NetworkStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkStatus value)  $default,){
final _that = this;
switch (_that) {
case _NetworkStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkStatus value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServerHealthyStatus? status,  String? details, @JsonKey(name: 'response_time')  int? responseTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkStatus() when $default != null:
return $default(_that.status,_that.details,_that.responseTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServerHealthyStatus? status,  String? details, @JsonKey(name: 'response_time')  int? responseTime)  $default,) {final _that = this;
switch (_that) {
case _NetworkStatus():
return $default(_that.status,_that.details,_that.responseTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServerHealthyStatus? status,  String? details, @JsonKey(name: 'response_time')  int? responseTime)?  $default,) {final _that = this;
switch (_that) {
case _NetworkStatus() when $default != null:
return $default(_that.status,_that.details,_that.responseTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkStatus implements NetworkStatus {
  const _NetworkStatus({this.status, this.details, @JsonKey(name: 'response_time') this.responseTime});
  factory _NetworkStatus.fromJson(Map<String, dynamic> json) => _$NetworkStatusFromJson(json);

@override final  ServerHealthyStatus? status;
@override final  String? details;
@override@JsonKey(name: 'response_time') final  int? responseTime;

/// Create a copy of NetworkStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkStatusCopyWith<_NetworkStatus> get copyWith => __$NetworkStatusCopyWithImpl<_NetworkStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkStatus&&(identical(other.status, status) || other.status == status)&&(identical(other.details, details) || other.details == details)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,details,responseTime);

@override
String toString() {
  return 'NetworkStatus(status: $status, details: $details, responseTime: $responseTime)';
}


}

/// @nodoc
abstract mixin class _$NetworkStatusCopyWith<$Res> implements $NetworkStatusCopyWith<$Res> {
  factory _$NetworkStatusCopyWith(_NetworkStatus value, $Res Function(_NetworkStatus) _then) = __$NetworkStatusCopyWithImpl;
@override @useResult
$Res call({
 ServerHealthyStatus? status, String? details,@JsonKey(name: 'response_time') int? responseTime
});




}
/// @nodoc
class __$NetworkStatusCopyWithImpl<$Res>
    implements _$NetworkStatusCopyWith<$Res> {
  __$NetworkStatusCopyWithImpl(this._self, this._then);

  final _NetworkStatus _self;
  final $Res Function(_NetworkStatus) _then;

/// Create a copy of NetworkStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? details = freezed,Object? responseTime = freezed,}) {
  return _then(_NetworkStatus(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerHealthyStatus?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,responseTime: freezed == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$NetworkResult {

 ServerHealthyStatus? get status; int? get timestamp; NetworkStatus? get database; NetworkStatus? get redis; NetworkStatus? get rabbitmq;
/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkResultCopyWith<NetworkResult> get copyWith => _$NetworkResultCopyWithImpl<NetworkResult>(this as NetworkResult, _$identity);

  /// Serializes this NetworkResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkResult&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.database, database) || other.database == database)&&(identical(other.redis, redis) || other.redis == redis)&&(identical(other.rabbitmq, rabbitmq) || other.rabbitmq == rabbitmq));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,database,redis,rabbitmq);

@override
String toString() {
  return 'NetworkResult(status: $status, timestamp: $timestamp, database: $database, redis: $redis, rabbitmq: $rabbitmq)';
}


}

/// @nodoc
abstract mixin class $NetworkResultCopyWith<$Res>  {
  factory $NetworkResultCopyWith(NetworkResult value, $Res Function(NetworkResult) _then) = _$NetworkResultCopyWithImpl;
@useResult
$Res call({
 ServerHealthyStatus? status, int? timestamp, NetworkStatus? database, NetworkStatus? redis, NetworkStatus? rabbitmq
});


$NetworkStatusCopyWith<$Res>? get database;$NetworkStatusCopyWith<$Res>? get redis;$NetworkStatusCopyWith<$Res>? get rabbitmq;

}
/// @nodoc
class _$NetworkResultCopyWithImpl<$Res>
    implements $NetworkResultCopyWith<$Res> {
  _$NetworkResultCopyWithImpl(this._self, this._then);

  final NetworkResult _self;
  final $Res Function(NetworkResult) _then;

/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? timestamp = freezed,Object? database = freezed,Object? redis = freezed,Object? rabbitmq = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerHealthyStatus?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,database: freezed == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,redis: freezed == redis ? _self.redis : redis // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,rabbitmq: freezed == rabbitmq ? _self.rabbitmq : rabbitmq // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,
  ));
}
/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get database {
    if (_self.database == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.database!, (value) {
    return _then(_self.copyWith(database: value));
  });
}/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get redis {
    if (_self.redis == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.redis!, (value) {
    return _then(_self.copyWith(redis: value));
  });
}/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get rabbitmq {
    if (_self.rabbitmq == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.rabbitmq!, (value) {
    return _then(_self.copyWith(rabbitmq: value));
  });
}
}


/// Adds pattern-matching-related methods to [NetworkResult].
extension NetworkResultPatterns on NetworkResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkResult value)  $default,){
final _that = this;
switch (_that) {
case _NetworkResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkResult value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServerHealthyStatus? status,  int? timestamp,  NetworkStatus? database,  NetworkStatus? redis,  NetworkStatus? rabbitmq)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkResult() when $default != null:
return $default(_that.status,_that.timestamp,_that.database,_that.redis,_that.rabbitmq);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServerHealthyStatus? status,  int? timestamp,  NetworkStatus? database,  NetworkStatus? redis,  NetworkStatus? rabbitmq)  $default,) {final _that = this;
switch (_that) {
case _NetworkResult():
return $default(_that.status,_that.timestamp,_that.database,_that.redis,_that.rabbitmq);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServerHealthyStatus? status,  int? timestamp,  NetworkStatus? database,  NetworkStatus? redis,  NetworkStatus? rabbitmq)?  $default,) {final _that = this;
switch (_that) {
case _NetworkResult() when $default != null:
return $default(_that.status,_that.timestamp,_that.database,_that.redis,_that.rabbitmq);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkResult implements NetworkResult {
  const _NetworkResult({this.status, this.timestamp, this.database, this.redis, this.rabbitmq});
  factory _NetworkResult.fromJson(Map<String, dynamic> json) => _$NetworkResultFromJson(json);

@override final  ServerHealthyStatus? status;
@override final  int? timestamp;
@override final  NetworkStatus? database;
@override final  NetworkStatus? redis;
@override final  NetworkStatus? rabbitmq;

/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkResultCopyWith<_NetworkResult> get copyWith => __$NetworkResultCopyWithImpl<_NetworkResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkResult&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.database, database) || other.database == database)&&(identical(other.redis, redis) || other.redis == redis)&&(identical(other.rabbitmq, rabbitmq) || other.rabbitmq == rabbitmq));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,database,redis,rabbitmq);

@override
String toString() {
  return 'NetworkResult(status: $status, timestamp: $timestamp, database: $database, redis: $redis, rabbitmq: $rabbitmq)';
}


}

/// @nodoc
abstract mixin class _$NetworkResultCopyWith<$Res> implements $NetworkResultCopyWith<$Res> {
  factory _$NetworkResultCopyWith(_NetworkResult value, $Res Function(_NetworkResult) _then) = __$NetworkResultCopyWithImpl;
@override @useResult
$Res call({
 ServerHealthyStatus? status, int? timestamp, NetworkStatus? database, NetworkStatus? redis, NetworkStatus? rabbitmq
});


@override $NetworkStatusCopyWith<$Res>? get database;@override $NetworkStatusCopyWith<$Res>? get redis;@override $NetworkStatusCopyWith<$Res>? get rabbitmq;

}
/// @nodoc
class __$NetworkResultCopyWithImpl<$Res>
    implements _$NetworkResultCopyWith<$Res> {
  __$NetworkResultCopyWithImpl(this._self, this._then);

  final _NetworkResult _self;
  final $Res Function(_NetworkResult) _then;

/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? timestamp = freezed,Object? database = freezed,Object? redis = freezed,Object? rabbitmq = freezed,}) {
  return _then(_NetworkResult(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerHealthyStatus?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,database: freezed == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,redis: freezed == redis ? _self.redis : redis // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,rabbitmq: freezed == rabbitmq ? _self.rabbitmq : rabbitmq // ignore: cast_nullable_to_non_nullable
as NetworkStatus?,
  ));
}

/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get database {
    if (_self.database == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.database!, (value) {
    return _then(_self.copyWith(database: value));
  });
}/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get redis {
    if (_self.redis == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.redis!, (value) {
    return _then(_self.copyWith(redis: value));
  });
}/// Create a copy of NetworkResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkStatusCopyWith<$Res>? get rabbitmq {
    if (_self.rabbitmq == null) {
    return null;
  }

  return $NetworkStatusCopyWith<$Res>(_self.rabbitmq!, (value) {
    return _then(_self.copyWith(rabbitmq: value));
  });
}
}

// dart format on
