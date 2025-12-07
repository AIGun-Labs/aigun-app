import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_entity.freezed.dart';

/// Chain Entity
///
/// Represents blockchain chain information for tokens
@freezed
sealed class ChainEntity with _$ChainEntity {
  const ChainEntity._();

  const factory ChainEntity({
    String? name,
    String? id,
    String? address,
    String? logo,
    String? slug,
    String? networkId,
  }) = _ChainEntity;

  /// Check if logo is available
  bool get hasLogo => logo != null && logo!.isNotEmpty;

  /// Check if this is a valid chain
  bool get isValid => id != null && id!.isNotEmpty;
}
