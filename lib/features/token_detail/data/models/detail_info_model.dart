import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'detail_info_model.freezed.dart';
part 'detail_info_model.g.dart';

@Freezed()
sealed class DetailInfoModel with _$DetailInfoModel {
  const factory DetailInfoModel({
    @Default('') String name,
    @Default('') String symbol,
    @Default('') String logo,
    @JsonKey(name: 'contract_address') @Default('') String contractAddress,
    @Default('') String network,
    @JsonKey(name: 'chain_logo') @Default('') String chainLogo,
    @JsonKey(name: 'price_usd') @Default('') String priceUsd,
    @JsonKey(name: 'market_cap') @Default('') String marketCap,
    @JsonKey(name: 'liquidity') @Default('') String liquidity,
    @JsonKey(name: 'volume_24h') @Default('') String volume24h,
    @JsonKey(name: 'holders') @Default('') String holders,
    @JsonKey(name: 'price_change_24h') @Default('') String priceChange24h,
    @JsonKey(name: 'is_native') @Default(false) bool isNative,
    @JsonKey(name: 'is_mainstream') @Default(false) bool isMainStream,
    @JsonKey(name: 'narrative') MultilingualModel? narrative,
    @JsonKey(name: 'highest_increase_rate')
    @Default('0.0')
    String highestIncreaseRate,
  }) = _DetailInfoModel;

  factory DetailInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DetailInfoModelFromJson(json);
}
