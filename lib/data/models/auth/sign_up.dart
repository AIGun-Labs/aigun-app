import 'package:freezed_annotation/freezed_annotation.dart';

import '../index.dart';

part 'sign_up.freezed.dart';
part 'sign_up.g.dart';

@freezed
sealed class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    @JsonKey(name: 'user') User? user,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}
