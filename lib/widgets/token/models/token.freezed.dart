// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Token {

@JsonKey(name: 'chain_id') String get chainId;// @JsonKey(name: "chain_name") String chainName,
@JsonKey(name: 'chain_logo') String get chainLogo;@JsonKey(name: 'chain_name') String get chainName;@JsonKey(name: 'token_avatar') String get tokenAvatar;@JsonKey(name: 'token_name') String get tokenName;@JsonKey(name: 'address') String get address;@JsonKey(name: 'token_price') String get tokenPrice;@JsonKey(name: 'raw_balance') String get rawBalance;@JsonKey(name: 'balance') String get balance;@JsonKey(name: 'decimals') int get decimals;@JsonKey(name: 'symbol') String get symbol;@JsonKey(name: 'slug', readValue: _readSlugOrNetwork) String? get slug;@JsonKey(name: 'price_change_24h') double? get priceChange24h;@JsonKey(name: 'market_cap') double? get marketCap;@JsonKey(name: 'network', readValue: _readNetworkOrSlug) String? get network;@JsonKey(name: 'is_native') bool get isNative;
/// Create a copy of Token
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenCopyWith<Token> get copyWith => _$TokenCopyWithImpl<Token>(this as Token, _$identity);

  /// Serializes this Token to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Token&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.tokenAvatar, tokenAvatar) || other.tokenAvatar == tokenAvatar)&&(identical(other.tokenName, tokenName) || other.tokenName == tokenName)&&(identical(other.address, address) || other.address == address)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.network, network) || other.network == network)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,chainLogo,chainName,tokenAvatar,tokenName,address,tokenPrice,rawBalance,balance,decimals,symbol,slug,priceChange24h,marketCap,network,isNative);

@override
String toString() {
  return 'Token(chainId: $chainId, chainLogo: $chainLogo, chainName: $chainName, tokenAvatar: $tokenAvatar, tokenName: $tokenName, address: $address, tokenPrice: $tokenPrice, rawBalance: $rawBalance, balance: $balance, decimals: $decimals, symbol: $symbol, slug: $slug, priceChange24h: $priceChange24h, marketCap: $marketCap, network: $network, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class $TokenCopyWith<$Res>  {
  factory $TokenCopyWith(Token value, $Res Function(Token) _then) = _$TokenCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'chain_id') String chainId,@JsonKey(name: 'chain_logo') String chainLogo,@JsonKey(name: 'chain_name') String chainName,@JsonKey(name: 'token_avatar') String tokenAvatar,@JsonKey(name: 'token_name') String tokenName,@JsonKey(name: 'address') String address,@JsonKey(name: 'token_price') String tokenPrice,@JsonKey(name: 'raw_balance') String rawBalance,@JsonKey(name: 'balance') String balance,@JsonKey(name: 'decimals') int decimals,@JsonKey(name: 'symbol') String symbol,@JsonKey(name: 'slug', readValue: _readSlugOrNetwork) String? slug,@JsonKey(name: 'price_change_24h') double? priceChange24h,@JsonKey(name: 'market_cap') double? marketCap,@JsonKey(name: 'network', readValue: _readNetworkOrSlug) String? network,@JsonKey(name: 'is_native') bool isNative
});




}
/// @nodoc
class _$TokenCopyWithImpl<$Res>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._self, this._then);

  final Token _self;
  final $Res Function(Token) _then;

