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
  int get chainId => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_name")
  String get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_type")
  String get chainType => throw _privateConstructorUsedError;
  @JsonKey(name: "token_address")
  String get tokenAddress => throw _privateConstructorUsedError;
  @JsonKey(name: "symbol")
  String get symbol => throw _privateConstructorUsedError;
  @JsonKey(name: "balance")
  String get balance => throw _privateConstructorUsedError;
  @JsonKey(name: "token_price")
  String get tokenPrice =>
      throw _privateConstructorUsedError; // @JsonKey(name: "is_risk_token") required bool isRiskToken,
  @JsonKey(name: "decimals")
  int get decimals => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_logo")
  String get chainLogo => throw _privateConstructorUsedError;

  /// Serializes this Token to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "token_address") String tokenAddress,
      @JsonKey(name: "symbol") String symbol,
      @JsonKey(name: "balance") String balance,
      @JsonKey(name: "token_price") String tokenPrice,
      @JsonKey(name: "decimals") int decimals,
      @JsonKey(name: "chain_logo") String chainLogo});
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainName = null,
    Object? chainType = null,
    Object? tokenAddress = null,
    Object? symbol = null,
    Object? balance = null,
    Object? tokenPrice = null,
    Object? decimals = null,
    Object? chainLogo = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      tokenPrice: null == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "token_address") String tokenAddress,
      @JsonKey(name: "symbol") String symbol,
      @JsonKey(name: "balance") String balance,
      @JsonKey(name: "token_price") String tokenPrice,
      @JsonKey(name: "decimals") int decimals,
      @JsonKey(name: "chain_logo") String chainLogo});
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainName = null,
    Object? chainType = null,
    Object? tokenAddress = null,
    Object? symbol = null,
    Object? balance = null,
    Object? tokenPrice = null,
    Object? decimals = null,
    Object? chainLogo = null,
  }) {
    return _then(_$TokenImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      tokenPrice: null == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      chainLogo: null == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenImpl implements _Token {
  const _$TokenImpl(
      {@JsonKey(name: "chain_id") required this.chainId,
      @JsonKey(name: "chain_name") required this.chainName,
      @JsonKey(name: "chain_type") required this.chainType,
      @JsonKey(name: "token_address") required this.tokenAddress,
      @JsonKey(name: "symbol") required this.symbol,
      @JsonKey(name: "balance") required this.balance,
      @JsonKey(name: "token_price") required this.tokenPrice,
      @JsonKey(name: "decimals") required this.decimals,
      @JsonKey(name: "chain_logo") required this.chainLogo});

  factory _$TokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenImplFromJson(json);

  @override
  @JsonKey(name: "chain_id")
  final int chainId;
  @override
  @JsonKey(name: "chain_name")
  final String chainName;
  @override
  @JsonKey(name: "chain_type")
  final String chainType;
  @override
  @JsonKey(name: "token_address")
  final String tokenAddress;
  @override
  @JsonKey(name: "symbol")
  final String symbol;
  @override
  @JsonKey(name: "balance")
  final String balance;
  @override
  @JsonKey(name: "token_price")
  final String tokenPrice;
// @JsonKey(name: "is_risk_token") required bool isRiskToken,
  @override
  @JsonKey(name: "decimals")
  final int decimals;
  @override
  @JsonKey(name: "chain_logo")
  final String chainLogo;

  @override
  String toString() {
    return 'Token(chainId: $chainId, chainName: $chainName, chainType: $chainType, tokenAddress: $tokenAddress, symbol: $symbol, balance: $balance, tokenPrice: $tokenPrice, decimals: $decimals, chainLogo: $chainLogo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.chainType, chainType) ||
                other.chainType == chainType) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.tokenPrice, tokenPrice) ||
                other.tokenPrice == tokenPrice) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.chainLogo, chainLogo) ||
                other.chainLogo == chainLogo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, chainName, chainType,
      tokenAddress, symbol, balance, tokenPrice, decimals, chainLogo);

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
          {@JsonKey(name: "chain_id") required final int chainId,
          @JsonKey(name: "chain_name") required final String chainName,
          @JsonKey(name: "chain_type") required final String chainType,
          @JsonKey(name: "token_address") required final String tokenAddress,
          @JsonKey(name: "symbol") required final String symbol,
          @JsonKey(name: "balance") required final String balance,
          @JsonKey(name: "token_price") required final String tokenPrice,
          @JsonKey(name: "decimals") required final int decimals,
          @JsonKey(name: "chain_logo") required final String chainLogo}) =
      _$TokenImpl;

  factory _Token.fromJson(Map<String, dynamic> json) = _$TokenImpl.fromJson;

  @override
  @JsonKey(name: "chain_id")
  int get chainId;
  @override
  @JsonKey(name: "chain_name")
  String get chainName;
  @override
  @JsonKey(name: "chain_type")
  String get chainType;
  @override
  @JsonKey(name: "token_address")
  String get tokenAddress;
  @override
  @JsonKey(name: "symbol")
  String get symbol;
  @override
  @JsonKey(name: "balance")
  String get balance;
  @override
  @JsonKey(name: "token_price")
  String
      get tokenPrice; // @JsonKey(name: "is_risk_token") required bool isRiskToken,
  @override
  @JsonKey(name: "decimals")
  int get decimals;
  @override
  @JsonKey(name: "chain_logo")
  String get chainLogo;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
