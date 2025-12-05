// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'urls.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenDetailUrls {

@JsonKey(name: 'discord') String? get discord;@JsonKey(name: 'website') String? get website;@JsonKey(name: 'github') String? get github;@JsonKey(name: 'x') String? get x;@JsonKey(name: 'whitepaper') String? get whitepaper;@JsonKey(name: 'reddit') String? get reddit;@JsonKey(name: 'telegram') String? get telegram;
/// Create a copy of TokenDetailUrls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenDetailUrlsCopyWith<TokenDetailUrls> get copyWith => _$TokenDetailUrlsCopyWithImpl<TokenDetailUrls>(this as TokenDetailUrls, _$identity);

  /// Serializes this TokenDetailUrls to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenDetailUrls&&(identical(other.discord, discord) || other.discord == discord)&&(identical(other.website, website) || other.website == website)&&(identical(other.github, github) || other.github == github)&&(identical(other.x, x) || other.x == x)&&(identical(other.whitepaper, whitepaper) || other.whitepaper == whitepaper)&&(identical(other.reddit, reddit) || other.reddit == reddit)&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discord,website,github,x,whitepaper,reddit,telegram);

@override
String toString() {
  return 'TokenDetailUrls(discord: $discord, website: $website, github: $github, x: $x, whitepaper: $whitepaper, reddit: $reddit, telegram: $telegram)';
}


}

