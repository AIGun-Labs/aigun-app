import '../../domain/entities/option_tab_entity.dart';
import '../models/option_tab_model.dart';

extension OptionTabMapper on OptionTabModel {
  OptionTabEntity toEntity() {
    return OptionTabEntity(
      intelTab: intelTab.map((e) => e.toEntity()).toList(),
      trendingTab: trendingTab.map((e) => e.toEntity()).toList(),
    );
  }
}

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
      label: label,
      value: value,
    );
  }
}

extension OptionTabItemExtraMapper on OptionTabItemExtraModel {
  OptionTabItemExtraEntity toEntity() {
    return OptionTabItemExtraEntity(
      pushFilter: pushFilter,
      isTracking: isTracking,
      paginationConfig: paginationConfig?.toEntity(),
    );
  }
}

extension OptionTabItemExtraPaginationConfigMapper
    on OptionTabItemExtraPaginationConfigModel {
  OptionTabItemExtraPaginationConfigEntity toEntity() {
    return OptionTabItemExtraPaginationConfigEntity(
      type: type ?? '',
      field: cursorField ?? '',
    );
  }
}
