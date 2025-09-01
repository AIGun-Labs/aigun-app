import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/data/models/monitor/index.dart';

part 'monitor_group_state.freezed.dart';

@freezed
class MonitorGroupState with _$MonitorGroupState {
  const factory MonitorGroupState.initial() = _Initial;
  const factory MonitorGroupState.loading() = _Loading;
  const factory MonitorGroupState.loaded({
    required List<MonitorGroup> monitorGroupList,
  }) = _Loaded;
  const factory MonitorGroupState.error({required String message}) = _Error;
}
