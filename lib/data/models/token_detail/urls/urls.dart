import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls.freezed.dart';
part 'urls.g.dart';

@freezed
class TokenDetailUrls with _$TokenDetailUrls {
  const factory TokenDetailUrls(
      {@JsonKey(name: "twitter") String? twitter,
      @JsonKey(name: "discord") String? discord,
      @JsonKey(name: "telegram") String? telegram}) = _TokenDetailUrls;

  factory TokenDetailUrls.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailUrlsFromJson(json);
}
