import 'package:flutter/material.dart';

import '../../widgets/image_viewer.dart';

/// 图片预览混合器
/// 用于在页面中打开图片预览
mixin ImagePreviewMixin<T extends StatefulWidget> on State<T> {
  void openImagePreview(List<String> urls, int initialIndex) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImageViewerScreen(imageUrls: urls, initialIndex: initialIndex),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return FadeTransition(opacity: fadeAnimation, child: child);
        },
      ),
    );
  }
}
