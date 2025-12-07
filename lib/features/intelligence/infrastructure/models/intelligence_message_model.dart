import 'package:freezed_annotation/freezed_annotation.dart';

import 'intelligence_model.dart';

part 'intelligence_message_model.freezed.dart';
part 'intelligence_message_model.g.dart';

@freezed
sealed class IntelligenceMessageModel with _$IntelligenceMessageModel {
  const factory IntelligenceMessageModel({
    String? type,
    IntelligenceModel? data,
  }) = _IntelligenceMessageModel;

  factory IntelligenceMessageModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceMessageModelFromJson(json);
}
