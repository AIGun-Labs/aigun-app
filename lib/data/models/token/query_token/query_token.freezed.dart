// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryToken {

 String? get name; String? get symbol; String? get address; String? get network;@JsonKey(name: 'network_id') int? get networkId;@JsonKey(name: 'network_name') String? get networkName;@JsonKey(name: 'is_internal') bool? get isInternal; String? get logo;@JsonKey(name: 'market_cap') String? get marketCap;@JsonKey(name: 'price_usd') String? get priceUsd; int? get decimals;@JsonKey(name: 'network_logo') String? get networkLogo;@JsonKey(name: 'volume_24h') String? get volume24h; String? get liquidity;@JsonKey(name: 'price_change_24h') String? get priceChange24h;@JsonKey(name: 'is_native') bool? get isNative;@JsonKey(name: 'is_mainstream') bool? get isMainstream; String? get balance;@JsonKey(name: 'raw_balance') String? get rawBalance;@JsonKey(name: 'balance_usd') double? get balanceUsd;
/// Create a copy of QueryToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryTokenCopyWith<QueryToken> get copyWith => _$QueryTokenCopyWithImpl<QueryToken>(this as QueryToken, _$identity);

  /// Serializes this QueryToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryToken&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.address, address) || other.address == address)&&(identical(other.network, network) || other.network == network)&&(identical(other.networkId, networkId) || other.networkId == networkId)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.isInternal, isInternal) || other.isInternal == isInternal)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.priceUsd, priceUsd) || other.priceUsd == priceUsd)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.networkLogo, networkLogo) || other.networkLogo == networkLogo)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.liquidity, liquidity) || other.liquidity == liquidity)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.isNative, isNative) || other.isNative == isNative)&&(identical(other.isMainstream, isMainstream) || other.isMainstream == isMainstream)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balanceUsd, balanceUsd) || other.balanceUsd == balanceUsd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,symbol,address,network,networkId,networkName,isInternal,logo,marketCap,priceUsd,decimals,networkLogo,volume24h,liquidity,priceChange24h,isNative,isMainstream,balance,rawBalance,balanceUsd]);

@override
String toString() {
  return 'QueryToken(name: $name, symbol: $symbol, address: $address, network: $network, networkId: $networkId, networkName: $networkName, isInternal: $isInternal, logo: $logo, marketCap: $marketCap, priceUsd: $priceUsd, decimals: $decimals, networkLogo: $networkLogo, volume24h: $volume24h, liquidity: $liquidity, priceChange24h: $priceChange24h, isNative: $isNative, isMainstream: $isMainstream, balance: $balance, rawBalance: $rawBalance, balanceUsd: $balanceUsd)';
}


}

