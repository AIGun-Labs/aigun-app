import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_model.freezed.dart';
part 'stats_model.g.dart';

String? _stringFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num) return value.toString();
  return value.toString();
}

@freezed
sealed class IntelligenceStatsModel with _$IntelligenceStatsModel {
  const factory IntelligenceStatsModel({
    @JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic)
    String? warningPriceUsd,
    @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic)
    String? warningMarketCap,
    @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic)
    String? currentPriceUsd,
    @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic)
    String? currentMarketCap,
    @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic)
    String? increaseRate,
    @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic)
    String? heighestIncreaseRate,
    @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic)
    String? highestDecreaseRate,
  }) = _IntelligenceStatsModel;

  factory IntelligenceStatsModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceStatsModelFromJson(json);
}
