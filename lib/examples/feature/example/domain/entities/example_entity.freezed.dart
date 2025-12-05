// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExampleEntity {

 String get id; String get name; String get description;
/// Create a copy of ExampleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleEntityCopyWith<ExampleEntity> get copyWith => _$ExampleEntityCopyWithImpl<ExampleEntity>(this as ExampleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description);

@override
String toString() {
  return 'ExampleEntity(id: $id, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $ExampleEntityCopyWith<$Res>  {
  factory $ExampleEntityCopyWith(ExampleEntity value, $Res Function(ExampleEntity) _then) = _$ExampleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description
});




}
/// @nodoc
class _$ExampleEntityCopyWithImpl<$Res>
    implements $ExampleEntityCopyWith<$Res> {
  _$ExampleEntityCopyWithImpl(this._self, this._then);

  final ExampleEntity _self;
  final $Res Function(ExampleEntity) _then;

/// Create a copy of ExampleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleEntity].
extension ExampleEntityPatterns on ExampleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExampleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExampleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExampleEntity value)  $default,){
final _that = this;
switch (_that) {
case _ExampleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExampleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ExampleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExampleEntity() when $default != null:
return $default(_that.id,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description)  $default,) {final _that = this;
switch (_that) {
case _ExampleEntity():
return $default(_that.id,_that.name,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ExampleEntity() when $default != null:
return $default(_that.id,_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ExampleEntity extends ExampleEntity {
  const _ExampleEntity({required this.id, required this.name, required this.description}): super._();
  

@override final  String id;
@override final  String name;
@override final  String description;

/// Create a copy of ExampleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleEntityCopyWith<_ExampleEntity> get copyWith => __$ExampleEntityCopyWithImpl<_ExampleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description);

@override
String toString() {
  return 'ExampleEntity(id: $id, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ExampleEntityCopyWith<$Res> implements $ExampleEntityCopyWith<$Res> {
  factory _$ExampleEntityCopyWith(_ExampleEntity value, $Res Function(_ExampleEntity) _then) = __$ExampleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description
});




}
/// @nodoc
class __$ExampleEntityCopyWithImpl<$Res>
    implements _$ExampleEntityCopyWith<$Res> {
  __$ExampleEntityCopyWithImpl(this._self, this._then);

  final _ExampleEntity _self;
  final $Res Function(_ExampleEntity) _then;

/// Create a copy of ExampleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,}) {
  return _then(_ExampleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
