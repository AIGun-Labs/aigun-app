import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/options/single_type/single_type.dart';
import '../../shared/domain/entities/choice_item_entity.dart';

part 'options_state.freezed.dart';

@freezed
sealed class OptionsState with _$OptionsState {
  const OptionsState._();
  const factory OptionsState({List<SingleTypeOptions>? singleTypeOptions}) =
      _OptionsState;

  List<ChoiceItemEntity> singleTypeChoices() {
    return singleTypeOptions
            ?.map(
              (e) => ChoiceItemEntity(
                name: NameType.text(e.name ?? ''),
                label: e.name ?? '',
                value: e.slug ?? '',
              ),
            )
            .toList() ??
        [];
  }
}
