// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
mixin _$Token {
  @JsonKey(name: "chain_id")
  String get chainId =>
      throw _privateConstructorUsedError; // @JsonKey(name: "chain_name") String chainName,
  @JsonKey(name: "chain_logo")
  String get chainLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_name")
  String get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "token_avatar")
  String get tokenAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: "token_name")
  String get tokenName => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: "token_price")
  String get tokenPrice => throw _privateConstructorUsedError;
  @JsonKey(name: "raw_balance")
  String get rawBalance => throw _privateConstructorUsedError;
  @JsonKey(name: "balance")
  String get balance => throw _privateConstructorUsedError;
  @JsonKey(name: "decimals")
  int get decimals => throw _privateConstructorUsedError;
  @JsonKey(name: "symbol")
  String get symbol => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: "price_change_24h")
  double? get priceChange24h => throw _privateConstructorUsedError;
  @JsonKey(name: "market_cap")
  double? get marketCap => throw _privateConstructorUsedError;
  @JsonKey(name: "network", readValue: _readNetworkOrSlug)
  String? get network => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String chainId,
      @JsonKey(name: "chain_logo") String chainLogo,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "token_avatar") String tokenAvatar,
      @JsonKey(name: "token_name") String tokenName,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "token_price") String tokenPrice,
      @JsonKey(name: "raw_balance") String rawBalance,
      @JsonKey(name: "balance") String balance,
      @JsonKey(name: "decimals") int decimals,
      @JsonKey(name: "symbol") String symbol,
      @JsonKey(name: 'slug', readValue: _readSlugOrNetwork) String? slug,
      @JsonKey(name: "price_change_24h") double? priceChange24h,
      @JsonKey(name: "market_cap") double? marketCap,
      @JsonKey(name: "network", readValue: _readNetworkOrSlug)
      String? network});
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainLogo = null,
    Object? chainName = null,
    Object? tokenAvatar = null,
    Object? tokenName = null,
    Object? address = null,
    Object? tokenPrice = null,
    Object? rawBalance = null,
    Object? balance = null,
    Object? decimals = null,
    Object? symbol = null,
    Object? slug = freezed,
    Object? priceChange24h = freezed,
    Object? marketCap = freezed,
    Object? network = freezed,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAvatar: null == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      tokenPrice: null == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as String,
      rawBalance: null == rawBalance
          ? _value.rawBalance
          : rawBalance // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      priceChange24h: freezed == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenImplCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$TokenImplCopyWith(
          _$TokenImpl value, $Res Function(_$TokenImpl) then) =
      __$$TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String chainId,
      @JsonKey(name: "chain_logo") String chainLogo,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "token_avatar") String tokenAvatar,
      @JsonKey(name: "token_name") String tokenName,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "token_price") String tokenPrice,
      @JsonKey(name: "raw_balance") String rawBalance,
      @JsonKey(name: "balance") String balance,
      @JsonKey(name: "decimals") int decimals,
      @JsonKey(name: "symbol") String symbol,
      @JsonKey(name: 'slug', readValue: _readSlugOrNetwork) String? slug,
      @JsonKey(name: "price_change_24h") double? priceChange24h,
      @JsonKey(name: "market_cap") double? marketCap,
      @JsonKey(name: "network", readValue: _readNetworkOrSlug)
      String? network});
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainLogo = null,
    Object? chainName = null,
    Object? tokenAvatar = null,
    Object? tokenName = null,
    Object? address = null,
    Object? tokenPrice = null,
    Object? rawBalance = null,
    Object? balance = null,
    Object? decimals = null,
    Object? symbol = null,
    Object? slug = freezed,
    Object? priceChange24h = freezed,
    Object? marketCap = freezed,
    Object? network = freezed,
  }) {
    return _then(_$TokenImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAvatar: null == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      tokenPrice: null == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as String,
      rawBalance: null == rawBalance
          ? _value.rawBalance
          : rawBalance // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      priceChange24h: freezed == priceChange24h
          ? _value.priceChange24h
          : priceChange24h // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenImpl implements _Token {
  const _$TokenImpl(
      {@JsonKey(name: "chain_id") required this.chainId,
      @JsonKey(name: "chain_logo") required this.chainLogo,
      @JsonKey(name: "chain_name") required this.chainName,
      @JsonKey(name: "token_avatar") required this.tokenAvatar,
      @JsonKey(name: "token_name") required this.tokenName,
      @JsonKey(name: "address") required this.address,
      @JsonKey(name: "token_price") required this.tokenPrice,
      @JsonKey(name: "raw_balance") required this.rawBalance,
      @JsonKey(name: "balance") required this.balance,
      @JsonKey(name: "decimals") required this.decimals,
      @JsonKey(name: "symbol") required this.symbol,
      @JsonKey(name: 'slug', readValue: _readSlugOrNetwork) this.slug = "",
      @JsonKey(name: "price_change_24h") this.priceChange24h = 0,
      @JsonKey(name: "market_cap") this.marketCap = 0.0,
      @JsonKey(name: "network", readValue: _readNetworkOrSlug)
      this.network = ""});

  factory _$TokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenImplFromJson(json);

  @override
  @JsonKey(name: "chain_id")
  final String chainId;
// @JsonKey(name: "chain_name") String chainName,
  @override
  @JsonKey(name: "chain_logo")
  final String chainLogo;
  @override
  @JsonKey(name: "chain_name")
  final String chainName;
  @override
  @JsonKey(name: "token_avatar")
  final String tokenAvatar;
  @override
  @JsonKey(name: "token_name")
  final String tokenName;
  @override
  @JsonKey(name: "address")
  final String address;
  @override
  @JsonKey(name: "token_price")
  final String tokenPrice;
  @override
  @JsonKey(name: "raw_balance")
  final String rawBalance;
  @override
  @JsonKey(name: "balance")
  final String balance;
  @override
  @JsonKey(name: "decimals")
  final int decimals;
  @override
  @JsonKey(name: "symbol")
  final String symbol;
  @override
  @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)
  final String? slug;
  @override
  @JsonKey(name: "price_change_24h")
  final double? priceChange24h;
  @override
  @JsonKey(name: "market_cap")
  final double? marketCap;
  @override
  @JsonKey(name: "network", readValue: _readNetworkOrSlug)
  final String? network;

  @override
  String toString() {
    return 'Token(chainId: $chainId, chainLogo: $chainLogo, chainName: $chainName, tokenAvatar: $tokenAvatar, tokenName: $tokenName, address: $address, tokenPrice: $tokenPrice, rawBalance: $rawBalance, balance: $balance, decimals: $decimals, symbol: $symbol, slug: $slug, priceChange24h: $priceChange24h, marketCap: $marketCap, network: $network)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.chainLogo, chainLogo) ||
                other.chainLogo == chainLogo) &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.tokenAvatar, tokenAvatar) ||
                other.tokenAvatar == tokenAvatar) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.tokenPrice, tokenPrice) ||
                other.tokenPrice == tokenPrice) &&
            (identical(other.rawBalance, rawBalance) ||
                other.rawBalance == rawBalance) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.priceChange24h, priceChange24h) ||
                other.priceChange24h == priceChange24h) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.network, network) || other.network == network));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chainId,
      chainLogo,
      chainName,
      tokenAvatar,
      tokenName,
      address,
      tokenPrice,
      rawBalance,
      balance,
      decimals,
      symbol,
      slug,
      priceChange24h,
      marketCap,
      network);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      __$$TokenImplCopyWithImpl<_$TokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenImplToJson(
      this,
    );
  }
}

