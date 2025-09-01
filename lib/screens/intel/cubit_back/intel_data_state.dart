import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/intel_back/intel.dart';

part 'intel_data_state.freezed.dart';

@freezed
class IntelDataState with _$IntelDataState {
  const factory IntelDataState({
    @Default([]) List<IntelMessage> realtimeData,
    @Default([]) List<IntelMessage> pendingData,
    @Default('') String lastId,
    @Default(0) int lastCreateAt,
    @Default(false) bool isLoading,
    @Default(false) bool isConnected,
    @Default('') String errorMessage,
  }) = _IntelDataState;
}
