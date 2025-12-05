// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Multilingual {

@JsonKey(name: 'zh', defaultValue: '') String? get zh;@JsonKey(name: 'en', defaultValue: '') String? get en;@JsonKey(name: 'original', defaultValue: '') String? get original;@JsonKey(name: 'jp', defaultValue: '') String? get jp;@JsonKey(name: 'ko', defaultValue: '') String? get ko;
/// Create a copy of Multilingual
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultilingualCopyWith<Multilingual> get copyWith => _$MultilingualCopyWithImpl<Multilingual>(this as Multilingual, _$identity);

  /// Serializes this Multilingual to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Multilingual&&(identical(other.zh, zh) || other.zh == zh)&&(identical(other.en, en) || other.en == en)&&(identical(other.original, original) || other.original == original)&&(identical(other.jp, jp) || other.jp == jp)&&(identical(other.ko, ko) || other.ko == ko));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,zh,en,original,jp,ko);

@override
String toString() {
  return 'Multilingual(zh: $zh, en: $en, original: $original, jp: $jp, ko: $ko)';
}


}

/// @nodoc
abstract mixin class $MultilingualCopyWith<$Res>  {
  factory $MultilingualCopyWith(Multilingual value, $Res Function(Multilingual) _then) = _$MultilingualCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'zh', defaultValue: '') String? zh,@JsonKey(name: 'en', defaultValue: '') String? en,@JsonKey(name: 'original', defaultValue: '') String? original,@JsonKey(name: 'jp', defaultValue: '') String? jp,@JsonKey(name: 'ko', defaultValue: '') String? ko
});




}
/// @nodoc
class _$MultilingualCopyWithImpl<$Res>
    implements $MultilingualCopyWith<$Res> {
  _$MultilingualCopyWithImpl(this._self, this._then);

  final Multilingual _self;
  final $Res Function(Multilingual) _then;

/// Create a copy of Multilingual
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zh = freezed,Object? en = freezed,Object? original = freezed,Object? jp = freezed,Object? ko = freezed,}) {
  return _then(_self.copyWith(
zh: freezed == zh ? _self.zh : zh // ignore: cast_nullable_to_non_nullable
as String?,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,jp: freezed == jp ? _self.jp : jp // ignore: cast_nullable_to_non_nullable
as String?,ko: freezed == ko ? _self.ko : ko // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Multilingual].
extension MultilingualPatterns on Multilingual {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Multilingual value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Multilingual() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Multilingual value)  $default,){
final _that = this;
switch (_that) {
case _Multilingual():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Multilingual value)?  $default,){
final _that = this;
switch (_that) {
case _Multilingual() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'zh', defaultValue: '')  String? zh, @JsonKey(name: 'en', defaultValue: '')  String? en, @JsonKey(name: 'original', defaultValue: '')  String? original, @JsonKey(name: 'jp', defaultValue: '')  String? jp, @JsonKey(name: 'ko', defaultValue: '')  String? ko)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Multilingual() when $default != null:
return $default(_that.zh,_that.en,_that.original,_that.jp,_that.ko);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'zh', defaultValue: '')  String? zh, @JsonKey(name: 'en', defaultValue: '')  String? en, @JsonKey(name: 'original', defaultValue: '')  String? original, @JsonKey(name: 'jp', defaultValue: '')  String? jp, @JsonKey(name: 'ko', defaultValue: '')  String? ko)  $default,) {final _that = this;
switch (_that) {
case _Multilingual():
return $default(_that.zh,_that.en,_that.original,_that.jp,_that.ko);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'zh', defaultValue: '')  String? zh, @JsonKey(name: 'en', defaultValue: '')  String? en, @JsonKey(name: 'original', defaultValue: '')  String? original, @JsonKey(name: 'jp', defaultValue: '')  String? jp, @JsonKey(name: 'ko', defaultValue: '')  String? ko)?  $default,) {final _that = this;
switch (_that) {
case _Multilingual() when $default != null:
return $default(_that.zh,_that.en,_that.original,_that.jp,_that.ko);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Multilingual extends Multilingual {
  const _Multilingual({@JsonKey(name: 'zh', defaultValue: '') this.zh, @JsonKey(name: 'en', defaultValue: '') this.en, @JsonKey(name: 'original', defaultValue: '') this.original, @JsonKey(name: 'jp', defaultValue: '') this.jp, @JsonKey(name: 'ko', defaultValue: '') this.ko}): super._();
  factory _Multilingual.fromJson(Map<String, dynamic> json) => _$MultilingualFromJson(json);

@override@JsonKey(name: 'zh', defaultValue: '') final  String? zh;
@override@JsonKey(name: 'en', defaultValue: '') final  String? en;
@override@JsonKey(name: 'original', defaultValue: '') final  String? original;
@override@JsonKey(name: 'jp', defaultValue: '') final  String? jp;
@override@JsonKey(name: 'ko', defaultValue: '') final  String? ko;

/// Create a copy of Multilingual
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MultilingualCopyWith<_Multilingual> get copyWith => __$MultilingualCopyWithImpl<_Multilingual>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MultilingualToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Multilingual&&(identical(other.zh, zh) || other.zh == zh)&&(identical(other.en, en) || other.en == en)&&(identical(other.original, original) || other.original == original)&&(identical(other.jp, jp) || other.jp == jp)&&(identical(other.ko, ko) || other.ko == ko));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,zh,en,original,jp,ko);

@override
String toString() {
  return 'Multilingual(zh: $zh, en: $en, original: $original, jp: $jp, ko: $ko)';
}


}

/// @nodoc
abstract mixin class _$MultilingualCopyWith<$Res> implements $MultilingualCopyWith<$Res> {
  factory _$MultilingualCopyWith(_Multilingual value, $Res Function(_Multilingual) _then) = __$MultilingualCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'zh', defaultValue: '') String? zh,@JsonKey(name: 'en', defaultValue: '') String? en,@JsonKey(name: 'original', defaultValue: '') String? original,@JsonKey(name: 'jp', defaultValue: '') String? jp,@JsonKey(name: 'ko', defaultValue: '') String? ko
});




}
/// @nodoc
class __$MultilingualCopyWithImpl<$Res>
    implements _$MultilingualCopyWith<$Res> {
  __$MultilingualCopyWithImpl(this._self, this._then);

  final _Multilingual _self;
  final $Res Function(_Multilingual) _then;

/// Create a copy of Multilingual
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zh = freezed,Object? en = freezed,Object? original = freezed,Object? jp = freezed,Object? ko = freezed,}) {
  return _then(_Multilingual(
zh: freezed == zh ? _self.zh : zh // ignore: cast_nullable_to_non_nullable
as String?,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,jp: freezed == jp ? _self.jp : jp // ignore: cast_nullable_to_non_nullable
as String?,ko: freezed == ko ? _self.ko : ko // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
