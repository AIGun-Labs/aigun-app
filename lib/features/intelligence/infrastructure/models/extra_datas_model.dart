import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_datas_model.freezed.dart';
part 'extra_datas_model.g.dart';

@freezed
sealed class IntelligenceExtraDatasModel with _$IntelligenceExtraDatasModel {
  const factory IntelligenceExtraDatasModel({
    @Default(false) @JsonKey(name: 'is_alpha') bool? isAlpha,
  }) = _IntelligenceExtraDatasModel;

  factory IntelligenceExtraDatasModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceExtraDatasModelFromJson(json);
}
