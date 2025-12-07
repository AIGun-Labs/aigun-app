import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_entity.freezed.dart';

/// Stats Entity
///
/// Represents price and market statistics for tokens
@freezed
sealed class StatsEntity with _$StatsEntity {
  const StatsEntity._();

  const factory StatsEntity({
    String? warningPriceUsd,
    String? warningMarketCap,
    String? currentPriceUsd,
    String? currentMarketCap,
    String? increaseRate,
    String? highestIncreaseRate,
    String? highestDecreaseRate,
  }) = _StatsEntity;

  /// Check if price data is available
  bool get hasPriceData => currentPriceUsd != null && currentPriceUsd!.isNotEmpty;

  /// Check if market cap data is available
  bool get hasMarketCapData => currentMarketCap != null && currentMarketCap!.isNotEmpty;

  /// Parse increase rate as double
  double? get increaseRateValue {
    if (increaseRate == null || increaseRate!.isEmpty) return null;
    return double.tryParse(increaseRate!);
  }

  /// Check if price is increasing
  bool get isIncreasing {
    final rate = increaseRateValue;
    return rate != null && rate > 0;
  }

  /// Check if price is decreasing
  bool get isDecreasing {
    final rate = increaseRateValue;
    return rate != null && rate < 0;
  }
}
