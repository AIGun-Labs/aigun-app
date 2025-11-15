import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';

part 'top_token_model.freezed.dart';
part 'top_token_model.g.dart';

@freezed
class TopTokenModel with _$TopTokenModel {
  @JsonSerializable(checked: true)
  const factory TopTokenModel({
    @Default('') required String id,
    @JsonKey(name: 'chain_id', defaultValue: '') required String chainId,
    @Default('') required String network,
    @JsonKey(name: 'contract_address', defaultValue: '')
    required String contractAddress,
    @Default(0) required int decimals,
    @Default('') required String name,
    @Default('') required String symbol,
    @Default('') required String logo,
    @Default('') required String type,
    @JsonKey(name: 'volume_24h', defaultValue: 0.0) required double volume24h,
    @JsonKey(name: 'market_cap', defaultValue: 0.0) required double marketCap,
    @JsonKey(name: 'price_usd', defaultValue: 0.0) required double priceUsd,
    @JsonKey(name: 'is_verified', defaultValue: false) required bool isVerified,
    @Default('') required String description,
    @JsonKey(name: 'price_change_24h', defaultValue: 0.0)
    required double priceChange24h,
    @Default('') required String standard,
    @JsonKey(name: 'liquidity', defaultValue: 0.0) required double liquidity,
    @JsonKey(name: 'display_time')
    @NaiveToUtcDateTimeConverter()
    required DateTime displayTime,
    @JsonKey(name: 'is_native', defaultValue: false) required bool isNative,
  }) = _TopTokenModel;

  factory TopTokenModel.fromJson(Map<String, dynamic> json) =>
      _$TopTokenModelFromJson(json);
}
