import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/media.dart';
import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/data/models/multilingual_model.dart';
import '../../../../shared/extensions/multilingual_model_extension.dart';
import '../../../../shared/mixins/image_preview.dart';
import '../../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../../shared/presentation/widgets/grid_image_preview.dart';
import '../../../../utils/sheet/sheet.dart';
import '../content_expandable.dart';
import '../intel_item/intel_header.dart';
import '../intel_item/intel_message.dart';
import '../original/twitter.dart';
import '../sheet/twitter.dart';
import '../token_list.dart';
import 'base.dart';

class IntelligenceTwitter extends StatefulWidget {
  const IntelligenceTwitter({
    super.key,
    required this.intel,
    this.index = 0,
    required this.uniquePrefix,
  });

  final Intel intel;
  final int index;
  final String uniquePrefix;

  @override
  State<IntelligenceTwitter> createState() => _IntelligenceTwitterState();
}

class _IntelligenceTwitterState extends State<IntelligenceTwitter>
    with ImagePreviewMixin<IntelligenceTwitter> {
  @override
  Widget build(BuildContext context) {
    final newText = _isAlphaText(widget.intel.analyzed.getByLocale(context));
    return IntelligenceBase(
      intel: widget.intel,
      index: widget.index,
      header: IntelHeader(
        onShare: () async {
          BlocProvider.of<SoundEffectCubit>(context).playGunLoad();
        },
        createAt: widget.intel.createdAtLocal(context),
        aiAgent: widget.intel.aiAgent,
        author: widget.intel.author,
      ),
      tokenList: IntelTokenList(tokens: widget.intel.entities),
      original: OriginalTwitter(
        intel: widget.intel,
        onTap: () async {
          if (widget.intel.sourceUrl != null) {
            ShowSheet.common(
              context,
              TwitterSheet(
                uniquePrefix: widget.uniquePrefix,
                sourceUrl: widget.intel.sourceUrl ?? '',
                avatar: widget.intel.author?.avatar ?? '',
                slug: widget.intel.author?.slug ?? '',
                platformLogo: widget.intel.author?.platform?.logo,
                time: widget.intel.publishedAt.fmt(
                  context,
                  pattern: 'HH:mm yyyy-MM-dd',
                ),
                content: widget.intel.content ?? MultilingualModel.empty(),
                medias: _getMediasByType(widget.intel.medias, MediaType.image),
                repostContent: widget.intel.extraDatas?.repostContent,
              ),
            );
          }
        },
        headline: widget.intel.title,
        time: widget.intel.publishedAtLocal(context),
        avatar: widget.intel.author?.avatar,
        summary: widget.intel.author?.prompt,
        platformLogo: widget.intel.author?.platform?.logo,
      ),
      images: GridImagePreviewWrapper(
        uniquePrefix: widget.uniquePrefix,
        urls: widget.intel.mediaImageUrls.whereType<String>().toList(),
        onTap: (index) => openImagePreview(
          widget.intel.mediaImageUrls.whereType<String>().toList(),
          index,
          widget.uniquePrefix,
        ),
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

  // /// 打开图片预览对话框
  // void _openImagePreview(List<IntelMedia> images, int initialIndex) {
  //   int currentIndex = initialIndex;

  //   showDialog(
  //     context: context,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, setState) => Dialog.fullscreen(
  //         // backgroundColor: AppColors.background(context),
  //         backgroundColor: Colors.transparent,
  //         child: Stack(
  //           children: [
  //             PhotoViewGallery.builder(
  //               itemCount: images.length,
  //               builder: (context, index) {
  //                 final imageUrl = ImageUtils.getImageProxyUrl(
  //                   images[index].url,
  //                 );
  //                 return PhotoViewGalleryPageOptions(
  //                   imageProvider: CachedNetworkImageProvider(imageUrl),
  //                   initialScale: PhotoViewComputedScale.contained,
  //                   minScale: PhotoViewComputedScale.contained * 0.5,
  //                   maxScale: PhotoViewComputedScale.covered * 2,
  //                 );
  //               },
  //               scrollPhysics: const BouncingScrollPhysics(),
  //               backgroundDecoration: BoxDecoration(
  //                 color: AppColors.background(context),
  //               ),
  //               pageController: PageController(initialPage: initialIndex),
  //               onPageChanged: (index) {
  //                 setState(() {
  //                   currentIndex = index;
  //                 });
  //               },
  //             ),
  //             // 关闭按钮
  //             Positioned(
  //               top: 40.h,
  //               right: 20.w,
  //               child: IconButton(
  //                 icon: Icon(
  //                   Icons.close,
  //                   color: AppColors.textSecondary(context),
  //                   size: 30,
  //                 ),
  //                 onPressed: () => Navigator.of(context).pop(),
  //               ),
  //             ),
  //             // 图片计数器
  //             Positioned(
  //               bottom: 40.h,
  //               left: 0,
  //               right: 0,
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: 16.w,
  //                     vertical: 8.h,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.black.withValues(alpha: 0.5),
  //                     borderRadius: BorderRadius.circular(20.r),
  //                   ),
  //                   child: Text(
  //                     '${currentIndex + 1} / ${images.length}',
  //                     style: const TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  List<IntelMedia> _getMediasByType(List<IntelMedia>? medias, MediaType type) {
    if (medias == null) return [];

    return medias.where((media) => media.type == type.value).toList();
  }
}
