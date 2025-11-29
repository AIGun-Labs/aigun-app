// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueryTokenState {

 QueryTokenStatus get status; List<QueryToken> get tokens; String? get keyword; QueryToken? get queryToken; bool get isLoading; bool get noData;
/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryTokenStateCopyWith<QueryTokenState> get copyWith => _$QueryTokenStateCopyWithImpl<QueryTokenState>(this as QueryTokenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryTokenState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tokens, tokens)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.queryToken, queryToken) || other.queryToken == queryToken)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.noData, noData) || other.noData == noData));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(tokens),keyword,queryToken,isLoading,noData);

@override
String toString() {
  return 'QueryTokenState(status: $status, tokens: $tokens, keyword: $keyword, queryToken: $queryToken, isLoading: $isLoading, noData: $noData)';
}


}

/// @nodoc
abstract mixin class $QueryTokenStateCopyWith<$Res>  {
  factory $QueryTokenStateCopyWith(QueryTokenState value, $Res Function(QueryTokenState) _then) = _$QueryTokenStateCopyWithImpl;
@useResult
$Res call({
 QueryTokenStatus status, List<QueryToken> tokens, String? keyword, QueryToken? queryToken, bool isLoading, bool noData
});


$QueryTokenCopyWith<$Res>? get queryToken;

}
/// @nodoc
class _$QueryTokenStateCopyWithImpl<$Res>
    implements $QueryTokenStateCopyWith<$Res> {
  _$QueryTokenStateCopyWithImpl(this._self, this._then);

  final QueryTokenState _self;
  final $Res Function(QueryTokenState) _then;

/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tokens = null,Object? keyword = freezed,Object? queryToken = freezed,Object? isLoading = null,Object? noData = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueryTokenStatus,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<QueryToken>,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,queryToken: freezed == queryToken ? _self.queryToken : queryToken // ignore: cast_nullable_to_non_nullable
as QueryToken?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,noData: null == noData ? _self.noData : noData // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueryTokenCopyWith<$Res>? get queryToken {
    if (_self.queryToken == null) {
    return null;
  }

  return $QueryTokenCopyWith<$Res>(_self.queryToken!, (value) {
    return _then(_self.copyWith(queryToken: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueryTokenState].
extension QueryTokenStatePatterns on QueryTokenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryTokenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryTokenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryTokenState value)  $default,){
final _that = this;
switch (_that) {
case _QueryTokenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryTokenState value)?  $default,){
final _that = this;
switch (_that) {
case _QueryTokenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QueryTokenStatus status,  List<QueryToken> tokens,  String? keyword,  QueryToken? queryToken,  bool isLoading,  bool noData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryTokenState() when $default != null:
return $default(_that.status,_that.tokens,_that.keyword,_that.queryToken,_that.isLoading,_that.noData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QueryTokenStatus status,  List<QueryToken> tokens,  String? keyword,  QueryToken? queryToken,  bool isLoading,  bool noData)  $default,) {final _that = this;
switch (_that) {
case _QueryTokenState():
return $default(_that.status,_that.tokens,_that.keyword,_that.queryToken,_that.isLoading,_that.noData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QueryTokenStatus status,  List<QueryToken> tokens,  String? keyword,  QueryToken? queryToken,  bool isLoading,  bool noData)?  $default,) {final _that = this;
switch (_that) {
case _QueryTokenState() when $default != null:
return $default(_that.status,_that.tokens,_that.keyword,_that.queryToken,_that.isLoading,_that.noData);case _:
  return null;

}
}

}

/// @nodoc


class _QueryTokenState implements QueryTokenState {
  const _QueryTokenState({this.status = QueryTokenStatus.initial, final  List<QueryToken> tokens = const [], this.keyword = null, this.queryToken = null, this.isLoading = false, this.noData = false}): _tokens = tokens;
  

@override@JsonKey() final  QueryTokenStatus status;
 final  List<QueryToken> _tokens;
@override@JsonKey() List<QueryToken> get tokens {
  if (_tokens is EqualUnmodifiableListView) return _tokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tokens);
}

@override@JsonKey() final  String? keyword;
@override@JsonKey() final  QueryToken? queryToken;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool noData;

/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryTokenStateCopyWith<_QueryTokenState> get copyWith => __$QueryTokenStateCopyWithImpl<_QueryTokenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryTokenState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._tokens, _tokens)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.queryToken, queryToken) || other.queryToken == queryToken)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.noData, noData) || other.noData == noData));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_tokens),keyword,queryToken,isLoading,noData);

@override
String toString() {
  return 'QueryTokenState(status: $status, tokens: $tokens, keyword: $keyword, queryToken: $queryToken, isLoading: $isLoading, noData: $noData)';
}


}

/// @nodoc
abstract mixin class _$QueryTokenStateCopyWith<$Res> implements $QueryTokenStateCopyWith<$Res> {
  factory _$QueryTokenStateCopyWith(_QueryTokenState value, $Res Function(_QueryTokenState) _then) = __$QueryTokenStateCopyWithImpl;
@override @useResult
$Res call({
 QueryTokenStatus status, List<QueryToken> tokens, String? keyword, QueryToken? queryToken, bool isLoading, bool noData
});


@override $QueryTokenCopyWith<$Res>? get queryToken;

}
/// @nodoc
class __$QueryTokenStateCopyWithImpl<$Res>
    implements _$QueryTokenStateCopyWith<$Res> {
  __$QueryTokenStateCopyWithImpl(this._self, this._then);

  final _QueryTokenState _self;
  final $Res Function(_QueryTokenState) _then;

/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tokens = null,Object? keyword = freezed,Object? queryToken = freezed,Object? isLoading = null,Object? noData = null,}) {
  return _then(_QueryTokenState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueryTokenStatus,tokens: null == tokens ? _self._tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<QueryToken>,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,queryToken: freezed == queryToken ? _self.queryToken : queryToken // ignore: cast_nullable_to_non_nullable
as QueryToken?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,noData: null == noData ? _self.noData : noData // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QueryTokenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueryTokenCopyWith<$Res>? get queryToken {
    if (_self.queryToken == null) {
    return null;
  }

  return $QueryTokenCopyWith<$Res>(_self.queryToken!, (value) {
    return _then(_self.copyWith(queryToken: value));
  });
}
}

// dart format on