/// @nodoc
abstract mixin class $TokenDetailUrlsCopyWith<$Res>  {
  factory $TokenDetailUrlsCopyWith(TokenDetailUrls value, $Res Function(TokenDetailUrls) _then) = _$TokenDetailUrlsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'discord') String? discord,@JsonKey(name: 'website') String? website,@JsonKey(name: 'github') String? github,@JsonKey(name: 'x') String? x,@JsonKey(name: 'whitepaper') String? whitepaper,@JsonKey(name: 'reddit') String? reddit,@JsonKey(name: 'telegram') String? telegram
});




}
/// @nodoc
class _$TokenDetailUrlsCopyWithImpl<$Res>
    implements $TokenDetailUrlsCopyWith<$Res> {
  _$TokenDetailUrlsCopyWithImpl(this._self, this._then);

  final TokenDetailUrls _self;
  final $Res Function(TokenDetailUrls) _then;

/// Create a copy of TokenDetailUrls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? discord = freezed,Object? website = freezed,Object? github = freezed,Object? x = freezed,Object? whitepaper = freezed,Object? reddit = freezed,Object? telegram = freezed,}) {
  return _then(_self.copyWith(
discord: freezed == discord ? _self.discord : discord // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,x: freezed == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String?,whitepaper: freezed == whitepaper ? _self.whitepaper : whitepaper // ignore: cast_nullable_to_non_nullable
as String?,reddit: freezed == reddit ? _self.reddit : reddit // ignore: cast_nullable_to_non_nullable
as String?,telegram: freezed == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenDetailUrls].
extension TokenDetailUrlsPatterns on TokenDetailUrls {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenDetailUrls value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenDetailUrls() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenDetailUrls value)  $default,){
final _that = this;
switch (_that) {
case _TokenDetailUrls():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenDetailUrls value)?  $default,){
final _that = this;
switch (_that) {
case _TokenDetailUrls() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'discord')  String? discord, @JsonKey(name: 'website')  String? website, @JsonKey(name: 'github')  String? github, @JsonKey(name: 'x')  String? x, @JsonKey(name: 'whitepaper')  String? whitepaper, @JsonKey(name: 'reddit')  String? reddit, @JsonKey(name: 'telegram')  String? telegram)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenDetailUrls() when $default != null:
return $default(_that.discord,_that.website,_that.github,_that.x,_that.whitepaper,_that.reddit,_that.telegram);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'discord')  String? discord, @JsonKey(name: 'website')  String? website, @JsonKey(name: 'github')  String? github, @JsonKey(name: 'x')  String? x, @JsonKey(name: 'whitepaper')  String? whitepaper, @JsonKey(name: 'reddit')  String? reddit, @JsonKey(name: 'telegram')  String? telegram)  $default,) {final _that = this;
switch (_that) {
case _TokenDetailUrls():
return $default(_that.discord,_that.website,_that.github,_that.x,_that.whitepaper,_that.reddit,_that.telegram);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'discord')  String? discord, @JsonKey(name: 'website')  String? website, @JsonKey(name: 'github')  String? github, @JsonKey(name: 'x')  String? x, @JsonKey(name: 'whitepaper')  String? whitepaper, @JsonKey(name: 'reddit')  String? reddit, @JsonKey(name: 'telegram')  String? telegram)?  $default,) {final _that = this;
switch (_that) {
case _TokenDetailUrls() when $default != null:
return $default(_that.discord,_that.website,_that.github,_that.x,_that.whitepaper,_that.reddit,_that.telegram);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenDetailUrls implements TokenDetailUrls {
  const _TokenDetailUrls({@JsonKey(name: 'discord') this.discord, @JsonKey(name: 'website') this.website, @JsonKey(name: 'github') this.github, @JsonKey(name: 'x') this.x, @JsonKey(name: 'whitepaper') this.whitepaper, @JsonKey(name: 'reddit') this.reddit, @JsonKey(name: 'telegram') this.telegram});
  factory _TokenDetailUrls.fromJson(Map<String, dynamic> json) => _$TokenDetailUrlsFromJson(json);

@override@JsonKey(name: 'discord') final  String? discord;
@override@JsonKey(name: 'website') final  String? website;
@override@JsonKey(name: 'github') final  String? github;
@override@JsonKey(name: 'x') final  String? x;
@override@JsonKey(name: 'whitepaper') final  String? whitepaper;
@override@JsonKey(name: 'reddit') final  String? reddit;
@override@JsonKey(name: 'telegram') final  String? telegram;

/// Create a copy of TokenDetailUrls
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenDetailUrlsCopyWith<_TokenDetailUrls> get copyWith => __$TokenDetailUrlsCopyWithImpl<_TokenDetailUrls>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenDetailUrlsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenDetailUrls&&(identical(other.discord, discord) || other.discord == discord)&&(identical(other.website, website) || other.website == website)&&(identical(other.github, github) || other.github == github)&&(identical(other.x, x) || other.x == x)&&(identical(other.whitepaper, whitepaper) || other.whitepaper == whitepaper)&&(identical(other.reddit, reddit) || other.reddit == reddit)&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discord,website,github,x,whitepaper,reddit,telegram);

@override
String toString() {
  return 'TokenDetailUrls(discord: $discord, website: $website, github: $github, x: $x, whitepaper: $whitepaper, reddit: $reddit, telegram: $telegram)';
}


}

/// @nodoc
abstract mixin class _$TokenDetailUrlsCopyWith<$Res> implements $TokenDetailUrlsCopyWith<$Res> {
  factory _$TokenDetailUrlsCopyWith(_TokenDetailUrls value, $Res Function(_TokenDetailUrls) _then) = __$TokenDetailUrlsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'discord') String? discord,@JsonKey(name: 'website') String? website,@JsonKey(name: 'github') String? github,@JsonKey(name: 'x') String? x,@JsonKey(name: 'whitepaper') String? whitepaper,@JsonKey(name: 'reddit') String? reddit,@JsonKey(name: 'telegram') String? telegram
});




}
/// @nodoc
class __$TokenDetailUrlsCopyWithImpl<$Res>
    implements _$TokenDetailUrlsCopyWith<$Res> {
  __$TokenDetailUrlsCopyWithImpl(this._self, this._then);

  final _TokenDetailUrls _self;
  final $Res Function(_TokenDetailUrls) _then;

/// Create a copy of TokenDetailUrls
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? discord = freezed,Object? website = freezed,Object? github = freezed,Object? x = freezed,Object? whitepaper = freezed,Object? reddit = freezed,Object? telegram = freezed,}) {
  return _then(_TokenDetailUrls(
discord: freezed == discord ? _self.discord : discord // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,x: freezed == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String?,whitepaper: freezed == whitepaper ? _self.whitepaper : whitepaper // ignore: cast_nullable_to_non_nullable
as String?,reddit: freezed == reddit ? _self.reddit : reddit // ignore: cast_nullable_to_non_nullable
as String?,telegram: freezed == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
