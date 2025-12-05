// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'options_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OptionsState {

 List<SingleTypeOptions>? get singleTypeOptions;
/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OptionsStateCopyWith<OptionsState> get copyWith => _$OptionsStateCopyWithImpl<OptionsState>(this as OptionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptionsState&&const DeepCollectionEquality().equals(other.singleTypeOptions, singleTypeOptions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(singleTypeOptions));

@override
String toString() {
  return 'OptionsState(singleTypeOptions: $singleTypeOptions)';
}


}

/// @nodoc
abstract mixin class $OptionsStateCopyWith<$Res>  {
  factory $OptionsStateCopyWith(OptionsState value, $Res Function(OptionsState) _then) = _$OptionsStateCopyWithImpl;
@useResult
$Res call({
 List<SingleTypeOptions>? singleTypeOptions
});




}
/// @nodoc
class _$OptionsStateCopyWithImpl<$Res>
    implements $OptionsStateCopyWith<$Res> {
  _$OptionsStateCopyWithImpl(this._self, this._then);

  final OptionsState _self;
  final $Res Function(OptionsState) _then;

/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? singleTypeOptions = freezed,}) {
  return _then(_self.copyWith(
singleTypeOptions: freezed == singleTypeOptions ? _self.singleTypeOptions : singleTypeOptions // ignore: cast_nullable_to_non_nullable
as List<SingleTypeOptions>?,
  ));
}

}


/// Adds pattern-matching-related methods to [OptionsState].
extension OptionsStatePatterns on OptionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OptionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OptionsState value)  $default,){
final _that = this;
switch (_that) {
case _OptionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OptionsState value)?  $default,){
final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SingleTypeOptions>? singleTypeOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
return $default(_that.singleTypeOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SingleTypeOptions>? singleTypeOptions)  $default,) {final _that = this;
switch (_that) {
case _OptionsState():
return $default(_that.singleTypeOptions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SingleTypeOptions>? singleTypeOptions)?  $default,) {final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
return $default(_that.singleTypeOptions);case _:
  return null;

}
}

}

/// @nodoc


class _OptionsState extends OptionsState {
  const _OptionsState({final  List<SingleTypeOptions>? singleTypeOptions}): _singleTypeOptions = singleTypeOptions,super._();
  

 final  List<SingleTypeOptions>? _singleTypeOptions;
@override List<SingleTypeOptions>? get singleTypeOptions {
  final value = _singleTypeOptions;
  if (value == null) return null;
  if (_singleTypeOptions is EqualUnmodifiableListView) return _singleTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OptionsStateCopyWith<_OptionsState> get copyWith => __$OptionsStateCopyWithImpl<_OptionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OptionsState&&const DeepCollectionEquality().equals(other._singleTypeOptions, _singleTypeOptions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_singleTypeOptions));

@override
String toString() {
  return 'OptionsState(singleTypeOptions: $singleTypeOptions)';
}


}

/// @nodoc
abstract mixin class _$OptionsStateCopyWith<$Res> implements $OptionsStateCopyWith<$Res> {
  factory _$OptionsStateCopyWith(_OptionsState value, $Res Function(_OptionsState) _then) = __$OptionsStateCopyWithImpl;
@override @useResult
$Res call({
 List<SingleTypeOptions>? singleTypeOptions
});




}
/// @nodoc
class __$OptionsStateCopyWithImpl<$Res>
    implements _$OptionsStateCopyWith<$Res> {
  __$OptionsStateCopyWithImpl(this._self, this._then);

  final _OptionsState _self;
  final $Res Function(_OptionsState) _then;

/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? singleTypeOptions = freezed,}) {
  return _then(_OptionsState(
singleTypeOptions: freezed == singleTypeOptions ? _self._singleTypeOptions : singleTypeOptions // ignore: cast_nullable_to_non_nullable
as List<SingleTypeOptions>?,
  ));
}


}

// dart format on
