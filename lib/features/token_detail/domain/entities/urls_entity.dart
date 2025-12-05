import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls_entity.freezed.dart';

@freezed
class UrlsEntity with _$UrlsEntity {
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

  const UrlsEntity({
    required this.discord,
    required this.website,
    required this.github,
    required this.x,
    required this.whitepaper,
    required this.reddit,
    required this.telegram,
  });
}