/// Create a copy of Token
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? chainLogo = null,Object? chainName = null,Object? tokenAvatar = null,Object? tokenName = null,Object? address = null,Object? tokenPrice = null,Object? rawBalance = null,Object? balance = null,Object? decimals = null,Object? symbol = null,Object? slug = freezed,Object? priceChange24h = freezed,Object? marketCap = freezed,Object? network = freezed,Object? isNative = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,tokenAvatar: null == tokenAvatar ? _self.tokenAvatar : tokenAvatar // ignore: cast_nullable_to_non_nullable
as String,tokenName: null == tokenName ? _self.tokenName : tokenName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,isNative: null == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Token].
extension TokenPatterns on Token {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Token value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Token() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Token value)  $default,){
final _that = this;
switch (_that) {
case _Token():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Token value)?  $default,){
final _that = this;
switch (_that) {
case _Token() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'token_avatar')  String tokenAvatar, @JsonKey(name: 'token_name')  String tokenName, @JsonKey(name: 'address')  String address, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)  String? slug, @JsonKey(name: 'price_change_24h')  double? priceChange24h, @JsonKey(name: 'market_cap')  double? marketCap, @JsonKey(name: 'network', readValue: _readNetworkOrSlug)  String? network, @JsonKey(name: 'is_native')  bool isNative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Token() when $default != null:
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenAvatar,_that.tokenName,_that.address,_that.tokenPrice,_that.rawBalance,_that.balance,_that.decimals,_that.symbol,_that.slug,_that.priceChange24h,_that.marketCap,_that.network,_that.isNative);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'token_avatar')  String tokenAvatar, @JsonKey(name: 'token_name')  String tokenName, @JsonKey(name: 'address')  String address, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)  String? slug, @JsonKey(name: 'price_change_24h')  double? priceChange24h, @JsonKey(name: 'market_cap')  double? marketCap, @JsonKey(name: 'network', readValue: _readNetworkOrSlug)  String? network, @JsonKey(name: 'is_native')  bool isNative)  $default,) {final _that = this;
switch (_that) {
case _Token():
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenAvatar,_that.tokenName,_that.address,_that.tokenPrice,_that.rawBalance,_that.balance,_that.decimals,_that.symbol,_that.slug,_that.priceChange24h,_that.marketCap,_that.network,_that.isNative);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'token_avatar')  String tokenAvatar, @JsonKey(name: 'token_name')  String tokenName, @JsonKey(name: 'address')  String address, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)  String? slug, @JsonKey(name: 'price_change_24h')  double? priceChange24h, @JsonKey(name: 'market_cap')  double? marketCap, @JsonKey(name: 'network', readValue: _readNetworkOrSlug)  String? network, @JsonKey(name: 'is_native')  bool isNative)?  $default,) {final _that = this;
switch (_that) {
case _Token() when $default != null:
return $default(_that.chainId,_that.chainLogo,_that.chainName,_that.tokenAvatar,_that.tokenName,_that.address,_that.tokenPrice,_that.rawBalance,_that.balance,_that.decimals,_that.symbol,_that.slug,_that.priceChange24h,_that.marketCap,_that.network,_that.isNative);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Token extends Token {
  const _Token({@JsonKey(name: 'chain_id') required this.chainId, @JsonKey(name: 'chain_logo') required this.chainLogo, @JsonKey(name: 'chain_name') required this.chainName, @JsonKey(name: 'token_avatar') required this.tokenAvatar, @JsonKey(name: 'token_name') required this.tokenName, @JsonKey(name: 'address') required this.address, @JsonKey(name: 'token_price') required this.tokenPrice, @JsonKey(name: 'raw_balance') required this.rawBalance, @JsonKey(name: 'balance') required this.balance, @JsonKey(name: 'decimals') required this.decimals, @JsonKey(name: 'symbol') required this.symbol, @JsonKey(name: 'slug', readValue: _readSlugOrNetwork) this.slug = '', @JsonKey(name: 'price_change_24h') this.priceChange24h = 0, @JsonKey(name: 'market_cap') this.marketCap = 0.0, @JsonKey(name: 'network', readValue: _readNetworkOrSlug) this.network = '', @JsonKey(name: 'is_native') required this.isNative}): super._();
  factory _Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

@override@JsonKey(name: 'chain_id') final  String chainId;
// @JsonKey(name: "chain_name") String chainName,
@override@JsonKey(name: 'chain_logo') final  String chainLogo;
@override@JsonKey(name: 'chain_name') final  String chainName;
@override@JsonKey(name: 'token_avatar') final  String tokenAvatar;
@override@JsonKey(name: 'token_name') final  String tokenName;
@override@JsonKey(name: 'address') final  String address;
@override@JsonKey(name: 'token_price') final  String tokenPrice;
@override@JsonKey(name: 'raw_balance') final  String rawBalance;
@override@JsonKey(name: 'balance') final  String balance;
@override@JsonKey(name: 'decimals') final  int decimals;
@override@JsonKey(name: 'symbol') final  String symbol;
@override@JsonKey(name: 'slug', readValue: _readSlugOrNetwork) final  String? slug;
@override@JsonKey(name: 'price_change_24h') final  double? priceChange24h;
@override@JsonKey(name: 'market_cap') final  double? marketCap;
@override@JsonKey(name: 'network', readValue: _readNetworkOrSlug) final  String? network;
@override@JsonKey(name: 'is_native') final  bool isNative;

/// Create a copy of Token
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenCopyWith<_Token> get copyWith => __$TokenCopyWithImpl<_Token>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Token&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.tokenAvatar, tokenAvatar) || other.tokenAvatar == tokenAvatar)&&(identical(other.tokenName, tokenName) || other.tokenName == tokenName)&&(identical(other.address, address) || other.address == address)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.network, network) || other.network == network)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,chainLogo,chainName,tokenAvatar,tokenName,address,tokenPrice,rawBalance,balance,decimals,symbol,slug,priceChange24h,marketCap,network,isNative);

