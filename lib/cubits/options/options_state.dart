import "package:flutter_aigun/data/models/options/single_type/single_type.dart";
import "package:flutter_aigun/shared/widgets/multiple_choice.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'options_state.freezed.dart';

@freezed
class OptionsState with _$OptionsState {
  const OptionsState._();
  const factory OptionsState({
    List<SingleTypeOptions>? singleTypeOptions,
  }) = _OptionsState;

  List<ChoiceItem> singleTypeChoices() {
    return singleTypeOptions
            ?.map((e) => ChoiceItem(label: e.name ?? '', value: e.slug ?? ''))
            .toList() ??
        [];
  }
}
