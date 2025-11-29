import 'package:freezed_annotation/freezed_annotation.dart';

part 'monitor.freezed.dart';
part 'monitor.g.dart';

@freezed
sealed class Monitor with _$Monitor {
  const factory Monitor({
    @JsonKey(name: 'subscriptions') List<MonitorListType>? monitorList,
    @JsonKey(name: 'total_count') int? totalCount,
  }) = _Monitor;

  factory Monitor.fromJson(Map<String, dynamic> json) =>
      _$MonitorFromJson(json);
}

@freezed
sealed class MonitorListType with _$MonitorListType {
  const factory MonitorListType({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'tags') List<MonitorTag>? tags,
    @JsonKey(name: 'not_tags') List<MonitorTag>? notTags,
    @JsonKey(name: 'subscriptions_description') String? description,
  }) = _MonitorListType;

  factory MonitorListType.fromJson(Map<String, dynamic> json) =>
      _$MonitorListTypeFromJson(json);
}

@freezed
sealed class MonitorTag with _$MonitorTag {
  const factory MonitorTag({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'meta') MonitorTagMeta? meta,
  }) = _MonitorTag;

  factory MonitorTag.fromJson(Map<String, dynamic> json) =>
      _$MonitorTagFromJson(json);
}

@freezed
sealed class MonitorTagMeta with _$MonitorTagMeta {
  const factory MonitorTagMeta({
    @JsonKey(name: 'description') String? description,
  }) = _MonitorTagMeta;

  factory MonitorTagMeta.fromJson(Map<String, dynamic> json) =>
      _$MonitorTagMetaFromJson(json);
}
