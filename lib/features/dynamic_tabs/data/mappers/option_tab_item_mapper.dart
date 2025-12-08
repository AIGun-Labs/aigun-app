import '../../domain/entities/option_tab_entity.dart';
import '../models/option_tab_model.dart';
import 'option_tab_item_extra_mapper.dart';

extension OptionTabItemMapper on OptionTabItemModel {
  OptionTabItemEntity toEntity() {
    return OptionTabItemEntity(
      id: id,
      name: name,
      url: url,
      type: type,
      children: children?.map((e) => e.toEntity()).toList(),
      layer: layer,
      adorn: adorn,
      extra: extra?.toEntity(),
    );
  }
}