/// @nodoc
abstract mixin class $QueryTokenCopyWith<$Res>  {
  factory $QueryTokenCopyWith(QueryToken value, $Res Function(QueryToken) _then) = _$QueryTokenCopyWithImpl;
@useResult
$Res call({
 String? name, String? symbol, String? address, String? network,@JsonKey(name: 'network_id') int? networkId,@JsonKey(name: 'network_name') String? networkName,@JsonKey(name: 'is_internal') bool? isInternal, String? logo,@JsonKey(name: 'market_cap') String? marketCap,@JsonKey(name: 'price_usd') String? priceUsd, int? decimals,@JsonKey(name: 'network_logo') String? networkLogo,@JsonKey(name: 'volume_24h') String? volume24h, String? liquidity,@JsonKey(name: 'price_change_24h') String? priceChange24h,@JsonKey(name: 'is_native') bool? isNative,@JsonKey(name: 'is_mainstream') bool? isMainstream, String? balance,@JsonKey(name: 'raw_balance') String? rawBalance,@JsonKey(name: 'balance_usd') double? balanceUsd
});




}
/// @nodoc
class _$QueryTokenCopyWithImpl<$Res>
    implements $QueryTokenCopyWith<$Res> {
  _$QueryTokenCopyWithImpl(this._self, this._then);

  final QueryToken _self;
  final $Res Function(QueryToken) _then;

/// Create a copy of QueryToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? symbol = freezed,Object? address = freezed,Object? network = freezed,Object? networkId = freezed,Object? networkName = freezed,Object? isInternal = freezed,Object? logo = freezed,Object? marketCap = freezed,Object? priceUsd = freezed,Object? decimals = freezed,Object? networkLogo = freezed,Object? volume24h = freezed,Object? liquidity = freezed,Object? priceChange24h = freezed,Object? isNative = freezed,Object? isMainstream = freezed,Object? balance = freezed,Object? rawBalance = freezed,Object? balanceUsd = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,networkId: freezed == networkId ? _self.networkId : networkId // ignore: cast_nullable_to_non_nullable
as int?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,isInternal: freezed == isInternal ? _self.isInternal : isInternal // ignore: cast_nullable_to_non_nullable
as bool?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String?,priceUsd: freezed == priceUsd ? _self.priceUsd : priceUsd // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,networkLogo: freezed == networkLogo ? _self.networkLogo : networkLogo // ignore: cast_nullable_to_non_nullable
as String?,volume24h: freezed == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as String?,liquidity: freezed == liquidity ? _self.liquidity : liquidity // ignore: cast_nullable_to_non_nullable
as String?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as String?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,isMainstream: freezed == isMainstream ? _self.isMainstream : isMainstream // ignore: cast_nullable_to_non_nullable
as bool?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String?,rawBalance: freezed == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String?,balanceUsd: freezed == balanceUsd ? _self.balanceUsd : balanceUsd // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryToken].
extension QueryTokenPatterns on QueryToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryToken value)  $default,){
final _that = this;
switch (_that) {
case _QueryToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryToken value)?  $default,){
final _that = this;
switch (_that) {
case _QueryToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? symbol,  String? address,  String? network, @JsonKey(name: 'network_id')  int? networkId, @JsonKey(name: 'network_name')  String? networkName, @JsonKey(name: 'is_internal')  bool? isInternal,  String? logo, @JsonKey(name: 'market_cap')  String? marketCap, @JsonKey(name: 'price_usd')  String? priceUsd,  int? decimals, @JsonKey(name: 'network_logo')  String? networkLogo, @JsonKey(name: 'volume_24h')  String? volume24h,  String? liquidity, @JsonKey(name: 'price_change_24h')  String? priceChange24h, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'is_mainstream')  bool? isMainstream,  String? balance, @JsonKey(name: 'raw_balance')  String? rawBalance, @JsonKey(name: 'balance_usd')  double? balanceUsd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryToken() when $default != null:
return $default(_that.name,_that.symbol,_that.address,_that.network,_that.networkId,_that.networkName,_that.isInternal,_that.logo,_that.marketCap,_that.priceUsd,_that.decimals,_that.networkLogo,_that.volume24h,_that.liquidity,_that.priceChange24h,_that.isNative,_that.isMainstream,_that.balance,_that.rawBalance,_that.balanceUsd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? symbol,  String? address,  String? network, @JsonKey(name: 'network_id')  int? networkId, @JsonKey(name: 'network_name')  String? networkName, @JsonKey(name: 'is_internal')  bool? isInternal,  String? logo, @JsonKey(name: 'market_cap')  String? marketCap, @JsonKey(name: 'price_usd')  String? priceUsd,  int? decimals, @JsonKey(name: 'network_logo')  String? networkLogo, @JsonKey(name: 'volume_24h')  String? volume24h,  String? liquidity, @JsonKey(name: 'price_change_24h')  String? priceChange24h, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'is_mainstream')  bool? isMainstream,  String? balance, @JsonKey(name: 'raw_balance')  String? rawBalance, @JsonKey(name: 'balance_usd')  double? balanceUsd)  $default,) {final _that = this;
switch (_that) {
case _QueryToken():
return $default(_that.name,_that.symbol,_that.address,_that.network,_that.networkId,_that.networkName,_that.isInternal,_that.logo,_that.marketCap,_that.priceUsd,_that.decimals,_that.networkLogo,_that.volume24h,_that.liquidity,_that.priceChange24h,_that.isNative,_that.isMainstream,_that.balance,_that.rawBalance,_that.balanceUsd);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? symbol,  String? address,  String? network, @JsonKey(name: 'network_id')  int? networkId, @JsonKey(name: 'network_name')  String? networkName, @JsonKey(name: 'is_internal')  bool? isInternal,  String? logo, @JsonKey(name: 'market_cap')  String? marketCap, @JsonKey(name: 'price_usd')  String? priceUsd,  int? decimals, @JsonKey(name: 'network_logo')  String? networkLogo, @JsonKey(name: 'volume_24h')  String? volume24h,  String? liquidity, @JsonKey(name: 'price_change_24h')  String? priceChange24h, @JsonKey(name: 'is_native')  bool? isNative, @JsonKey(name: 'is_mainstream')  bool? isMainstream,  String? balance, @JsonKey(name: 'raw_balance')  String? rawBalance, @JsonKey(name: 'balance_usd')  double? balanceUsd)?  $default,) {final _that = this;
switch (_that) {
case _QueryToken() when $default != null:
return $default(_that.name,_that.symbol,_that.address,_that.network,_that.networkId,_that.networkName,_that.isInternal,_that.logo,_that.marketCap,_that.priceUsd,_that.decimals,_that.networkLogo,_that.volume24h,_that.liquidity,_that.priceChange24h,_that.isNative,_that.isMainstream,_that.balance,_that.rawBalance,_that.balanceUsd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryToken implements QueryToken {
  const _QueryToken({this.name, this.symbol, this.address, this.network, @JsonKey(name: 'network_id') this.networkId, @JsonKey(name: 'network_name') this.networkName, @JsonKey(name: 'is_internal') this.isInternal = false, this.logo, @JsonKey(name: 'market_cap') this.marketCap, @JsonKey(name: 'price_usd') this.priceUsd, this.decimals, @JsonKey(name: 'network_logo') this.networkLogo, @JsonKey(name: 'volume_24h') this.volume24h, this.liquidity, @JsonKey(name: 'price_change_24h') this.priceChange24h, @JsonKey(name: 'is_native') this.isNative = false, @JsonKey(name: 'is_mainstream') this.isMainstream, this.balance, @JsonKey(name: 'raw_balance') this.rawBalance, @JsonKey(name: 'balance_usd') this.balanceUsd});
  factory _QueryToken.fromJson(Map<String, dynamic> json) => _$QueryTokenFromJson(json);

@override final  String? name;
@override final  String? symbol;
@override final  String? address;
@override final  String? network;
@override@JsonKey(name: 'network_id') final  int? networkId;
@override@JsonKey(name: 'network_name') final  String? networkName;
@override@JsonKey(name: 'is_internal') final  bool? isInternal;
@override final  String? logo;
@override@JsonKey(name: 'market_cap') final  String? marketCap;
@override@JsonKey(name: 'price_usd') final  String? priceUsd;
@override final  int? decimals;
@override@JsonKey(name: 'network_logo') final  String? networkLogo;
@override@JsonKey(name: 'volume_24h') final  String? volume24h;
@override final  String? liquidity;
@override@JsonKey(name: 'price_change_24h') final  String? priceChange24h;
@override@JsonKey(name: 'is_native') final  bool? isNative;
@override@JsonKey(name: 'is_mainstream') final  bool? isMainstream;
@override final  String? balance;
@override@JsonKey(name: 'raw_balance') final  String? rawBalance;
@override@JsonKey(name: 'balance_usd') final  double? balanceUsd;

/// Create a copy of QueryToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryTokenCopyWith<_QueryToken> get copyWith => __$QueryTokenCopyWithImpl<_QueryToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryToken&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.address, address) || other.address == address)&&(identical(other.network, network) || other.network == network)&&(identical(other.networkId, networkId) || other.networkId == networkId)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.isInternal, isInternal) || other.isInternal == isInternal)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.priceUsd, priceUsd) || other.priceUsd == priceUsd)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.networkLogo, networkLogo) || other.networkLogo == networkLogo)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.liquidity, liquidity) || other.liquidity == liquidity)&&(identical(other.priceChange24h, priceChange24h) || other.priceChange24h == priceChange24h)&&(identical(other.isNative, isNative) || other.isNative == isNative)&&(identical(other.isMainstream, isMainstream) || other.isMainstream == isMainstream)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.balanceUsd, balanceUsd) || other.balanceUsd == balanceUsd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,symbol,address,network,networkId,networkName,isInternal,logo,marketCap,priceUsd,decimals,networkLogo,volume24h,liquidity,priceChange24h,isNative,isMainstream,balance,rawBalance,balanceUsd]);

@override
String toString() {
  return 'QueryToken(name: $name, symbol: $symbol, address: $address, network: $network, networkId: $networkId, networkName: $networkName, isInternal: $isInternal, logo: $logo, marketCap: $marketCap, priceUsd: $priceUsd, decimals: $decimals, networkLogo: $networkLogo, volume24h: $volume24h, liquidity: $liquidity, priceChange24h: $priceChange24h, isNative: $isNative, isMainstream: $isMainstream, balance: $balance, rawBalance: $rawBalance, balanceUsd: $balanceUsd)';
}


}

/// @nodoc
abstract mixin class _$QueryTokenCopyWith<$Res> implements $QueryTokenCopyWith<$Res> {
  factory _$QueryTokenCopyWith(_QueryToken value, $Res Function(_QueryToken) _then) = __$QueryTokenCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? symbol, String? address, String? network,@JsonKey(name: 'network_id') int? networkId,@JsonKey(name: 'network_name') String? networkName,@JsonKey(name: 'is_internal') bool? isInternal, String? logo,@JsonKey(name: 'market_cap') String? marketCap,@JsonKey(name: 'price_usd') String? priceUsd, int? decimals,@JsonKey(name: 'network_logo') String? networkLogo,@JsonKey(name: 'volume_24h') String? volume24h, String? liquidity,@JsonKey(name: 'price_change_24h') String? priceChange24h,@JsonKey(name: 'is_native') bool? isNative,@JsonKey(name: 'is_mainstream') bool? isMainstream, String? balance,@JsonKey(name: 'raw_balance') String? rawBalance,@JsonKey(name: 'balance_usd') double? balanceUsd
});




}
/// @nodoc
class __$QueryTokenCopyWithImpl<$Res>
    implements _$QueryTokenCopyWith<$Res> {
  __$QueryTokenCopyWithImpl(this._self, this._then);

  final _QueryToken _self;
  final $Res Function(_QueryToken) _then;

/// Create a copy of QueryToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? symbol = freezed,Object? address = freezed,Object? network = freezed,Object? networkId = freezed,Object? networkName = freezed,Object? isInternal = freezed,Object? logo = freezed,Object? marketCap = freezed,Object? priceUsd = freezed,Object? decimals = freezed,Object? networkLogo = freezed,Object? volume24h = freezed,Object? liquidity = freezed,Object? priceChange24h = freezed,Object? isNative = freezed,Object? isMainstream = freezed,Object? balance = freezed,Object? rawBalance = freezed,Object? balanceUsd = freezed,}) {
  return _then(_QueryToken(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,networkId: freezed == networkId ? _self.networkId : networkId // ignore: cast_nullable_to_non_nullable
as int?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,isInternal: freezed == isInternal ? _self.isInternal : isInternal // ignore: cast_nullable_to_non_nullable
as bool?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String?,priceUsd: freezed == priceUsd ? _self.priceUsd : priceUsd // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,networkLogo: freezed == networkLogo ? _self.networkLogo : networkLogo // ignore: cast_nullable_to_non_nullable
as String?,volume24h: freezed == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as String?,liquidity: freezed == liquidity ? _self.liquidity : liquidity // ignore: cast_nullable_to_non_nullable
as String?,priceChange24h: freezed == priceChange24h ? _self.priceChange24h : priceChange24h // ignore: cast_nullable_to_non_nullable
as String?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,isMainstream: freezed == isMainstream ? _self.isMainstream : isMainstream // ignore: cast_nullable_to_non_nullable
as bool?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String?,rawBalance: freezed == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String?,balanceUsd: freezed == balanceUsd ? _self.balanceUsd : balanceUsd // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
