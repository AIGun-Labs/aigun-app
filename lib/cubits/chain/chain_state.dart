import 'package:flutter_aigun/data/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_state.freezed.dart';

@freezed
class ChainStatus with _$ChainStatus {
  const factory ChainStatus.initial() = _Initial;
  const factory ChainStatus.loading() = _Loading;
  const factory ChainStatus.success(List<Chain> chains) = _Success;
  const factory ChainStatus.error(String message) = _Error;
}

@freezed
class ChainState with _$ChainState {
  const factory ChainState({
    @Default(ChainStatus.initial()) ChainStatus status,
    @Default([]) List<Chain> chains,
  }) = _ChainState;
}
