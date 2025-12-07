import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_entity.freezed.dart';

/// Media Entity
///
/// Represents media content (images, videos) in intelligence
@freezed
sealed class MediaEntity with _$MediaEntity {
  const MediaEntity._();

  const factory MediaEntity({
    String? url,
    @Default(MediaType.image) MediaType type,
  }) = _MediaEntity;

  /// Check if this is an image
  bool get isImage => type == MediaType.image;

  /// Check if this is a video
  bool get isVideo => type == MediaType.video;

  /// Check if URL is valid
  bool get hasValidUrl => url != null && url!.isNotEmpty;
}

/// Media Type enum
enum MediaType {
  image,
  video;

  /// Create from string value
  static MediaType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'video':
        return MediaType.video;
      case 'image':
      default:
        return MediaType.image;
    }
  }

  /// Convert to string value
  String get value {
    switch (this) {
      case MediaType.image:
        return 'image';
      case MediaType.video:
        return 'video';
    }
  }
}
