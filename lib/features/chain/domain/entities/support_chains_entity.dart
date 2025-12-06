import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/network.dart';

part 'support_chains_entity.freezed.dart';

@freezed
sealed class SupportChainsEntity with _$SupportChainsEntity {
  const factory SupportChainsEntity({required List<ChainNetwork> networks}) =
      _SupportChainsEntity;
}
