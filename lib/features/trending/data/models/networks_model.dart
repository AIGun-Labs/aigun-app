import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/networks_entity.dart';

part 'networks_model.freezed.dart';
part 'networks_model.g.dart';

@freezed
class NetworksModel with _$NetworksModel {
  const NetworksModel._();

  const factory NetworksModel({
    @Default({}) Map<String, String> networks,
  }) = _NetworksModel;

  factory NetworksModel.fromJson(Map<String, dynamic> json) =>
      _$NetworksModelFromJson(json);

  NetworksEntity toEntity() => NetworksEntity(networks: networks);
}
