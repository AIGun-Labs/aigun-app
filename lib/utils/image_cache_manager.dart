import 'package:flutter/painting.dart';

class ImageCacheManager {
  // 配置内存缓存
  static void configureCache() {
    // 设置图片缓存的最大内存缓存大小（单位：字节）
    PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20; // 500MB
    // 设置最大缓存图片数量
    PaintingBinding.instance.imageCache.maximumSize = 1000;
  }
}
