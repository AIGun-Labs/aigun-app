// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'native_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NativeToken {

@JsonKey(name: 'decimals') int get decimals;@JsonKey(name: 'symbol') String get symbol;@JsonKey(name: 'balance') String get balance;@JsonKey(name: 'token_price') String get tokenPrice;@JsonKey(name: 'chain_id') String get chainId;@JsonKey(name: 'chain_name') String get chainName;@JsonKey(name: 'chain_type') String get chainType;@JsonKey(name: 'raw_balance') String get rawBalance;@JsonKey(name: 'network') String get network;@JsonKey(name: 'chain_logo') String get chainLogo;@JsonKey(name: 'token_address') String get tokenAddress;@JsonKey(name: 'token_avatar') String get tokenAvatar;
/// Create a copy of NativeToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NativeTokenCopyWith<NativeToken> get copyWith => _$NativeTokenCopyWithImpl<NativeToken>(this as NativeToken, _$identity);

  /// Serializes this NativeToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NativeToken&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainType, chainType) || other.chainType == chainType)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.network, network) || other.network == network)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.tokenAddress, tokenAddress) || other.tokenAddress == tokenAddress)&&(identical(other.tokenAvatar, tokenAvatar) || other.tokenAvatar == tokenAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decimals,symbol,balance,tokenPrice,chainId,chainName,chainType,rawBalance,network,chainLogo,tokenAddress,tokenAvatar);

@override
String toString() {
  return 'NativeToken(decimals: $decimals, symbol: $symbol, balance: $balance, tokenPrice: $tokenPrice, chainId: $chainId, chainName: $chainName, chainType: $chainType, rawBalance: $rawBalance, network: $network, chainLogo: $chainLogo, tokenAddress: $tokenAddress, tokenAvatar: $tokenAvatar)';
}


}

