import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';
import 'platform_entity.dart';

part 'author_entity.freezed.dart';

/// Author Entity
///
/// Represents the author/source of intelligence
@freezed
sealed class AuthorEntity with _$AuthorEntity {
  const factory AuthorEntity({
    String? avatar,
    String? slug,
    PlatformEntity? platform,
    MultilingualModel? prompt,
  }) = _AuthorEntity;
  const AuthorEntity._();

  /// Check if avatar is available
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  /// Check if platform info is available
  bool get hasPlatform => platform != null;

  /// Get platform name
  String? get platformName => platform?.name;
}
