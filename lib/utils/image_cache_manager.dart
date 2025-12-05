import 'package:flutter/painting.dart';

class ImageCacheManager {
  static void configureCache() {
    PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20; // 500MB

    PaintingBinding.instance.imageCache.maximumSize = 1000;
  }
}
