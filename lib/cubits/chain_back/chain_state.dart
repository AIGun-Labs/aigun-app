import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';

part 'chain_state.freezed.dart';

@freezed
class ChainState with _$ChainState {
  const factory ChainState({
    @Default([]) List<Chain> chains,
    @Default(false) bool isLoading,
    @Default('') String error,
  }) = _ChainState;

  factory ChainState.initial() => const ChainState();
}
