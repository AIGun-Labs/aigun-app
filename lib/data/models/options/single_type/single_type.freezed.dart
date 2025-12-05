// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SingleTypeOptions {

@JsonKey(name: 'name') String? get name;@JsonKey(name: 'slug') String? get slug;@JsonKey(name: 'push_filter') String? get pushFilter;
/// Create a copy of SingleTypeOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleTypeOptionsCopyWith<SingleTypeOptions> get copyWith => _$SingleTypeOptionsCopyWithImpl<SingleTypeOptions>(this as SingleTypeOptions, _$identity);

  /// Serializes this SingleTypeOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleTypeOptions&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pushFilter, pushFilter) || other.pushFilter == pushFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,pushFilter);

@override
String toString() {
  return 'SingleTypeOptions(name: $name, slug: $slug, pushFilter: $pushFilter)';
}


}

/// @nodoc
abstract mixin class $SingleTypeOptionsCopyWith<$Res>  {
  factory $SingleTypeOptionsCopyWith(SingleTypeOptions value, $Res Function(SingleTypeOptions) _then) = _$SingleTypeOptionsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String? name,@JsonKey(name: 'slug') String? slug,@JsonKey(name: 'push_filter') String? pushFilter
});




}
/// @nodoc
class _$SingleTypeOptionsCopyWithImpl<$Res>
    implements $SingleTypeOptionsCopyWith<$Res> {
  _$SingleTypeOptionsCopyWithImpl(this._self, this._then);

  final SingleTypeOptions _self;
  final $Res Function(SingleTypeOptions) _then;

/// Create a copy of SingleTypeOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? slug = freezed,Object? pushFilter = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,pushFilter: freezed == pushFilter ? _self.pushFilter : pushFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SingleTypeOptions].
extension SingleTypeOptionsPatterns on SingleTypeOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SingleTypeOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SingleTypeOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SingleTypeOptions value)  $default,){
final _that = this;
switch (_that) {
case _SingleTypeOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SingleTypeOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SingleTypeOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? name, @JsonKey(name: 'slug')  String? slug, @JsonKey(name: 'push_filter')  String? pushFilter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SingleTypeOptions() when $default != null:
return $default(_that.name,_that.slug,_that.pushFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? name, @JsonKey(name: 'slug')  String? slug, @JsonKey(name: 'push_filter')  String? pushFilter)  $default,) {final _that = this;
switch (_that) {
case _SingleTypeOptions():
return $default(_that.name,_that.slug,_that.pushFilter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name')  String? name, @JsonKey(name: 'slug')  String? slug, @JsonKey(name: 'push_filter')  String? pushFilter)?  $default,) {final _that = this;
switch (_that) {
case _SingleTypeOptions() when $default != null:
return $default(_that.name,_that.slug,_that.pushFilter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SingleTypeOptions implements SingleTypeOptions {
  const _SingleTypeOptions({@JsonKey(name: 'name') this.name, @JsonKey(name: 'slug') this.slug, @JsonKey(name: 'push_filter') this.pushFilter});
  factory _SingleTypeOptions.fromJson(Map<String, dynamic> json) => _$SingleTypeOptionsFromJson(json);

@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'slug') final  String? slug;
@override@JsonKey(name: 'push_filter') final  String? pushFilter;

/// Create a copy of SingleTypeOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleTypeOptionsCopyWith<_SingleTypeOptions> get copyWith => __$SingleTypeOptionsCopyWithImpl<_SingleTypeOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SingleTypeOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleTypeOptions&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pushFilter, pushFilter) || other.pushFilter == pushFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,pushFilter);

@override
String toString() {
  return 'SingleTypeOptions(name: $name, slug: $slug, pushFilter: $pushFilter)';
}


}

/// @nodoc
abstract mixin class _$SingleTypeOptionsCopyWith<$Res> implements $SingleTypeOptionsCopyWith<$Res> {
  factory _$SingleTypeOptionsCopyWith(_SingleTypeOptions value, $Res Function(_SingleTypeOptions) _then) = __$SingleTypeOptionsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String? name,@JsonKey(name: 'slug') String? slug,@JsonKey(name: 'push_filter') String? pushFilter
});




}
/// @nodoc
class __$SingleTypeOptionsCopyWithImpl<$Res>
    implements _$SingleTypeOptionsCopyWith<$Res> {
  __$SingleTypeOptionsCopyWithImpl(this._self, this._then);

  final _SingleTypeOptions _self;
  final $Res Function(_SingleTypeOptions) _then;

/// Create a copy of SingleTypeOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? slug = freezed,Object? pushFilter = freezed,}) {
  return _then(_SingleTypeOptions(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,pushFilter: freezed == pushFilter ? _self.pushFilter : pushFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