/// @nodoc
abstract mixin class $NativeTokenCopyWith<$Res>  {
  factory $NativeTokenCopyWith(NativeToken value, $Res Function(NativeToken) _then) = _$NativeTokenCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'decimals') int decimals,@JsonKey(name: 'symbol') String symbol,@JsonKey(name: 'balance') String balance,@JsonKey(name: 'token_price') String tokenPrice,@JsonKey(name: 'chain_id') String chainId,@JsonKey(name: 'chain_name') String chainName,@JsonKey(name: 'chain_type') String chainType,@JsonKey(name: 'raw_balance') String rawBalance,@JsonKey(name: 'network') String network,@JsonKey(name: 'chain_logo') String chainLogo,@JsonKey(name: 'token_address') String tokenAddress,@JsonKey(name: 'token_avatar') String tokenAvatar
});




}
/// @nodoc
class _$NativeTokenCopyWithImpl<$Res>
    implements $NativeTokenCopyWith<$Res> {
  _$NativeTokenCopyWithImpl(this._self, this._then);

  final NativeToken _self;
  final $Res Function(NativeToken) _then;

/// Create a copy of NativeToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decimals = null,Object? symbol = null,Object? balance = null,Object? tokenPrice = null,Object? chainId = null,Object? chainName = null,Object? chainType = null,Object? rawBalance = null,Object? network = null,Object? chainLogo = null,Object? tokenAddress = null,Object? tokenAvatar = null,}) {
  return _then(_self.copyWith(
decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainType: null == chainType ? _self.chainType : chainType // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,tokenAddress: null == tokenAddress ? _self.tokenAddress : tokenAddress // ignore: cast_nullable_to_non_nullable
as String,tokenAvatar: null == tokenAvatar ? _self.tokenAvatar : tokenAvatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NativeToken].
extension NativeTokenPatterns on NativeToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NativeToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NativeToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NativeToken value)  $default,){
final _that = this;
switch (_that) {
case _NativeToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NativeToken value)?  $default,){
final _that = this;
switch (_that) {
case _NativeToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'chain_type')  String chainType, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'network')  String network, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'token_address')  String tokenAddress, @JsonKey(name: 'token_avatar')  String tokenAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NativeToken() when $default != null:
return $default(_that.decimals,_that.symbol,_that.balance,_that.tokenPrice,_that.chainId,_that.chainName,_that.chainType,_that.rawBalance,_that.network,_that.chainLogo,_that.tokenAddress,_that.tokenAvatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'chain_type')  String chainType, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'network')  String network, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'token_address')  String tokenAddress, @JsonKey(name: 'token_avatar')  String tokenAvatar)  $default,) {final _that = this;
switch (_that) {
case _NativeToken():
return $default(_that.decimals,_that.symbol,_that.balance,_that.tokenPrice,_that.chainId,_that.chainName,_that.chainType,_that.rawBalance,_that.network,_that.chainLogo,_that.tokenAddress,_that.tokenAvatar);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'decimals')  int decimals, @JsonKey(name: 'symbol')  String symbol, @JsonKey(name: 'balance')  String balance, @JsonKey(name: 'token_price')  String tokenPrice, @JsonKey(name: 'chain_id')  String chainId, @JsonKey(name: 'chain_name')  String chainName, @JsonKey(name: 'chain_type')  String chainType, @JsonKey(name: 'raw_balance')  String rawBalance, @JsonKey(name: 'network')  String network, @JsonKey(name: 'chain_logo')  String chainLogo, @JsonKey(name: 'token_address')  String tokenAddress, @JsonKey(name: 'token_avatar')  String tokenAvatar)?  $default,) {final _that = this;
switch (_that) {
case _NativeToken() when $default != null:
return $default(_that.decimals,_that.symbol,_that.balance,_that.tokenPrice,_that.chainId,_that.chainName,_that.chainType,_that.rawBalance,_that.network,_that.chainLogo,_that.tokenAddress,_that.tokenAvatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NativeToken implements NativeToken {
  const _NativeToken({@JsonKey(name: 'decimals') required this.decimals, @JsonKey(name: 'symbol') required this.symbol, @JsonKey(name: 'balance') required this.balance, @JsonKey(name: 'token_price') required this.tokenPrice, @JsonKey(name: 'chain_id') required this.chainId, @JsonKey(name: 'chain_name') required this.chainName, @JsonKey(name: 'chain_type') required this.chainType, @JsonKey(name: 'raw_balance') required this.rawBalance, @JsonKey(name: 'network') required this.network, @JsonKey(name: 'chain_logo') required this.chainLogo, @JsonKey(name: 'token_address') required this.tokenAddress, @JsonKey(name: 'token_avatar') required this.tokenAvatar});
  factory _NativeToken.fromJson(Map<String, dynamic> json) => _$NativeTokenFromJson(json);

@override@JsonKey(name: 'decimals') final  int decimals;
@override@JsonKey(name: 'symbol') final  String symbol;
@override@JsonKey(name: 'balance') final  String balance;
@override@JsonKey(name: 'token_price') final  String tokenPrice;
@override@JsonKey(name: 'chain_id') final  String chainId;
@override@JsonKey(name: 'chain_name') final  String chainName;
@override@JsonKey(name: 'chain_type') final  String chainType;
@override@JsonKey(name: 'raw_balance') final  String rawBalance;
@override@JsonKey(name: 'network') final  String network;
@override@JsonKey(name: 'chain_logo') final  String chainLogo;
@override@JsonKey(name: 'token_address') final  String tokenAddress;
@override@JsonKey(name: 'token_avatar') final  String tokenAvatar;

/// Create a copy of NativeToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NativeTokenCopyWith<_NativeToken> get copyWith => __$NativeTokenCopyWithImpl<_NativeToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NativeTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NativeToken&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.tokenPrice, tokenPrice) || other.tokenPrice == tokenPrice)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.chainName, chainName) || other.chainName == chainName)&&(identical(other.chainType, chainType) || other.chainType == chainType)&&(identical(other.rawBalance, rawBalance) || other.rawBalance == rawBalance)&&(identical(other.network, network) || other.network == network)&&(identical(other.chainLogo, chainLogo) || other.chainLogo == chainLogo)&&(identical(other.tokenAddress, tokenAddress) || other.tokenAddress == tokenAddress)&&(identical(other.tokenAvatar, tokenAvatar) || other.tokenAvatar == tokenAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decimals,symbol,balance,tokenPrice,chainId,chainName,chainType,rawBalance,network,chainLogo,tokenAddress,tokenAvatar);

@override
String toString() {
  return 'NativeToken(decimals: $decimals, symbol: $symbol, balance: $balance, tokenPrice: $tokenPrice, chainId: $chainId, chainName: $chainName, chainType: $chainType, rawBalance: $rawBalance, network: $network, chainLogo: $chainLogo, tokenAddress: $tokenAddress, tokenAvatar: $tokenAvatar)';
}


}

/// @nodoc
abstract mixin class _$NativeTokenCopyWith<$Res> implements $NativeTokenCopyWith<$Res> {
  factory _$NativeTokenCopyWith(_NativeToken value, $Res Function(_NativeToken) _then) = __$NativeTokenCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'decimals') int decimals,@JsonKey(name: 'symbol') String symbol,@JsonKey(name: 'balance') String balance,@JsonKey(name: 'token_price') String tokenPrice,@JsonKey(name: 'chain_id') String chainId,@JsonKey(name: 'chain_name') String chainName,@JsonKey(name: 'chain_type') String chainType,@JsonKey(name: 'raw_balance') String rawBalance,@JsonKey(name: 'network') String network,@JsonKey(name: 'chain_logo') String chainLogo,@JsonKey(name: 'token_address') String tokenAddress,@JsonKey(name: 'token_avatar') String tokenAvatar
});




}
/// @nodoc
class __$NativeTokenCopyWithImpl<$Res>
    implements _$NativeTokenCopyWith<$Res> {
  __$NativeTokenCopyWithImpl(this._self, this._then);

  final _NativeToken _self;
  final $Res Function(_NativeToken) _then;

/// Create a copy of NativeToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decimals = null,Object? symbol = null,Object? balance = null,Object? tokenPrice = null,Object? chainId = null,Object? chainName = null,Object? chainType = null,Object? rawBalance = null,Object? network = null,Object? chainLogo = null,Object? tokenAddress = null,Object? tokenAvatar = null,}) {
  return _then(_NativeToken(
decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,tokenPrice: null == tokenPrice ? _self.tokenPrice : tokenPrice // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,chainName: null == chainName ? _self.chainName : chainName // ignore: cast_nullable_to_non_nullable
as String,chainType: null == chainType ? _self.chainType : chainType // ignore: cast_nullable_to_non_nullable
as String,rawBalance: null == rawBalance ? _self.rawBalance : rawBalance // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,chainLogo: null == chainLogo ? _self.chainLogo : chainLogo // ignore: cast_nullable_to_non_nullable
as String,tokenAddress: null == tokenAddress ? _self.tokenAddress : tokenAddress // ignore: cast_nullable_to_non_nullable
as String,tokenAvatar: null == tokenAvatar ? _self.tokenAvatar : tokenAvatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
