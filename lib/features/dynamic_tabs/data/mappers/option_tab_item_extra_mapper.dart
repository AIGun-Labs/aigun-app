import '../../domain/entities/option_tab_entity.dart';
import '../models/option_tab_model.dart';

extension OptionTabItemExtraMapper on OptionTabItemExtraModel {
  OptionTabItemExtraEntity toEntity() {
    return OptionTabItemExtraEntity(
      pushFilter: pushFilter,
      isTracking: isTracking,
    );
  }
}
