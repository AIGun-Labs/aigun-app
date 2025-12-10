import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/naive_to_utc_date_time_converter.dart';

part 'list_token_model.g.dart';

@JsonSerializable()
class ListTokenModel {
  final String id;

  @JsonKey(name: 'chain_id')
  final String chainId;

  @JsonKey(name: 'chain_logo')
  final String chainLogo;

  @JsonKey(name: 'network')
  final String network;

  @JsonKey(name: 'contract_address')
  final String contractAddress;

  @JsonKey(name: 'decimals')
  final int decimals;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'symbol')
  final String symbol;

  @JsonKey(name: 'logo')
  final String logo;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'volume_24h')
  final double volume24h;

  @JsonKey(name: 'market_cap')
  final double marketCap;

  @JsonKey(name: 'price_usd')
  final double priceUsd;

  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'price_change_24h')
  final double priceChange24h;

  @JsonKey(name: 'standard')
  final String? standard;

  @JsonKey(name: 'liquidity')
  final double liquidity;

  @JsonKey(name: 'display_time')
  @NaiveToUtcDateTimeConverter()
  final DateTime displayTime;

  const ListTokenModel({
    required this.id,
    required this.chainId,
    required this.chainLogo,
    required this.network,
    required this.contractAddress,
    required this.decimals,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.type,
    required this.volume24h,
    required this.marketCap,
    required this.priceUsd,
    required this.isVerified,
    required this.description,
    required this.priceChange24h,
    required this.standard,
    required this.liquidity,
    required this.displayTime,
  });

  factory ListTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ListTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListTokenModelToJson(this);
}
