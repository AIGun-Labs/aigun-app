// import '    data/models/intel/intel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/intel/intel.dart';
import '../../data/models/options/single_type/single_type.dart';

part 'intel_state.freezed.dart';

@freezed
sealed class IntelState with _$IntelState {
  const factory IntelState({
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
    // @Default([]) List<String> unreadIds,
    @Default([]) List<Intel> unreadIntels,
    @Default([]) List<Intel> singleIntelligences,
    @Default(1) int singlePage,
    @Default(10) int singlePageSize,
    @Default('all') String singleId,
    @Default([]) List<Intel> eventIntelligences,
    @Default(false) bool isFetchingSingleMore,
    @Default(false) bool isNotSingleMore,
    @Default([]) List<SingleTypeOptions> singleTypeOptions,
    @Default(false) bool showUnreadBar,
    // @Default(false) bool isTop
    @Default(false) bool isTopped,
  }) = _IntelState;

  static const IntelState initial = IntelState();
}
