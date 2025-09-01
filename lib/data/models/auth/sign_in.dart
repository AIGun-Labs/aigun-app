import 'package:flutter_aigun/data/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "sign_in.freezed.dart";
part "sign_in.g.dart";

@freezed
class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    @JsonKey(name: "user") User? user,
    @JsonKey(name: "access_token", defaultValue: "") String? accessToken,
    @JsonKey(name: "refresh_token", defaultValue: "") String? refreshToken,
  }) = _SignInResponse;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);
}
