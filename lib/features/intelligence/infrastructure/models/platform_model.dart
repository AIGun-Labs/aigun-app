import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_model.freezed.dart';
part 'platform_model.g.dart';

@freezed
sealed class IntelligencePlatformModel with _$IntelligencePlatformModel {
  const factory IntelligencePlatformModel({
    String? name,
    String? id,
    String? logo,
  }) = _IntelligencePlatformModel;

  factory IntelligencePlatformModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligencePlatformModelFromJson(json);
}
