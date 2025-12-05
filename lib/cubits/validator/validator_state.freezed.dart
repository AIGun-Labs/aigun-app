// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ValidatorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidatorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ValidatorState()';
}


}

/// @nodoc
class $ValidatorStateCopyWith<$Res>  {
$ValidatorStateCopyWith(ValidatorState _, $Res Function(ValidatorState) __);
}


/// Adds pattern-matching-related methods to [ValidatorState].
extension ValidatorStatePatterns on ValidatorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Valid value)?  valid,TResult Function( _Invalid value)?  invalid,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Valid() when valid != null:
return valid(_that);case _Invalid() when invalid != null:
return invalid(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Valid value)  valid,required TResult Function( _Invalid value)  invalid,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Valid():
return valid(_that);case _Invalid():
return invalid(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Valid value)?  valid,TResult? Function( _Invalid value)?  invalid,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Valid() when valid != null:
return valid(_that);case _Invalid() when invalid != null:
return invalid(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  valid,TResult Function()?  invalid,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Valid() when valid != null:
return valid();case _Invalid() when invalid != null:
return invalid();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  valid,required TResult Function()  invalid,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Valid():
return valid();case _Invalid():
return invalid();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  valid,TResult? Function()?  invalid,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Valid() when valid != null:
return valid();case _Invalid() when invalid != null:
return invalid();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ValidatorState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ValidatorState.initial()';
}


}




/// @nodoc


class _Valid implements ValidatorState {
  const _Valid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Valid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ValidatorState.valid()';
}


}




/// @nodoc


class _Invalid implements ValidatorState {
  const _Invalid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invalid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ValidatorState.invalid()';
}


}




// dart format on
