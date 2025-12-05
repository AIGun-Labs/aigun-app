import '../../domain/entities/realtime_entity.dart';
import '../models/realtime_model.dart';

extension RealtimeMapper on RealtimeModel {
  RealtimeEntity toEntity() {
    return RealtimeEntity(
      network: network,
      contractAddress: contractAddress,
      priceUsd: priceUsd,
      marketCap: marketCap,
      liquidity: liquidity,
      holders: holders,
      highestPriceUsd: highestPriceUsd,
      priceChange24h: priceChange24h,
    );
  }
}
