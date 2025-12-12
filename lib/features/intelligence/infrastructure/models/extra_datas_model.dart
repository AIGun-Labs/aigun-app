import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_datas_model.freezed.dart';
part 'extra_datas_model.g.dart';

String? _repostContentFromJson(Map<String, dynamic>? repost) {
  if (repost == null) return null;
  return repost['content'] as String?;
}

@freezed
sealed class IntelligenceExtraDatasModel with _$IntelligenceExtraDatasModel {
  const factory IntelligenceExtraDatasModel({
    @Default(false) @JsonKey(name: 'is_alpha') bool? isAlpha,
    @JsonKey(name: 'repost', fromJson: _repostContentFromJson)
    String? repostContent,
  }) = _IntelligenceExtraDatasModel;

  factory IntelligenceExtraDatasModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceExtraDatasModelFromJson(json);
}
