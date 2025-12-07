import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

@freezed
sealed class IntelligenceMediaModel with _$IntelligenceMediaModel {
  const factory IntelligenceMediaModel({
    String? url,
    @JsonKey(name: 'type') String? type,
  }) = _IntelligenceMediaModel;

  factory IntelligenceMediaModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceMediaModelFromJson(json);
}
