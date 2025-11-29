import 'package:freezed_annotation/freezed_annotation.dart';

part 'hot_token_model.freezed.dart';
part 'hot_token_model.g.dart';

@freezed
sealed class HotTokenModel with _$HotTokenModel {
  @JsonSerializable(checked: true)
  const factory HotTokenModel({
    @Default('') String name,
    @Default('') String symbol,
    @Default('') String logoURL,
    @Default('') String marketCap,
    @Default('') String decimals,
    @Default('') String price,
    @Default('') String chainIndex,
    @Default('') String contractAddress,
    @Default('') String chainId,
    @Default('') String chainName,
    @Default('') String chainLogoURL,
    @Default('') String network,
    @Default('') String slug,
  }) = _HotTokenModel;

  factory HotTokenModel.fromJson(Map<String, dynamic> json) =>
      _$HotTokenModelFromJson(json);
}

@freezed
sealed class HotTokensModel with _$HotTokensModel {
  @JsonSerializable(checked: true)
  const factory HotTokensModel({@Default([]) List<HotTokenModel> tokens}) =
      _HotTokensModel;

  factory HotTokensModel.fromJson(Map<String, dynamic> json) =>
      _$HotTokensModelFromJson(json);
}
