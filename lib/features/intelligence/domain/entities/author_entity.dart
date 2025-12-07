import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';
import 'platform_entity.dart';

part 'author_entity.freezed.dart';

/// Author Entity
///
/// Represents the author/source of intelligence
@freezed
sealed class AuthorEntity with _$AuthorEntity {
  const AuthorEntity._();

  const factory AuthorEntity({
    String? avatar,
    String? slug,
    PlatformEntity? platform,
    Multilingual? prompt,
  }) = _AuthorEntity;

  /// Check if avatar is available
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  /// Check if platform info is available
  bool get hasPlatform => platform != null;

  /// Get platform name
  String? get platformName => platform?.name;
}
