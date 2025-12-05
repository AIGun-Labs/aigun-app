import 'package:json_annotation/json_annotation.dart';

part 'realtime_model.g.dart';

@JsonSerializable(explicitToJson: true, checked: true)
class RealtimeModel {
  final String network;
  final String contractAddress;
  final String priceUsd;
  final String marketCap;
  final String liquidity;
  final String holders;
  final String highestPriceUsd;
  final String priceChange24h;

  const RealtimeModel({
    required this.network,
    required this.contractAddress,
    required this.priceUsd,
    required this.marketCap,
    required this.liquidity,
    required this.holders,
    required this.highestPriceUsd,
    required this.priceChange24h,
  });

  factory RealtimeModel.fromJson(Map<String, dynamic> json) =>
      _$RealtimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeModelToJson(this);
}
