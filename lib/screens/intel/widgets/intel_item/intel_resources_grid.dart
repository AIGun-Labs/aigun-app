import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../../data/models/intel/intel.dart";
import "../../../../l10n/l10n.dart";
import "../../../../themes/themes.dart";
import "../../../../utils/image_utils.dart";

class IntelResourcesGrid extends StatelessWidget {
  const IntelResourcesGrid(
      {super.key,
      required this.medias,
      required this.onTap,
      this.uniquePrefix});
  final List<IntelMedia>? medias;
  final Function(List<IntelMedia>, int) onTap;
  final String? uniquePrefix;

  @override
  Widget build(BuildContext context) {
    if (medias == null || medias?.isEmpty == true) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        SizedBox(height: 8.h), 
        GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(medias?.length ?? 0, (index) {
              final media = medias?[index];
              // if (media.type != MediaType.image) {
              return GestureDetector(
                onTap: () => onTap(medias ?? [], index),
                child: Hero(
                  tag: '${uniquePrefix ?? 'image'}_$index',
                  child: CachedNetworkImage(
                    imageUrl: ImageUtils.getImageProxyUrl(media?.url),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 18.w,
                      height: 18.h,
                      color: AppColors.card(context),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 18.w,
                      height: 18.h,
                      color: AppColors.card(context),
                      child: Center(
                        child: Text(S.of(context).imageLoadFailed),
                      ),
                    ),
                  ),
                ),
              );
              // }
            })),
        SizedBox(height: 8.h), 
      ],
    );
  }
}
