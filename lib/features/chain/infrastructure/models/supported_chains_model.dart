import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/value_object/network.dart';
import '../../domain/entities/support_chains_entity.dart';

part 'supported_chains_model.freezed.dart';
part 'supported_chains_model.g.dart';

@freezed
sealed class SupportChainsModel with _$SupportChainsModel {
  const SupportChainsModel._();
  const factory SupportChainsModel({
    @JsonKey(name: 'networks') required List<String> networks,
  }) = _SupportChainsModel;

  factory SupportChainsModel.fromJson(Map<String, dynamic> json) =>
      _$SupportChainsModelFromJson(json);

  SupportChainsEntity toEntity() => SupportChainsEntity(
    networks: networks.map((network) => ChainNetwork(network)).toList(),
  );
}
