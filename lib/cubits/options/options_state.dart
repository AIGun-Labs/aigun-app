import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/options/single_type/single_type.dart';
import '../../shared/presentation/widgets/multiple_choice.dart';

part 'options_state.freezed.dart';

@freezed
sealed class OptionsState with _$OptionsState {
  const OptionsState._();
  const factory OptionsState({List<SingleTypeOptions>? singleTypeOptions}) =
      _OptionsState;

  List<ChoiceItem> singleTypeChoices() {
    return singleTypeOptions
            ?.map((e) => ChoiceItem(label: e.name ?? '', value: e.slug ?? ''))
            .toList() ??
        [];
  }
}
