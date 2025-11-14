// import '    data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intel_state.freezed.dart';

@freezed
class IntelState with _$IntelState {
  const factory IntelState(
      {
      // @Default([]) List<IntelMessage> realtimeData,
      // @Default([]) List<IntelMessage> pendingData,
      @Default([]) List<dynamic> realtimeData,
      @Default([]) List<dynamic> pendingData,
      @Default('') String lastId,
      @Default(0) int lastCreateAt,
      @Default(false) bool isLoading,
      @Default(false) bool isConnected,
      @Default('') String errorMessage,
      @Default([]) List<Intel>? allMessages,
      @Default([]) List<String> visibleIds,
      @Default(1) int eventPage,
      @Default(10) int eventPageSize,
      @Default(false) bool isFetchingMore,
      @Default(false) bool isNotMore,
      @Default([]) List<String> unreadIds,
      @Default([]) List<Intel> unreadIntels,
      @Default([]) List<Intel> singleIntelligences,
      @Default(1) int singlePage,
      @Default(10) int singlePageSize,
      @Default('') String singleId,
      @Default([]) List<Intel> eventIntelligences,

      // @Default(false) bool isTop
      @Default(false) bool isTopped}) = _IntelState;

  static const IntelState initial = IntelState();
}
