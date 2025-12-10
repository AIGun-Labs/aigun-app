import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'option_tab_model.g.dart';

@JsonSerializable()
class OptionTabModel {
  @JsonKey(name: 'intel_tab', defaultValue: [])
  final List<OptionTabItemModel> intelTab;

  @JsonKey(name: 'trending_tab', defaultValue: [])
  final List<OptionTabItemModel> trendingTab;

  const OptionTabModel({required this.intelTab, required this.trendingTab});

  factory OptionTabModel.fromJson(Map<String, dynamic> json) =>
      _$OptionTabModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionTabModelToJson(this);
}

@JsonSerializable()
class OptionTabItemModel {
  final String id;
  final MultilingualModel name;
  final String url;
  final String type;
  final List<OptionTabItemModel>? children;
  final int? layer;
  final MultilingualModel? adorn;
  final OptionTabItemExtraModel? extra;
  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  const OptionTabItemModel({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    this.children,
    this.layer,
    this.adorn,
    this.extra,
    this.sortOrder,
  });

  factory OptionTabItemModel.fromJson(Map<String, dynamic> json) =>
      _$OptionTabItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionTabItemModelToJson(this);
}

@JsonSerializable()
class OptionTabItemExtraModel {
  @JsonKey(name: 'push_filter')
  final String? pushFilter;

  @JsonKey(name: 'is_tracking')
  final bool? isTracking;
  const OptionTabItemExtraModel({this.pushFilter, this.isTracking});

  factory OptionTabItemExtraModel.fromJson(Map<String, dynamic> json) =>
      _$OptionTabItemExtraModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionTabItemExtraModelToJson(this);
}
