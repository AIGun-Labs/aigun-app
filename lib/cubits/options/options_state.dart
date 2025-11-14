import "package:flutter_aigun/data/models/options/single_type/single_type.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'options_state.freezed.dart';

@freezed
class OptionsState with _$OptionsState {
  const factory OptionsState({
    List<SingleTypeOptions>? singleTypeOptions,
  }) = _OptionsState;
}
