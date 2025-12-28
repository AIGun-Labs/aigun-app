import 'package:flutter/material.dart';

import '../../widgets/image_viewer.dart';

mixin ImagePreviewMixin<T extends StatefulWidget> on State<T> {
  void openImagePreview(
    List<String> urls,
    int initialIndex,
    String uniquePrefix,
  ) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImageViewerScreen(
              imageUrls: urls,
              initialIndex: initialIndex,
              uniquePrefix: uniquePrefix,
            ),
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
