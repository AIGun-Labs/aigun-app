// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenEntity {

 String get chainId; String get chainLogo; String get chainName; String get tokenLogo; String get tokenName; String get tokenPrice; String get symbol; String get network; String get address; String get rawBalance; String get balance; int get decimals; String get priceChange24h; String get marketCap; bool get isNative;
/// Create a copy of TokenEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenEntityCopyWith<TokenEntity> get copyWith => _$TokenEntityCopyWithImpl<TokenEntity>(this as TokenEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenEntity&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.tokenLogo, tokenLogo) || other.tokenLogo == tokenLogo)&&(identical(other.tokenName, tokenName) || other.tokenName == tokenName)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.network, network) || other.network == network)&&(identical(other.address, address) || other.address == address)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,chainLogo,chainName,tokenLogo,tokenName,tokenPrice,symbol,network,address,rawBalance,balance,decimals,priceChange24h,marketCap,isNative);

@override
String toString() {
  return 'TokenEntity(chainId: $chainId, chainLogo: $chainLogo, chainName: $chainName, tokenLogo: $tokenLogo, tokenName: $tokenName, tokenPrice: $tokenPrice, symbol: $symbol, network: $network, address: $address, rawBalance: $rawBalance, balance: $balance, decimals: $decimals, priceChange24h: $priceChange24h, marketCap: $marketCap, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class $TokenEntityCopyWith<$Res>  {
  factory $TokenEntityCopyWith(TokenEntity value, $Res Function(TokenEntity) _then) = _$TokenEntityCopyWithImpl;
@useResult
$Res call({
 String chainId, String chainLogo, String chainName, String tokenLogo, String tokenName, String tokenPrice, String symbol, String network, String address, String rawBalance, String balance, int decimals, String priceChange24h, String marketCap, bool isNative
});




}
/// @nodoc
class _$TokenEntityCopyWithImpl<$Res>
    implements $TokenEntityCopyWith<$Res> {
  _$TokenEntityCopyWithImpl(this._self, this._then);

  final TokenEntity _self;
  final $Res Function(TokenEntity) _then;

/// Create a copy of TokenEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? chainLogo = null,Object? chainName = null,Object? tokenLogo = null,Object? tokenName = null,Object? tokenPrice = null,Object? symbol = null,Object? network = null,Object? address = null,Object? rawBalance = null,Object? balance = null,Object? decimals = null,Object? priceChange24h = null,Object? marketCap = null,Object? isNative = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,tokenLogo: null == tokenLogo ? _self.tokenLogo : tokenLogo // ignore: cast_nullable_to_non_nullable
as String,tokenName: null == tokenName ? _self.tokenName : tokenName // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,priceChange24h: null == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,isNative: null == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenEntity].
extension TokenEntityPatterns on TokenEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenEntity value)  $default,){
final _that = this;
switch (_that) {
case _TokenEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TokenEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String chainLogo,  String chainName,  String tokenLogo,  String tokenName,  String tokenPrice,  String symbol,  String network,  String address,  String rawBalance,  String balance,  int decimals,  String priceChange24h,  String marketCap,  bool isNative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenEntity() when $default != null:
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenLogo,_that.tokenName,_that.tokenPrice,_that.symbol,_that.network,_that.address,_that.rawBalance,_that.balance,_that.decimals,_that.priceChange24h,_that.marketCap,_that.isNative);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String chainLogo,  String chainName,  String tokenLogo,  String tokenName,  String tokenPrice,  String symbol,  String network,  String address,  String rawBalance,  String balance,  int decimals,  String priceChange24h,  String marketCap,  bool isNative)  $default,) {final _that = this;
switch (_that) {
case _TokenEntity():
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenLogo,_that.tokenName,_that.tokenPrice,_that.symbol,_that.network,_that.address,_that.rawBalance,_that.balance,_that.decimals,_that.priceChange24h,_that.marketCap,_that.isNative);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String chainLogo,  String chainName,  String tokenLogo,  String tokenName,  String tokenPrice,  String symbol,  String network,  String address,  String rawBalance,  String balance,  int decimals,  String priceChange24h,  String marketCap,  bool isNative)?  $default,) {final _that = this;
switch (_that) {
case _TokenEntity() when $default != null:
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenLogo,_that.tokenName,_that.tokenPrice,_that.symbol,_that.network,_that.address,_that.rawBalance,_that.balance,_that.decimals,_that.priceChange24h,_that.marketCap,_that.isNative);case _:
  return null;

}
}

}

/// @nodoc


class _TokenEntity extends TokenEntity {
  const _TokenEntity({required this.chainId, required this.chainLogo, required this.chainName, required this.tokenLogo, required this.tokenName, required this.tokenPrice, required this.symbol, required this.network, required this.address, required this.rawBalance, required this.balance, required this.decimals, required this.priceChange24h, required this.marketCap, required this.isNative}): super._();
  

@override final  String chainId;
@override final  String chainLogo;
@override final  String chainName;
@override final  String tokenLogo;
@override final  String tokenName;
@override final  String tokenPrice;
@override final  String symbol;
@override final  String network;
@override final  String address;
@override final  String rawBalance;
@override final  String balance;
@override final  int decimals;
@override final  String priceChange24h;
@override final  String marketCap;
@override final  bool isNative;

/// Create a copy of TokenEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenEntityCopyWith<_TokenEntity> get copyWith => __$TokenEntityCopyWithImpl<_TokenEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenEntity&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.tokenLogo, tokenLogo) || other.tokenLogo == tokenLogo)&&(identical(other.tokenName, tokenName) || other.tokenName == tokenName)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.network, network) || other.network == network)&&(identical(other.address, address) || other.address == address)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,chainLogo,chainName,tokenLogo,tokenName,tokenPrice,symbol,network,address,rawBalance,balance,decimals,priceChange24h,marketCap,isNative);

@override
String toString() {
  return 'TokenEntity(chainId: $chainId, chainLogo: $chainLogo, chainName: $chainName, tokenLogo: $tokenLogo, tokenName: $tokenName, tokenPrice: $tokenPrice, symbol: $symbol, network: $network, address: $address, rawBalance: $rawBalance, balance: $balance, decimals: $decimals, priceChange24h: $priceChange24h, marketCap: $marketCap, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class _$TokenEntityCopyWith<$Res> implements $TokenEntityCopyWith<$Res> {
  factory _$TokenEntityCopyWith(_TokenEntity value, $Res Function(_TokenEntity) _then) = __$TokenEntityCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String chainLogo, String chainName, String tokenLogo, String tokenName, String tokenPrice, String symbol, String network, String address, String rawBalance, String balance, int decimals, String priceChange24h, String marketCap, bool isNative
});




}
/// @nodoc
class __$TokenEntityCopyWithImpl<$Res>
    implements _$TokenEntityCopyWith<$Res> {
  __$TokenEntityCopyWithImpl(this._self, this._then);

  final _TokenEntity _self;
  final $Res Function(_TokenEntity) _then;

/// Create a copy of TokenEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? chainLogo = null,Object? chainName = null,Object? tokenLogo = null,Object? tokenName = null,Object? tokenPrice = null,Object? symbol = null,Object? network = null,Object? address = null,Object? rawBalance = null,Object? balance = null,Object? decimals = null,Object? priceChange24h = null,Object? marketCap = null,Object? isNative = null,}) {
  return _then(_TokenEntity(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,tokenLogo: null == tokenLogo ? _self.tokenLogo : tokenLogo // ignore: cast_nullable_to_non_nullable
as String,tokenName: null == tokenName ? _self.tokenName : tokenName // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,priceChange24h: null == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,isNative: null == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