abstract class _Token implements Token {
  const factory _Token(
      {@JsonKey(name: "chain_id") required final String chainId,
      @JsonKey(name: "chain_logo") required final String chainLogo,
      @JsonKey(name: "chain_name") required final String chainName,
      @JsonKey(name: "token_avatar") required final String tokenAvatar,
      @JsonKey(name: "token_name") required final String tokenName,
      @JsonKey(name: "address") required final String address,
      @JsonKey(name: "token_price") required final String tokenPrice,
      @JsonKey(name: "raw_balance") required final String rawBalance,
      @JsonKey(name: "balance") required final String balance,
      @JsonKey(name: "decimals") required final int decimals,
      @JsonKey(name: "symbol") required final String symbol,
      @JsonKey(name: 'slug', readValue: _readSlugOrNetwork) final String? slug,
      @JsonKey(name: "price_change_24h") final double? priceChange24h,
      @JsonKey(name: "market_cap") final double? marketCap,
      @JsonKey(name: "network", readValue: _readNetworkOrSlug)
      final String? network}) = _$TokenImpl;

  factory _Token.fromJson(Map<String, dynamic> json) = _$TokenImpl.fromJson;

  @override
  @JsonKey(name: "chain_id")
  String get chainId;
  @override // @JsonKey(name: "chain_name") String chainName,
  @JsonKey(name: "chain_logo")
  String get chainLogo;
  @override
  @JsonKey(name: "chain_name")
  String get chainName;
  @override
  @JsonKey(name: "token_avatar")
  String get tokenAvatar;
  @override
  @JsonKey(name: "token_name")
  String get tokenName;
  @override
  @JsonKey(name: "address")
  String get address;
  @override
  @JsonKey(name: "token_price")
  String get tokenPrice;
  @override
  @JsonKey(name: "raw_balance")
  String get rawBalance;
  @override
  @JsonKey(name: "balance")
  String get balance;
  @override
  @JsonKey(name: "decimals")
  int get decimals;
  @override
  @JsonKey(name: "symbol")
  String get symbol;
  @override
  @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)
  String? get slug;
  @override
  @JsonKey(name: "price_change_24h")
  double? get priceChange24h;
  @override
  @JsonKey(name: "market_cap")
  double? get marketCap;
  @override
  @JsonKey(name: "network", readValue: _readNetworkOrSlug)
  String? get network;
  @override
  @JsonKey(ignore: true)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
