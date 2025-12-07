import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';
import '../../../../shared/utils/json_converter/multilingual.dart';
import 'platform_model.dart';

part 'author_model.freezed.dart';
part 'author_model.g.dart';

@freezed
sealed class IntelligenceAuthorModel with _$IntelligenceAuthorModel {
  const factory IntelligenceAuthorModel({
    String? avatar,
    String? slug,
    IntelligencePlatformModel? platform,
    @JsonKey(
      fromJson: multilingualStringFromJson,
      toJson: multilingualStringToJson,
    )
    @MultilingualStringConverter()
    Multilingual? prompt,
  }) = _IntelligenceAuthorModel;

  factory IntelligenceAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceAuthorModelFromJson(json);
}
