import '../../domain/entities/option_tab_entity.dart';
import '../models/option_tab_model.dart';
import 'option_tab_item_mapper.dart';

extension OptionTabMapper on OptionTabModel {
  OptionTabEntity toEntity() {
    return OptionTabEntity(
      intelTab: intelTab.map((e) => e.toEntity()).toList(),
      trendingTab: trendingTab.map((e) => e.toEntity()).toList(),
    );
  }
}
