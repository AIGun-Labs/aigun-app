import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

/// Auth User Model - Data Transfer Object for user data
///
/// This model is used for JSON serialization/deserialization
/// when communicating with the backend API.
@freezed
sealed class AuthUserModel with _$AuthUserModel {
  @JsonSerializable(explicitToJson: true)
  const factory AuthUserModel({
    @JsonKey(name: 'pk') String? id,
    String? email,
    String? nickname,
    String? avatar,
    @JsonKey(name: 'invite_code') String? inviteCode,
    @JsonKey(name: 'created_at')
    @NaiveToUtcDateTimeConverter()
    DateTime? createdAt,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
