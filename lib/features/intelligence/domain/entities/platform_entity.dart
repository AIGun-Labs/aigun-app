import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_entity.freezed.dart';

/// Platform Entity
///
/// Represents the platform where intelligence originates from
@freezed
sealed class PlatformEntity with _$PlatformEntity {
  const PlatformEntity._();

  const factory PlatformEntity({
    String? name,
    String? id,
    String? logo,
  }) = _PlatformEntity;

  /// Check if logo is available
  bool get hasLogo => logo != null && logo!.isNotEmpty;
}
