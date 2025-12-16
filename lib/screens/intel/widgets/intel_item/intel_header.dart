import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../shared/extensions/multilingual_model_extension.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/image.dart';

class IntelHeader extends StatelessWidget {
  const IntelHeader({
    super.key,
    required this.aiAgent,
    required this.createAt,
    required this.onShare,
    required this.author,
  });

  final AIAgent? aiAgent;
  final String createAt;
  final Author? author;
  final Future<void> Function() onShare;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 45.w,
              height: 45.w,
              imageUrl: ImageUtils.getImageUrl(aiAgent?.avatar),
              fit: BoxFit.cover,
              placeholder: (context, url) => CachedImage(
                imageUrl: 'assets/images/icons/ai-agent.png',
                height: 45.w,
                width: 45.w,
              ),
              errorWidget: (context, url, error) => CachedImage(
                imageUrl: 'assets/images/icons/ai-agent.png',
                height: 45.w,
                width: 45.w,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aiAgent?.name.getByLocale(context) ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  createAt,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              context.read<SoundEffectCubit>().playGunLoad();
              await onShare();
            },
            child: SvgPicture.asset(
              'assets/images/icons/shared.svg',
              width: 24.w,
              height: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}
