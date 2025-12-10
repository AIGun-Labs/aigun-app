import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/multilingual_model.dart';
import '../../extensions/multilingual_model_extension.dart';

part 'choice_item_entity.freezed.dart';

@freezed
sealed class NameType with _$NameType {
  /// 纯文本
  const factory NameType.text(String value) = NameText;

  /// 多语言文案
  const factory NameType.multilingual(MultilingualModel value) =
      NameMultilingual;
}

@Freezed()
class ChoiceItemEntity with _$ChoiceItemEntity {
  @override
  final NameType name;

  @override
  final String label;
  @override
  final String value;

  const ChoiceItemEntity({
    required this.name,
    required this.label,
    required this.value,
  });

  String nameStr(BuildContext context) {
    return name.when(
      text: (value) => value,
      multilingual: (value) => value.getByLocale(context),
    );
  }
}
