import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/mixins/multilingual_content.dart';

part 'analyzed_model.freezed.dart';
part 'analyzed_model.g.dart';

// Analyzed data model
@freezed
sealed class IntelligenceAnalyzedModel
    with _$IntelligenceAnalyzedModel, IMultilingualContent {
  const IntelligenceAnalyzedModel._();

  const factory IntelligenceAnalyzedModel({String? zh, String? en}) =
      _IntelligenceAnalyzed;

  factory IntelligenceAnalyzedModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceAnalyzedFromJson(json);
}
