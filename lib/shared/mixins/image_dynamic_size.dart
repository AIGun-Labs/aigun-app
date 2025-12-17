import 'dart:async';

import 'package:flutter/material.dart';

// mixin ImageDynamicSizeMixin<T extends StatefulWidget> on State<T> {
mixin ImageDynamicSizeMixin on StatelessWidget {
  double? imageWidth;
  double? imageHeight;
  bool isLandscape = false;

  Future<void> loadImageDynamicSize(String imageUrl) async {
    final image = NetworkImage(imageUrl);
    final completer = Completer<void>();

    image
        .resolve(ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
            imageWidth = imageInfo.image.width.toDouble();
            imageHeight = imageInfo.image.height.toDouble();
            completer.complete();
          }),
        );
  }
}
