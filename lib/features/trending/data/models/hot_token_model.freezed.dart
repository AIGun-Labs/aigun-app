// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hot_token_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HotTokenModel {

 String get name; String get symbol; String get logoURL; String get marketCap; String get decimals; String get price; String get chainIndex; String get contractAddress; String get chainId; String get chainName; String get chainLogoURL; String get network; String get slug;
/// Create a copy of HotTokenModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HotTokenModelCopyWith<HotTokenModel> get copyWith => _$HotTokenModelCopyWithImpl<HotTokenModel>(this as HotTokenModel, _$identity);

  /// Serializes this HotTokenModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HotTokenModel&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.logoURL, logoURL) || other.logoURL == logoURL)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.price, price) || other.price == price)&&(identical(other.chainIndex, chainIndex) || other.chainIndex == chainIndex)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainLogoURL, chainLogoURL) || other.chainLogoURL == chainLogoURL)&&(identical(other.network, network) || other.network == network)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,symbol,logoURL,marketCap,decimals,price,chainIndex,contractAddress,chainId,chainName,chainLogoURL,network,slug);

@override
String toString() {
  return 'HotTokenModel(name: $name, symbol: $symbol, logoURL: $logoURL, marketCap: $marketCap, decimals: $decimals, price: $price, chainIndex: $chainIndex, contractAddress: $contractAddress, chainId: $chainId, chainName: $chainName, chainLogoURL: $chainLogoURL, network: $network, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $HotTokenModelCopyWith<$Res>  {
  factory $HotTokenModelCopyWith(HotTokenModel value, $Res Function(HotTokenModel) _then) = _$HotTokenModelCopyWithImpl;
@useResult
$Res call({
 String name, String symbol, String logoURL, String marketCap, String decimals, String price, String chainIndex, String contractAddress, String chainId, String chainName, String chainLogoURL, String network, String slug
});




}
/// @nodoc
class _$HotTokenModelCopyWithImpl<$Res>
    implements $HotTokenModelCopyWith<$Res> {
  _$HotTokenModelCopyWithImpl(this._self, this._then);

  final HotTokenModel _self;
  final $Res Function(HotTokenModel) _then;

/// Create a copy of HotTokenModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? symbol = null,Object? logoURL = null,Object? marketCap = null,Object? decimals = null,Object? price = null,Object? chainIndex = null,Object? contractAddress = null,Object? chainId = null,Object? chainName = null,Object? chainLogoURL = null,Object? network = null,Object? slug = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,logoURL: null == logoURL ? _self.logoURL : logoURL // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,chainIndex: null == chainIndex ? _self.chainIndex : chainIndex // ignore: cast_nullable_to_non_nullable
as String,contractAddress: null == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainLogoURL: null == chainLogoURL ? _self.chainLogoURL : chainLogoURL // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HotTokenModel].
extension HotTokenModelPatterns on HotTokenModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HotTokenModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HotTokenModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HotTokenModel value)  $default,){
final _that = this;
switch (_that) {
case _HotTokenModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HotTokenModel value)?  $default,){
final _that = this;
switch (_that) {
case _HotTokenModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String symbol,  String logoURL,  String marketCap,  String decimals,  String price,  String chainIndex,  String contractAddress,  String chainId,  String chainName,  String chainLogoURL,  String network,  String slug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HotTokenModel() when $default != null:
return $default(_that.name,_that.symbol,_that.logoURL,_that.marketCap,_that.decimals,_that.price,_that.chainIndex,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogoURL,_that.network,_that.slug);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String symbol,  String logoURL,  String marketCap,  String decimals,  String price,  String chainIndex,  String contractAddress,  String chainId,  String chainName,  String chainLogoURL,  String network,  String slug)  $default,) {final _that = this;
switch (_that) {
case _HotTokenModel():
return $default(_that.name,_that.symbol,_that.logoURL,_that.marketCap,_that.decimals,_that.price,_that.chainIndex,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogoURL,_that.network,_that.slug);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String symbol,  String logoURL,  String marketCap,  String decimals,  String price,  String chainIndex,  String contractAddress,  String chainId,  String chainName,  String chainLogoURL,  String network,  String slug)?  $default,) {final _that = this;
switch (_that) {
case _HotTokenModel() when $default != null:
return $default(_that.name,_that.symbol,_that.logoURL,_that.marketCap,_that.decimals,_that.price,_that.chainIndex,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogoURL,_that.network,_that.slug);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(checked: true)
class _HotTokenModel implements HotTokenModel {
  const _HotTokenModel({this.name = '', this.symbol = '', this.logoURL = '', this.marketCap = '', this.decimals = '', this.price = '', this.chainIndex = '', this.contractAddress = '', this.chainId = '', this.chainName = '', this.chainLogoURL = '', this.network = '', this.slug = ''});
  factory _HotTokenModel.fromJson(Map<String, dynamic> json) => _$HotTokenModelFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String symbol;
@override@JsonKey() final  String logoURL;
@override@JsonKey() final  String marketCap;
@override@JsonKey() final  String decimals;
@override@JsonKey() final  String price;
@override@JsonKey() final  String chainIndex;
@override@JsonKey() final  String contractAddress;
@override@JsonKey() final  String chainId;
@override@JsonKey() final  String chainName;
@override@JsonKey() final  String chainLogoURL;
@override@JsonKey() final  String network;
@override@JsonKey() final  String slug;

/// Create a copy of HotTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HotTokenModelCopyWith<_HotTokenModel> get copyWith => __$HotTokenModelCopyWithImpl<_HotTokenModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HotTokenModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HotTokenModel&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.logoURL, logoURL) || other.logoURL == logoURL)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.price, price) || other.price == price)&&(identical(other.chainIndex, chainIndex) || other.chainIndex == chainIndex)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainLogoURL, chainLogoURL) || other.chainLogoURL == chainLogoURL)&&(identical(other.network, network) || other.network == network)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,symbol,logoURL,marketCap,decimals,price,chainIndex,contractAddress,chainId,chainName,chainLogoURL,network,slug);

@override
String toString() {
  return 'HotTokenModel(name: $name, symbol: $symbol, logoURL: $logoURL, marketCap: $marketCap, decimals: $decimals, price: $price, chainIndex: $chainIndex, contractAddress: $contractAddress, chainId: $chainId, chainName: $chainName, chainLogoURL: $chainLogoURL, network: $network, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$HotTokenModelCopyWith<$Res> implements $HotTokenModelCopyWith<$Res> {
  factory _$HotTokenModelCopyWith(_HotTokenModel value, $Res Function(_HotTokenModel) _then) = __$HotTokenModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String symbol, String logoURL, String marketCap, String decimals, String price, String chainIndex, String contractAddress, String chainId, String chainName, String chainLogoURL, String network, String slug
});




}
/// @nodoc
class __$HotTokenModelCopyWithImpl<$Res>
    implements _$HotTokenModelCopyWith<$Res> {
  __$HotTokenModelCopyWithImpl(this._self, this._then);

  final _HotTokenModel _self;
  final $Res Function(_HotTokenModel) _then;

/// Create a copy of HotTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? symbol = null,Object? logoURL = null,Object? marketCap = null,Object? decimals = null,Object? price = null,Object? chainIndex = null,Object? contractAddress = null,Object? chainId = null,Object? chainName = null,Object? chainLogoURL = null,Object? network = null,Object? slug = null,}) {
  return _then(_HotTokenModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,logoURL: null == logoURL ? _self.logoURL : logoURL // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,chainIndex: null == chainIndex ? _self.chainIndex : chainIndex // ignore: cast_nullable_to_non_nullable
as String,contractAddress: null == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainLogoURL: null == chainLogoURL ? _self.chainLogoURL : chainLogoURL // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HotTokensModel {

 List<HotTokenModel> get tokens;
/// Create a copy of HotTokensModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HotTokensModelCopyWith<HotTokensModel> get copyWith => _$HotTokensModelCopyWithImpl<HotTokensModel>(this as HotTokensModel, _$identity);

  /// Serializes this HotTokensModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HotTokensModel&&const DeepCollectionEquality().equals(other.tokens, tokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tokens));

@override
String toString() {
  return 'HotTokensModel(tokens: $tokens)';
}


}

/// @nodoc
abstract mixin class $HotTokensModelCopyWith<$Res>  {
  factory $HotTokensModelCopyWith(HotTokensModel value, $Res Function(HotTokensModel) _then) = _$HotTokensModelCopyWithImpl;
@useResult
$Res call({
 List<HotTokenModel> tokens
});




}
/// @nodoc
class _$HotTokensModelCopyWithImpl<$Res>
    implements $HotTokensModelCopyWith<$Res> {
  _$HotTokensModelCopyWithImpl(this._self, this._then);

  final HotTokensModel _self;
  final $Res Function(HotTokensModel) _then;

/// Create a copy of HotTokensModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokens = null,}) {
  return _then(_self.copyWith(
tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<HotTokenModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HotTokensModel].
extension HotTokensModelPatterns on HotTokensModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HotTokensModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HotTokensModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HotTokensModel value)  $default,){
final _that = this;
switch (_that) {
case _HotTokensModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HotTokensModel value)?  $default,){
final _that = this;
switch (_that) {
case _HotTokensModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HotTokenModel> tokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HotTokensModel() when $default != null:
return $default(_that.tokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HotTokenModel> tokens)  $default,) {final _that = this;
switch (_that) {
case _HotTokensModel():
return $default(_that.tokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HotTokenModel> tokens)?  $default,) {final _that = this;
switch (_that) {
case _HotTokensModel() when $default != null:
return $default(_that.tokens);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(checked: true)
class _HotTokensModel implements HotTokensModel {
  const _HotTokensModel({final  List<HotTokenModel> tokens = const []}): _tokens = tokens;
  factory _HotTokensModel.fromJson(Map<String, dynamic> json) => _$HotTokensModelFromJson(json);

 final  List<HotTokenModel> _tokens;
@override@JsonKey() List<HotTokenModel> get tokens {
  if (_tokens is EqualUnmodifiableListView) return _tokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tokens);
}


/// Create a copy of HotTokensModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HotTokensModelCopyWith<_HotTokensModel> get copyWith => __$HotTokensModelCopyWithImpl<_HotTokensModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HotTokensModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HotTokensModel&&const DeepCollectionEquality().equals(other._tokens, _tokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tokens));

@override
String toString() {
  return 'HotTokensModel(tokens: $tokens)';
}


}

/// @nodoc
abstract mixin class _$HotTokensModelCopyWith<$Res> implements $HotTokensModelCopyWith<$Res> {
  factory _$HotTokensModelCopyWith(_HotTokensModel value, $Res Function(_HotTokensModel) _then) = __$HotTokensModelCopyWithImpl;
@override @useResult
$Res call({
 List<HotTokenModel> tokens
});




}
/// @nodoc
class __$HotTokensModelCopyWithImpl<$Res>
    implements _$HotTokensModelCopyWith<$Res> {
  __$HotTokensModelCopyWithImpl(this._self, this._then);

  final _HotTokensModel _self;
  final $Res Function(_HotTokensModel) _then;

/// Create a copy of HotTokensModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokens = null,}) {
  return _then(_HotTokensModel(
tokens: null == tokens ? _self._tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<HotTokenModel>,
  ));
}


}

// dart format on
