import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_token_model.g.dart';

@JsonSerializable()
class TradeTokenModel {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;

  @JsonKey(name: 'chain_id', defaultValue: '')
  final String chainId;

  @JsonKey(name: 'chain_logo', defaultValue: '')
  final String chainLogo;

  @JsonKey(name: 'network', defaultValue: '')
  final String network;

  @JsonKey(name: 'contract_address', defaultValue: '')
  final String contractAddress;

  @JsonKey(name: 'decimals', defaultValue: 0)
  final int decimals;

  @JsonKey(name: 'chain_name', defaultValue: '')
  final String chainName;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'symbol', defaultValue: '')
  final String symbol;

  @JsonKey(name: 'logo', defaultValue: '')
  final String logo;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'volume_24h', defaultValue: '0')
  final String volume24h;

  @JsonKey(name: 'market_cap', defaultValue: '0')
  final String marketCap;

  @JsonKey(name: 'price_usd', defaultValue: '0')
  final String priceUsd;

  @JsonKey(name: 'is_verified')
  final bool? isVerified;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'price_change_24h', defaultValue: '')
  final String priceChange24h;

  @JsonKey(name: 'standard')
  final String? standard;

  @JsonKey(name: 'liquidity', defaultValue: '0')
  final String liquidity;

  @JsonKey(name: 'display_time')
  final DateTime? displayTime;

  @JsonKey(name: 'is_native', defaultValue: false)
  final bool isNative;

  @JsonKey(name: 'is_top', defaultValue: false)
  final bool? isTop;

  @JsonKey(name: 'balance', defaultValue: '')
  final String balance;

  @JsonKey(name: 'raw_balance', defaultValue: '')
  final String rawBalance;

  @JsonKey(name: 'balance_usd')
  final String? balanceUsd;

  const TradeTokenModel({
    required this.id,
    required this.chainId,
    required this.chainLogo,
    required this.chainName,
    required this.network,
    required this.logo,
    required this.name,
    required this.symbol,
    required this.contractAddress,
    required this.decimals,
    required this.isNative,
    required this.priceUsd,
    required this.priceChange24h,
    required this.marketCap,
    required this.liquidity,
    required this.volume24h,
    required this.rawBalance,
    required this.balance,
    this.balanceUsd,
    this.description,
    this.displayTime,
    this.isVerified,
    this.standard,
    this.type,
    this.isTop,
  });

  factory TradeTokenModel.fromJson(Map<String, dynamic> json) =>
      _$TradeTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TradeTokenModelToJson(this);
}
