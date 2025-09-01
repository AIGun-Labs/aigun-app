import 'package:freezed_annotation/freezed_annotation.dart';

part 'intel.freezed.dart';
part 'intel.g.dart';

@freezed
class IntelMessageData with _$IntelMessageData {
  const factory IntelMessageData({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'data') IntelGroup? data,
  }) = _IntelMessageData;

  factory IntelMessageData.fromJson(Map<String, dynamic> json) =>
      _$IntelMessageDataFromJson(json);
}

@freezed
class IntelGroup with _$IntelGroup {
  const factory IntelGroup({
    @JsonKey(name: 'group_id') required String? groupId,
    @JsonKey(name: 'group_name') String? groupName,
    @JsonKey(name: 'message') IntelMessage? message,
  }) = _IntelGroup;

  factory IntelGroup.fromJson(Map<String, dynamic> json) =>
      _$IntelGroupFromJson(json);
}

@freezed
class HistoryData with _$HistoryData {
  const factory HistoryData({
    @JsonKey(name: 'records') List<IntelMessage>? records,
    @JsonKey(name: 'last_create_at') int? lastCreateAt,
    @JsonKey(name: 'last_id') String? lastId,
  }) = _HistoryData;

  factory HistoryData.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataFromJson(json);
}

@freezed
class IntelMessage with _$IntelMessage {
  const factory IntelMessage({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'name') String? name, // 推文作者
    @JsonKey(name: 'timestamp') int? timestamp, // 推文发送时间
    @JsonKey(name: "create_at") int? createdAt, // 消息推送时间
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'content') String? content, // 推文内容
    @JsonKey(name: 'origin') String? origin, // 推文源链接
    @JsonKey(name: 'analyze') String? analyze,
    @JsonKey(name: 'entities') List<IntelEntity>? entities,
    @JsonKey(name: 'user') IntelUser? user, // 推文作者信息
    @JsonKey(name: "medias") List<IntelMedia>? medias,
    // @JsonKey(name: 'tags') List<IntelTag>? tags,
  }) = _IntelMessage;

  factory IntelMessage.fromJson(Map<String, dynamic> json) =>
      _$IntelMessageFromJson(json);
}

@freezed
class IntelMedia with _$IntelMedia {
  const factory IntelMedia({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'data') String? data,
  }) = _IntelMedia;

  factory IntelMedia.fromJson(Map<String, dynamic> json) =>
      _$IntelMediaFromJson(json);
}

@freezed
class IntelEntity with _$IntelEntity {
  const factory IntelEntity({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'network') String? network,
    @JsonKey(name: 'address') String? address,
  }) = _IntelEntity;

  factory IntelEntity.fromJson(Map<String, dynamic> json) =>
      _$IntelEntityFromJson(json);
}

@freezed
class IntelUser with _$IntelUser {
  const factory IntelUser({
    @JsonKey(name: 'name') required String? name,
    @JsonKey(name: 'avator') String? avator,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'screen_name') String? screenName,
  }) = _IntelUser;

  factory IntelUser.fromJson(Map<String, dynamic> json) =>
      _$IntelUserFromJson(json);
}
