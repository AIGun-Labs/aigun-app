import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/image_utils.dart";
import "package:flutter_aigun/utils/resource.dart";
import "package:flutter_aigun/widgets/image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:flutter_aigun/utils/language.dart";
import "package:provider/provider.dart";

class IntelHeader extends StatelessWidget {
  const IntelHeader(
      {super.key,
      required this.aiAgent,
      required this.createAt,
      required this.author});

  final AIAgent? aiAgent;
  final String createAt;
  final Author? author;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 45.w,
              height: 45.h,
              imageUrl: ImageUtils.getImageUrl(aiAgent?.avatar),
              fit: BoxFit.cover,
              placeholder: (context, url) => CachedImage(
                imageUrl: "assets/images/icons/ai-agent.png",
                height: 45.h,
                width: 45.w,
              ),
              errorWidget: (context, url, error) => CachedImage(
                imageUrl: "assets/images/icons/ai-agent.png",
                height: 45.h,
                width: 45.w,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getAiAgentName(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  createAt,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary(context),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<SoundEffectCubit>().playGunLoad();
            },
            child: SvgPicture.asset(
              "assets/images/icons/shared.svg",
              width: 24.w,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }

  String _getAiAgentName(BuildContext context) {
    if (aiAgent == null || aiAgent!.name == null) {
      return "";
    }

    final languageCode = Language.getLanguageCode(context);

    // Return the name based on the current language, with fallback to English
    return aiAgent!.name![languageCode] ?? aiAgent!.name!["en"] ?? "";
  }
}
