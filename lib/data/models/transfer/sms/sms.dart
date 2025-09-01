import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms.freezed.dart';
part 'sms.g.dart';

@freezed
class Sms with _$Sms {
  const factory Sms({
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "ttl") int? ttl,
    @JsonKey(name: "content") String? content,
  }) = _Sms;

  factory Sms.fromJson(Map<String, dynamic> json) => _$SmsFromJson(json);
}
