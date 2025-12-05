import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image.dart';
import 'image_viewer.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;
  final double? width;
  final double? height;
  final double spacing;
  final BorderRadius? borderRadius;

  const ImageGrid({
    super.key,
    required this.imageUrls,
    this.width,
    this.height,
    this.spacing = 4,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = width ?? constraints.maxWidth;
        final itemWidth = (maxWidth - spacing) / 2;
        final itemHeight = height ?? itemWidth;

        switch (imageUrls.length) {
          case 1:
            return SizedBox(
              width: maxWidth,
              height: itemHeight * 2,
              child: GestureDetector(
                onTap: () => _showFullScreenImage(context, 0),
                child: ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.circular(8.r),
                  child: CachedImage(
                    imageUrl: imageUrls[0],
                    width: maxWidth,
                    height: itemHeight * 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          case 2:
            return SizedBox(
              width: maxWidth,
              height: itemHeight,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showFullScreenImage(context, 0),
                      child: Padding(
                        padding: EdgeInsets.only(right: spacing / 2),
                        child: ClipRRect(
                          borderRadius:
                              borderRadius ?? BorderRadius.circular(8.r),
                          child: CachedImage(
                            imageUrl: imageUrls[0],
                            width: itemWidth,
                            height: itemHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showFullScreenImage(context, 1),
                      child: Padding(
                        padding: EdgeInsets.only(left: spacing / 2),
                        child: ClipRRect(
                          borderRadius:
                              borderRadius ?? BorderRadius.circular(8.r),
                          child: CachedImage(
                            imageUrl: imageUrls[1],
                            width: itemWidth,
                            height: itemHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case 3:
            return SizedBox(
              width: maxWidth,
              height: itemHeight * 2 + spacing,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showFullScreenImage(context, 0),
                      child: Padding(
                        padding: EdgeInsets.only(right: spacing / 2),
                        child: ClipRRect(
                          borderRadius:
                              borderRadius ?? BorderRadius.circular(8.r),
                          child: CachedImage(
                            imageUrl: imageUrls[0],
                            width: itemWidth,
                            height: itemHeight * 2 + spacing,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showFullScreenImage(context, 1),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: spacing / 2,
                                bottom: spacing / 2,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    borderRadius ?? BorderRadius.circular(8.r),
                                child: CachedImage(
                                  imageUrl: imageUrls[1],
                                  width: itemWidth,
                                  height: itemHeight,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showFullScreenImage(context, 2),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: spacing / 2,
                                top: spacing / 2,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    borderRadius ?? BorderRadius.circular(8.r),
                                child: CachedImage(
                                  imageUrl: imageUrls[2],
                                  width: itemWidth,
                                  height: itemHeight,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          default:
            final rows = (imageUrls.length / 2).ceil();
            return SizedBox(
              width: maxWidth,
              height: itemHeight * rows + (spacing * (rows - 1)),
              child: Column(
                children: List.generate(rows, (rowIndex) {
                  final startIndex = rowIndex * 2;
                  final endIndex = (startIndex + 2).clamp(0, imageUrls.length);
                  final rowImages = imageUrls.sublist(startIndex, endIndex);

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: rowIndex < rows - 1 ? spacing : 0,
                    ),
                    child: Row(
                      children: List.generate(
                        rowImages.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            right: index < rowImages.length - 1 ? spacing : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => _showFullScreenImage(
                              context,
                              startIndex + index,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  borderRadius ?? BorderRadius.circular(8.r),
                              child: CachedImage(
                                imageUrl: rowImages[index],
                                width: itemWidth,
                                height: itemHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
        }
      },
    );
  }

  void _showFullScreenImage(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ImageViewerScreen(imageUrls: imageUrls, initialIndex: initialIndex),
      ),
    );
  }
}
