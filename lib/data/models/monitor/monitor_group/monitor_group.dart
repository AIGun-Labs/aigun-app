import 'package:freezed_annotation/freezed_annotation.dart';

part 'monitor_group.freezed.dart';
part 'monitor_group.g.dart';

@freezed
sealed class MonitorGroup with _$MonitorGroup {
  const factory MonitorGroup({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'subscriptions_description') String? subDescription,
  }) = _MonitorGroup;

  factory MonitorGroup.fromJson(Map<String, dynamic> json) =>
      _$MonitorGroupFromJson(json);
}
