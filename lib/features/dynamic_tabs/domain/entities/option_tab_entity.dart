import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'option_tab_entity.freezed.dart';

@Freezed()
class OptionTabEntity with _$OptionTabEntity {
  @override
  final List<OptionTabItemEntity> intelTab;

  @override
  final List<OptionTabItemEntity> trendingTab;

  const OptionTabEntity({required this.intelTab, required this.trendingTab});
}

@Freezed()
class OptionTabItemEntity with _$OptionTabItemEntity {
  @override
  final String id;

  @override
  final MultilingualModel name;

  @override
  final String url;

  @override
  final String type;

  @override
  final List<OptionTabItemEntity>? children;

  @override
  final int? layer;

  @override
  final MultilingualModel? adorn;

  @override
  final OptionTabItemExtraEntity? extra;

  const OptionTabItemEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    this.children,
    this.layer,
    this.adorn,
    this.extra,
  });
}

@Freezed()
class OptionTabItemExtraEntity with _$OptionTabItemExtraEntity {
  @override
  final String? pushFilter;
  const OptionTabItemExtraEntity({this.pushFilter});
}
