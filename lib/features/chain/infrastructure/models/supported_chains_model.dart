import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_chains_model.freezed.dart';
part 'supported_chains_model.g.dart';

@freezed
sealed class SupportChainsModel with _$SupportChainsModel {
  const factory SupportChainsModel({
    @JsonKey(name: 'networks') required List<String> networks,
  }) = _SupportChainsModel;

  factory SupportChainsModel.fromJson(Map<String, dynamic> json) =>
      _$SupportChainsModelFromJson(json);
}
