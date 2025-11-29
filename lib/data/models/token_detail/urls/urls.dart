import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls.freezed.dart';
part 'urls.g.dart';

@freezed
sealed class TokenDetailUrls with _$TokenDetailUrls {
  const factory TokenDetailUrls({
    @JsonKey(name: 'discord') String? discord,
    @JsonKey(name: 'website') String? website,
    @JsonKey(name: 'github') String? github,
    @JsonKey(name: 'x') String? x,
    @JsonKey(name: 'whitepaper') String? whitepaper,
    @JsonKey(name: 'reddit') String? reddit,
    @JsonKey(name: 'telegram') String? telegram,
  }) = _TokenDetailUrls;

  factory TokenDetailUrls.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailUrlsFromJson(json);
}
