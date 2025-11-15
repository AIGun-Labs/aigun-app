import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/monitor/index.dart';

part 'monitor_state.freezed.dart';

@freezed
class MonitorState with _$MonitorState {
  const factory MonitorState.initial() = _Initial;
  const factory MonitorState.loading() = _Loading;
  const factory MonitorState.loaded({
    required Monitor monitors,
  }) = _Loaded;
  const factory MonitorState.error({required String message}) = _Error;
}
