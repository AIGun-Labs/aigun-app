import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../core/enums/media.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/language_utils.dart';
import '../../../../utils/url.dart';
import '../content_expandable.dart';
import '../intel_item/intel_header.dart';
import '../intel_item/intel_message.dart';
import '../intel_item/intel_resources_grid.dart';
import '../intel_player_list.dart';
import '../original/twitter.dart';
import '../token_list.dart';
import 'base.dart';

class IntellgenceTwitter extends StatefulWidget {
  const IntellgenceTwitter({super.key, required this.intel, this.index = 0});

  final Intel intel;
  final int index;

  @override
  State<IntellgenceTwitter> createState() => _IntellgenceTwitterState();
}

class _IntellgenceTwitterState extends State<IntellgenceTwitter> {
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final analyzedText = LanguageUtils.getAnalyzedText(
      context,
      widget.intel.analyzed,
    );
    final newText = _isAlphaText(analyzedText);
    return IntellgenceBase(
      intel: widget.intel,
      index: widget.index,
      header: IntelHeader(
        onShare: () async {},
        createAt: widget.intel.createdAtLocal(context),
        aiAgent: widget.intel.aiAgent,
        author: widget.intel.author,
      ),
      tokenList: IntelTokenList(tokens: widget.intel.entities),
      original: OriginalTwitter(
        intel: widget.intel,
        onTap: () async {
          if (widget.intel.sourceUrl != null) {
            await launchUrl(widget.intel.sourceUrl ?? '');
          }
        },
        headline: widget.intel.title,
        time: widget.intel.publishedAtLocal(context),
        avatar: widget.intel.author?.avatar,
        summary: widget.intel.author?.prompt,
        platformLogo: widget.intel.author?.platform?.logo,
      ),
      playerList: IntelPlayerList(
        medias: _getMediasByType(widget.intel.medias, MediaType.video),
      ),
      resourcesGrid: IntelResourcesGrid(
        medias: _getMediasByType(widget.intel.medias, MediaType.image),
        onTap: (medias, index) => _openImagePreview(medias, index),
        uniquePrefix: 'intel_${widget.intel.id}',
      ),
      messageInfo: IntelMessageInfo(
        analyzedTime: widget.intel.analyzedTime,
        monitorTime: widget.intel.monitorTime,
      ),
      markdown: newText.isEmpty ? null : ExpandableContent(content: newText),
    );
  }

  String _isAlphaText(String analyzed) {
    if (widget.intel.extraDatas?.isAlpha == false) {
      return analyzed;
    }

    final tokenKeys = widget.intel.tokenKeys ?? [];

    final newTokenKeys = tokenKeys.isNotEmpty
        ? tokenKeys.join(',')
        : S.of(context).relatedToken;

    final newText = (widget.intel.entities?.length ?? 0) > 0
        ? analyzed
        : '$analyzed ${S.of(context).tokenNotTrading(newTokenKeys)}';

    return newText;
  }

  void _openImagePreview(List<IntelMedia> images, int initialIndex) {
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog.fullscreen(
          // backgroundColor: AppColors.background(context),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: images.length,
                builder: (context, index) {
                  final imageUrl = ImageUtils.getImageProxyUrl(
                    images[index].url,
                  );
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(imageUrl),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(
                  color: AppColors.background(context),
                ),
                pageController: PageController(initialPage: initialIndex),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),

              Positioned(
                top: 40.h,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.textSecondary(context),
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${currentIndex + 1} / ${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<IntelMedia> _getMediasByType(List<IntelMedia>? medias, MediaType type) {
    if (medias == null) return [];

    return medias.where((media) => media.type == type.value).toList();
  }
}
