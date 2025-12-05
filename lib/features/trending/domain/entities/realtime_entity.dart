import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_entity.freezed.dart';

@Freezed()
class RealtimeEntity with _$RealtimeEntity {
  @override
  final String network;
  @override
  final String contractAddress;
  @override
  final String priceUsd;
  @override
  final String marketCap;
  @override
  final String liquidity;
  @override
  final String holders;
  @override
  final String highestPriceUsd;
  @override
  final String priceChange24h;

  const RealtimeEntity({
    required this.network,
    required this.contractAddress,
    required this.priceUsd,
    required this.marketCap,
    required this.liquidity,
    required this.holders,
    required this.highestPriceUsd,
    required this.priceChange24h,
  });
}
