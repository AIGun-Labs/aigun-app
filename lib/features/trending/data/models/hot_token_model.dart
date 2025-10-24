import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/hot_token_entity.dart';

part 'hot_token_model.freezed.dart';
part 'hot_token_model.g.dart';

@freezed
class HotTokenModel with _$HotTokenModel {
  const HotTokenModel._();
  const factory HotTokenModel({
    @Default('') String? name,
    @Default('') String? symbol,
    @Default('') String? logoURL,
    @Default('') String? marketCap,
    @Default('') String? decimals,
    @Default('') String? price,
    @Default('') String? chainIndex,
    @Default('') String? contractAddress,
    @Default('') String? chainId,
    @Default('') String? chainName,
    @Default('') String? chainLogoURL,
    @Default('') String? network,
    @Default('') String? slug,
  }) = _HotTokenModel;

  factory HotTokenModel.fromJson(Map<String, dynamic> json) =>
      _$HotTokenModelFromJson(json);

  HotTokenEntity toEntity() => HotTokenEntity(
        name: name ?? '',
        symbol: symbol ?? '',
        logo: logoURL ?? '',
        marketCap: marketCap ?? '',
        decimals: decimals ?? '',
        price: price ?? '',
        contractAddress: contractAddress ?? '',
        chainId: chainId ?? '',
        chainName: chainName ?? '',
        chainLogo: chainLogoURL ?? '',
        network: network ?? '',
        slug: slug ?? '',
        chainIndex: chainIndex ?? '',
      );
}

@freezed
class HotTokensModel with _$HotTokensModel {
  const HotTokensModel._();
  const factory HotTokensModel({
    @Default([]) List<HotTokenModel> tokens,
  }) = _HotTokensModel;

  factory HotTokensModel.fromJson(Map<String, dynamic> json) =>
      _$HotTokensModelFromJson(json);
}
