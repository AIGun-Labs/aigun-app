import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/avatar/widget/round_token.dart';
import '../../../../widgets/custom_popup.dart';
import '../../../collect/domain/mappers/hot_token_entity_mapper.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../domain/entities/hot_token_entity.dart';

class HotTokenCard extends StatelessWidget {
  const HotTokenCard({super.key, required this.token, required this.onTap});
  final HotTokenEntity token;
  final VoidCallback onTap;

  Widget _buildFavoriteButton(BuildContext context, HotTokenEntity token) {
    final collectToken = token.toCollectToken();

    return BlocBuilder<CollectCubit, CollectState>(
      builder: (context, state) {
        final isFavorite = state.isCollected(collectToken);
        final isActionLoading =
            state.actionStatus == CollectActionStatus.adding ||
                state.actionStatus == CollectActionStatus.removing;
        return GestureDetector(
          //收藏功能
          onTap: isActionLoading
              ? null
              : () async {
                  // 先获取根 context
                  final scaffoldContext = Navigator.of(context).context;
                  Navigator.of(context).pop();
                  await context
                      .read<CollectCubit>()
                      .handleCollect(token: collectToken);

                  if (!scaffoldContext.mounted) return;
                  if (isFavorite) {
                    ToastUtils.showCenterToast(
                        scaffoldContext, S.of(scaffoldContext).cancelTracking);
                  } else {
                    ToastUtils.showCenterToast(
                        scaffoldContext, S.of(scaffoldContext).trackSuccess);
                  }
                },
          child: SvgPicture.asset(
            isFavorite
                ? 'assets/images/icons/star-filled.svg'
                : 'assets/images/icons/star-outline.svg',
            height: 24.w,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              isFavorite ? Colors.yellow : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      offsetY: 80.h,
      contentRadius: 3.r,
      showArrow: true,
      arrowColor: Colors.black.withValues(alpha: 0.8),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      isLongPress: true,
      position: PopupPosition.top,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15.w,
        children: [
          _buildFavoriteButton(context, token),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Token image/icon placeholder
            AspectRatio(
              aspectRatio: 1,
              child: AvatarRoundToken(
                avatar: token.logo,
                tokenName: token.symbol,
              ),
            ),
            // Token name
            Text(
              token.symbol,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            // Market cap
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                token.marketCapFormat,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textTertiary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
