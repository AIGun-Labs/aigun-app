import 'package:freezed_annotation/freezed_annotation.dart';

part 'captcha.freezed.dart';
part 'captcha.g.dart';

@freezed
sealed class Captcha with _$Captcha {
  const factory Captcha({
    @JsonKey(name: 'key') required String key,
    @JsonKey(name: 'master_image') required String masterImage,
    @JsonKey(name: 'thumb_image') required String thumbImage,
    // @JsonKey(name: "type") String? type,
  }) = _Captcha;

  factory Captcha.fromJson(Map<String, dynamic> json) =>
      _$CaptchaFromJson(json);
}
