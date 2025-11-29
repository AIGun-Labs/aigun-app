// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'networks_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworksModel {

 Map<String, String> get networks;
/// Create a copy of NetworksModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworksModelCopyWith<NetworksModel> get copyWith => _$NetworksModelCopyWithImpl<NetworksModel>(this as NetworksModel, _$identity);

  /// Serializes this NetworksModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworksModel&&const DeepCollectionEquality().equals(other.networks, networks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(networks));

@override
String toString() {
  return 'NetworksModel(networks: $networks)';
}


}

/// @nodoc
abstract mixin class $NetworksModelCopyWith<$Res>  {
  factory $NetworksModelCopyWith(NetworksModel value, $Res Function(NetworksModel) _then) = _$NetworksModelCopyWithImpl;
@useResult
$Res call({
 Map<String, String> networks
});




}
/// @nodoc
class _$NetworksModelCopyWithImpl<$Res>
    implements $NetworksModelCopyWith<$Res> {
  _$NetworksModelCopyWithImpl(this._self, this._then);

  final NetworksModel _self;
  final $Res Function(NetworksModel) _then;

/// Create a copy of NetworksModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? networks = null,}) {
  return _then(_self.copyWith(
networks: null == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworksModel].
extension NetworksModelPatterns on NetworksModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworksModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworksModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworksModel value)  $default,){
final _that = this;
switch (_that) {
case _NetworksModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworksModel value)?  $default,){
final _that = this;
switch (_that) {
case _NetworksModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> networks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworksModel() when $default != null:
return $default(_that.networks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> networks)  $default,) {final _that = this;
switch (_that) {
case _NetworksModel():
return $default(_that.networks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> networks)?  $default,) {final _that = this;
switch (_that) {
case _NetworksModel() when $default != null:
return $default(_that.networks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworksModel extends NetworksModel {
  const _NetworksModel({final  Map<String, String> networks = const {}}): _networks = networks,super._();
  factory _NetworksModel.fromJson(Map<String, dynamic> json) => _$NetworksModelFromJson(json);

 final  Map<String, String> _networks;
@override@JsonKey() Map<String, String> get networks {
  if (_networks is EqualUnmodifiableMapView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_networks);
}


/// Create a copy of NetworksModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworksModelCopyWith<_NetworksModel> get copyWith => __$NetworksModelCopyWithImpl<_NetworksModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworksModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworksModel&&const DeepCollectionEquality().equals(other._networks, _networks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_networks));

@override
String toString() {
  return 'NetworksModel(networks: $networks)';
}


}

/// @nodoc
abstract mixin class _$NetworksModelCopyWith<$Res> implements $NetworksModelCopyWith<$Res> {
  factory _$NetworksModelCopyWith(_NetworksModel value, $Res Function(_NetworksModel) _then) = __$NetworksModelCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> networks
});




}
/// @nodoc
class __$NetworksModelCopyWithImpl<$Res>
    implements _$NetworksModelCopyWith<$Res> {
  __$NetworksModelCopyWithImpl(this._self, this._then);

  final _NetworksModel _self;
  final $Res Function(_NetworksModel) _then;

/// Create a copy of NetworksModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? networks = null,}) {
  return _then(_NetworksModel(
networks: null == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
