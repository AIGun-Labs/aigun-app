import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../utils/image_utils.dart';
import '../../../widgets/feature_image.dart';

class GridImagePreviewWrapper extends StatelessWidget {
  const GridImagePreviewWrapper({
    super.key,
    required this.urls,
    required this.onTap,
    this.uniquePrefix = '',
  });

  final List<String> urls;
  final void Function(int index) onTap;
  final String uniquePrefix;

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        // 8.verticalSpace,
        GridImagePreview(urls: urls, onTap: onTap, prefix: uniquePrefix),
        8.verticalSpace,
      ],
    );
  }
}

class GridImagePreview extends StatelessWidget {
  const GridImagePreview({
    super.key,
    required this.urls,
    required this.onTap,
    required this.prefix,
  });
  final List<String> urls;
  final void Function(int index) onTap;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final itemWidth = (maxWidth - 8) / 2;
        final itemHeight = itemWidth;
        final itemGridWidth = (maxWidth - 8) / 3;
        final itemGridHeight = itemGridWidth;
        final count = urls.length;

        final child = switch (count) {
          1 => ImagePreviewItem(
            url: urls[0],
            index: 0,
            onTap: onTap,
            width: itemGridWidth * 2,
            height: itemGridHeight,
            prefix: prefix,
          ),
          2 => ImageGrid(
            urls: urls,
            onTap: onTap,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            crossAxisCount: 2,
            prefix: prefix,
          ),
          3 => ImageGrid(
            urls: urls,
            onTap: onTap,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            prefix: prefix,
          ),
          4 => ImageFourItemGrid(urls: urls, onTap: onTap, prefix: prefix),
          _ => ImageGrid(
            urls: urls,
            onTap: onTap,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            prefix: prefix,
          ),
        };

        return Column(children: [8.verticalSpace, child, 8.verticalSpace]);
      },
    );
  }
}

class ImagePreviewItem extends StatelessWidget {
  const ImagePreviewItem({
    super.key,
    required this.url,
    required this.index,
    required this.onTap,
    this.width,
    this.height,
    required this.prefix,
  });
  final String url;
  final double? width;
  final double? height;
  final int index;
  final void Function(int index) onTap;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: RepaintBoundary(
        child: Hero(
          tag: '${prefix}_image_preview_item_${url}_$index',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: FeatureImage(
              width: width,
              height: width,
              url: ImageUtils.getImageProxyUrl(url),
              fit: BoxFit.cover,
              errorWidget: SizedBox.shrink(),
              loadingWidget: Container(
                width: width,
                height: width,
                color: AppColors.card(context),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    this.crossAxisCount = 3,
    required this.urls,
    required this.onTap,
    required this.itemWidth,
    required this.itemHeight,
    required this.prefix,
  });

  final int crossAxisCount;
  final List<String> urls;
  final void Function(int index) onTap;
  final double itemWidth;
  final double itemHeight;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(
        urls.length,
        (index) => ImagePreviewItem(
          url: urls[index],
          index: index,
          onTap: onTap,
          width: itemWidth,
          height: itemHeight,
          prefix: prefix,
        ),
      ),
    );
  }
}

class ImageFourItemGrid extends StatelessWidget {
  const ImageFourItemGrid({
    super.key,
    required this.urls,
    required this.onTap,
    required this.prefix,
  });
  final List<String> urls;
  final void Function(int index) onTap;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ImagePreviewItem(
                  url: urls[0],
                  index: 0,
                  onTap: onTap,
                  prefix: prefix,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ImagePreviewItem(
                  url: urls[1],
                  index: 1,
                  onTap: onTap,
                  prefix: prefix,
                ),
              ),
            ),
            8.horizontalSpace,
            const Expanded(child: SizedBox()), // 空占位
          ],
        ),

        8.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ImagePreviewItem(
                  url: urls[2],
                  index: 2,
                  onTap: onTap,
                  prefix: prefix,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ImagePreviewItem(
                  url: urls[3],
                  index: 3,
                  onTap: onTap,
                  prefix: prefix,
                ),
              ),
            ),
            8.horizontalSpace,
            const Expanded(child: SizedBox()), // 空占位
          ],
        ),
      ],
    );
  }
}
