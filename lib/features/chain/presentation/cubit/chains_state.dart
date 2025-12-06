import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/value_objects/network.dart';

part 'chains_state.freezed.dart';

@freezed
sealed class ChainsState with _$ChainsState {
  const factory ChainsState({
    @Default([]) List<ChainNetwork> networks,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _ChainsState;
}
