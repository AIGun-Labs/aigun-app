import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

/// Auth Response Model - Data Transfer Object for API responses
///
/// This model represents the response from authentication APIs
/// including verify-code and register endpoints.
@freezed
sealed class AuthResponseModel with _$AuthResponseModel {
  @JsonSerializable(explicitToJson: true)
  const factory AuthResponseModel({
    AuthUserModel? user,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
