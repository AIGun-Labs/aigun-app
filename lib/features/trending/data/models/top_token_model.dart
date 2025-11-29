import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';

part 'top_token_model.freezed.dart';
part 'top_token_model.g.dart';

@freezed
sealed class TopTokenModel with _$TopTokenModel {
  @JsonSerializable(checked: true)
  const factory TopTokenModel({
    @Default('') String id,
    @JsonKey(name: 'chain_id') @Default('') String chainId,
    @JsonKey(name: 'chain_logo') @Default('') String chainLogo,
    @JsonKey(name: 'network') @Default('') String network,
    @JsonKey(name: 'contract_address') @Default('') String contractAddress,
    @Default(0) int decimals,
    @Default('') String name,
    @Default('') String symbol,
    @Default('') String logo,
    @Default('') String type,
    @JsonKey(name: 'volume_24h') @Default(0.0) double volume24h,
    @JsonKey(name: 'market_cap') @Default(0.0) double marketCap,
    @JsonKey(name: 'price_usd') @Default(0.0) double priceUsd,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @Default('') String description,
    @JsonKey(name: 'price_change_24h') @Default(0.0) double priceChange24h,
    @Default('') String standard,
    @JsonKey(name: 'liquidity') @Default(0.0) double liquidity,
    @JsonKey(name: 'display_time')
    @NaiveToUtcDateTimeConverter()
    required DateTime displayTime,
    @JsonKey(name: 'is_native') @Default(false) bool isNative,
  }) = _TopTokenModel;

  factory TopTokenModel.fromJson(Map<String, dynamic> json) =>
      _$TopTokenModelFromJson(json);
}
