import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/support_chains_entity.dart';
import '../../domain/value_objects/network.dart';

part 'supported_chains_state.freezed.dart';

@freezed
sealed class SupportedChainsStatus with _$SupportedChainsStatus {
  const SupportedChainsStatus._();
  const factory SupportedChainsStatus.initial() = _Initial;
  const factory SupportedChainsStatus.loading() = _Loading;
  const factory SupportedChainsStatus.success(SupportChainsEntity chains) =
      _Success;
  const factory SupportedChainsStatus.error(String message) = _Error;

  List<ChainNetwork> get networks =>
      maybeMap(success: (success) => success.chains.networks, orElse: () => []);
}