@override
String toString() {
  return 'Token(chainId: $chainId, chainLogo: $chainLogo, chainName: $chainName, tokenAvatar: $tokenAvatar, tokenName: $tokenName, address: $address, tokenPrice: $tokenPrice, rawBalance: $rawBalance, balance: $balance, decimals: $decimals, symbol: $symbol, slug: $slug, priceChange24h: $priceChange24h, marketCap: $marketCap, network: $network, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class _$TokenCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$TokenCopyWith(_Token value, $Res Function(_Token) _then) = __$TokenCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'chain_id') String chainId,@JsonKey(name: 'chain_logo') String chainLogo,@JsonKey(name: 'chain_name') String chainName,@JsonKey(name: 'token_avatar') String tokenAvatar,@JsonKey(name: 'token_name') String tokenName,@JsonKey(name: 'address') String address,@JsonKey(name: 'token_price') String tokenPrice,@JsonKey(name: 'raw_balance') String rawBalance,@JsonKey(name: 'balance') String balance,@JsonKey(name: 'decimals') int decimals,@JsonKey(name: 'symbol') String symbol,@JsonKey(name: 'slug', readValue: _readSlugOrNetwork) String? slug,@JsonKey(name: 'price_change_24h') double? priceChange24h,@JsonKey(name: 'market_cap') double? marketCap,@JsonKey(name: 'network', readValue: _readNetworkOrSlug) String? network,@JsonKey(name: 'is_native') bool isNative
});




}
/// @nodoc
class __$TokenCopyWithImpl<$Res>
    implements _$TokenCopyWith<$Res> {
  __$TokenCopyWithImpl(this._self, this._then);

  final _Token _self;
  final $Res Function(_Token) _then;

/// Create a copy of Token
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? chainLogo = null,Object? chainName = null,Object? tokenAvatar = null,Object? tokenName = null,Object? address = null,Object? tokenPrice = null,Object? rawBalance = null,Object? balance = null,Object? decimals = null,Object? symbol = null,Object? slug = freezed,Object? priceChange24h = freezed,Object? marketCap = freezed,Object? network = freezed,Object? isNative = null,}) {
  return _then(_Token(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,tokenAvatar: null == tokenAvatar ? _self.tokenAvatar : tokenAvatar // ignore: cast_nullable_to_non_nullable
as String,tokenName: null == tokenName ? _self.tokenName : tokenName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,isNative: null == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
