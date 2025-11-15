import 'package:freezed_annotation/freezed_annotation.dart';

import '../captcha/captcha.dart';
import '../sms/sms.dart';

part "challenge.freezed.dart";
part "challenge.g.dart";

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    @JsonKey(name: "captcha") Captcha? captcha,
    @JsonKey(name: "sms") Sms? sms,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);
}
