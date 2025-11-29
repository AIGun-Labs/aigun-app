// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hot_token_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HotTokenEntity {

 String get name; String get symbol; String get logo; String get marketCap; String get decimals; String get price; String get contractAddress; String get chainId; String get chainName; String get chainLogo; String get network; String get slug; String get chainIndex;
/// Create a copy of HotTokenEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HotTokenEntityCopyWith<HotTokenEntity> get copyWith => _$HotTokenEntityCopyWithImpl<HotTokenEntity>(this as HotTokenEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HotTokenEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.price, price) || other.price == price)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.network, network) || other.network == network)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.chainIndex, chainIndex) || other.chainIndex == chainIndex));
}


@override
int get hashCode => Object.hash(runtimeType,name,symbol,logo,marketCap,decimals,price,contractAddress,chainId,chainName,chainLogo,network,slug,chainIndex);

@override
String toString() {
  return 'HotTokenEntity(name: $name, symbol: $symbol, logo: $logo, marketCap: $marketCap, decimals: $decimals, price: $price, contractAddress: $contractAddress, chainId: $chainId, chainName: $chainName, chainLogo: $chainLogo, network: $network, slug: $slug, chainIndex: $chainIndex)';
}


}

/// @nodoc
abstract mixin class $HotTokenEntityCopyWith<$Res>  {
  factory $HotTokenEntityCopyWith(HotTokenEntity value, $Res Function(HotTokenEntity) _then) = _$HotTokenEntityCopyWithImpl;
@useResult
$Res call({
 String name, String symbol, String logo, String marketCap, String decimals, String price, String contractAddress, String chainId, String chainName, String chainLogo, String network, String slug, String chainIndex
});




}
/// @nodoc
class _$HotTokenEntityCopyWithImpl<$Res>
    implements $HotTokenEntityCopyWith<$Res> {
  _$HotTokenEntityCopyWithImpl(this._self, this._then);

  final HotTokenEntity _self;
  final $Res Function(HotTokenEntity) _then;

/// Create a copy of HotTokenEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? symbol = null,Object? logo = null,Object? marketCap = null,Object? decimals = null,Object? price = null,Object? contractAddress = null,Object? chainId = null,Object? chainName = null,Object? chainLogo = null,Object? network = null,Object? slug = null,Object? chainIndex = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,contractAddress: null == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,chainIndex: null == chainIndex ? _self.chainIndex : chainIndex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HotTokenEntity].
extension HotTokenEntityPatterns on HotTokenEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HotTokenEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HotTokenEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HotTokenEntity value)  $default,){
final _that = this;
switch (_that) {
case _HotTokenEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HotTokenEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HotTokenEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String symbol,  String logo,  String marketCap,  String decimals,  String price,  String contractAddress,  String chainId,  String chainName,  String chainLogo,  String network,  String slug,  String chainIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HotTokenEntity() when $default != null:
return $default(_that.name,_that.symbol,_that.logo,_that.marketCap,_that.decimals,_that.price,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogo,_that.network,_that.slug,_that.chainIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String symbol,  String logo,  String marketCap,  String decimals,  String price,  String contractAddress,  String chainId,  String chainName,  String chainLogo,  String network,  String slug,  String chainIndex)  $default,) {final _that = this;
switch (_that) {
case _HotTokenEntity():
return $default(_that.name,_that.symbol,_that.logo,_that.marketCap,_that.decimals,_that.price,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogo,_that.network,_that.slug,_that.chainIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String symbol,  String logo,  String marketCap,  String decimals,  String price,  String contractAddress,  String chainId,  String chainName,  String chainLogo,  String network,  String slug,  String chainIndex)?  $default,) {final _that = this;
switch (_that) {
case _HotTokenEntity() when $default != null:
return $default(_that.name,_that.symbol,_that.logo,_that.marketCap,_that.decimals,_that.price,_that.contractAddress,_that.chainId,_that.chainName,_that.chainLogo,_that.network,_that.slug,_that.chainIndex);case _:
  return null;

}
}

}

/// @nodoc


class _HotTokenEntity implements HotTokenEntity {
  const _HotTokenEntity({required this.name, required this.symbol, required this.logo, required this.marketCap, required this.decimals, required this.price, required this.contractAddress, required this.chainId, required this.chainName, required this.chainLogo, required this.network, required this.slug, required this.chainIndex});
  

@override final  String name;
@override final  String symbol;
@override final  String logo;
@override final  String marketCap;
@override final  String decimals;
@override final  String price;
@override final  String contractAddress;
@override final  String chainId;
@override final  String chainName;
@override final  String chainLogo;
@override final  String network;
@override final  String slug;
@override final  String chainIndex;

/// Create a copy of HotTokenEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HotTokenEntityCopyWith<_HotTokenEntity> get copyWith => __$HotTokenEntityCopyWithImpl<_HotTokenEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HotTokenEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.price, price) || other.price == price)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.network, network) || other.network == network)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.chainIndex, chainIndex) || other.chainIndex == chainIndex));
}


@override
int get hashCode => Object.hash(runtimeType,name,symbol,logo,marketCap,decimals,price,contractAddress,chainId,chainName,chainLogo,network,slug,chainIndex);

@override
String toString() {
  return 'HotTokenEntity(name: $name, symbol: $symbol, logo: $logo, marketCap: $marketCap, decimals: $decimals, price: $price, contractAddress: $contractAddress, chainId: $chainId, chainName: $chainName, chainLogo: $chainLogo, network: $network, slug: $slug, chainIndex: $chainIndex)';
}


}

/// @nodoc
abstract mixin class _$HotTokenEntityCopyWith<$Res> implements $HotTokenEntityCopyWith<$Res> {
  factory _$HotTokenEntityCopyWith(_HotTokenEntity value, $Res Function(_HotTokenEntity) _then) = __$HotTokenEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String symbol, String logo, String marketCap, String decimals, String price, String contractAddress, String chainId, String chainName, String chainLogo, String network, String slug, String chainIndex
});




}
/// @nodoc
class __$HotTokenEntityCopyWithImpl<$Res>
    implements _$HotTokenEntityCopyWith<$Res> {
  __$HotTokenEntityCopyWithImpl(this._self, this._then);

  final _HotTokenEntity _self;
  final $Res Function(_HotTokenEntity) _then;

/// Create a copy of HotTokenEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? symbol = null,Object? logo = null,Object? marketCap = null,Object? decimals = null,Object? price = null,Object? contractAddress = null,Object? chainId = null,Object? chainName = null,Object? chainLogo = null,Object? network = null,Object? slug = null,Object? chainIndex = null,}) {
  return _then(_HotTokenEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,contractAddress: null == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,chainIndex: null == chainIndex ? _self.chainIndex : chainIndex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
