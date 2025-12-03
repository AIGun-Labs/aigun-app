import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls_model.freezed.dart';
part 'urls_model.g.dart';

@freezed
@JsonSerializable()
class UrlsModel with _$UrlsModel {
  @override
  final String? discord;
  @override
  final String? website;
  @override
  final String? github;
  @override
  final String? x;
  @override
  final String? whitepaper;
  @override
  final String? reddit;
  @override
  final String? telegram;

  const UrlsModel({
    this.discord,
    this.website,
    this.github,
    this.x,
    this.whitepaper,
    this.reddit,
    this.telegram,
  });

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);
}
