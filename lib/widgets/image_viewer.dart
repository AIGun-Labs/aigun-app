import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import '../utils/image_utils.dart';
import '../utils/logger.dart';
import 'feature_image.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.uniquePrefix,
  });
  final List<String> imageUrls;
  final int initialIndex;
  final String uniquePrefix;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: AppColors.foreground(context),
              size: 28.sp,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          10.horizontalSpace,
        ],
        title: widget.imageUrls.length > 1
            ? Text(
                '${_currentIndex + 1}/${widget.imageUrls.length}',
                style: TextStyle(color: AppColors.foreground(context)),
              )
            : null,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final url = widget.imageUrls[index];
              Logger.info(
                '${widget.uniquePrefix}_image_preview_item_${url}_$index',
              );
              Logger.info(
                '${widget.uniquePrefix}_image_preview_item_${url}_$index',
              );
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: RepaintBoundary(
                    child: Hero(
                      tag: '${widget.uniquePrefix}_image_preview_item_${url}_$index',
                      child: FeatureImage(
                        url: ImageUtils.getImageProxyUrl(url),
                        errorWidget: ColoredBox(
                          color: AppColors.card(context),
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                        loadingWidget: ColoredBox(
                          color: AppColors.card(context),
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: 20.h + bottomPadding,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageUrls.length,
                  (index) => Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppColors.foreground(context)
                          : AppColors.foreground(
                              context,
                            ).withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
