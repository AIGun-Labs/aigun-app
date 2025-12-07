import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_model.freezed.dart';
part 'chain_model.g.dart';

@freezed
sealed class IntelligenceChainModel with _$IntelligenceChainModel {
  const factory IntelligenceChainModel({
    String? name,
    String? id,
    String? address,
    String? logo,
    String? slug,
    @JsonKey(name: 'network_id') String? networkId,
  }) = _IntelligenceChainModel;

  factory IntelligenceChainModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceChainModelFromJson(json);
}
