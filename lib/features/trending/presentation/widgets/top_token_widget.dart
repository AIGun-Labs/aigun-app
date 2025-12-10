import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/avatar/widget/token.dart';
import '../../../../widgets/custom_popup.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../domain/entities/realtime_entity.dart';

class TopTokenWidget extends StatelessWidget {
  final int index;
  final BaseTokenEntity token;
  final VoidCallback? onTap;
  final VoidCallback? onTopTap;
  final RealtimeEntity? realtime;

  const TopTokenWidget({
    super.key,
    required this.index,
    required this.token,
    this.onTap,
    this.onTopTap,
    this.realtime,
  });

  Widget _buildFavoriteButton(BuildContext context, BaseTokenEntity token) {
    return BlocBuilder<CollectCubit, CollectState>(
      builder: (context, state) {
        final isCollected = state.isCollected(token);
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
                  await BlocProvider.of<CollectCubit>(
                    context,
                  ).handleCollect(token: token);

                  if (!scaffoldContext.mounted) return;
                  if (isCollected) {
                    ToastUtils.showCenterToast(
                      scaffoldContext,
                      S.of(scaffoldContext).cancelTracking,
                    );
                  } else {
                    ToastUtils.showCenterToast(
                      scaffoldContext,
                      S.of(scaffoldContext).trackSuccess,
                    );
                  }
                },
          child: SvgPicture.asset(
            isCollected
                ? 'assets/images/icons/star-filled.svg'
                : 'assets/images/icons/star-outline.svg',
            height: 24.w,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              isCollected ? Colors.yellow : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPopup(
        offsetY: 90.h,
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
            if (onTopTap != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  onTopTap?.call();
                },
                child: SvgPicture.asset(
                  'assets/images/icons/top-line-outline.svg',
                  height: 24.w,
                  width: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            _buildFavoriteButton(context, token),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            key: ValueKey('trending_item_$index'),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
            child: Row(
              children: [
                ClipOval(
                  child: AvatarToken(
                    avatar: token.tokenLogo,
                    tokenName: token.symbol,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        token.symbol,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary(context),
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        token.formattedMarketCap,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                        double.tryParse(token.tokenPrice) ?? 0.0,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    Text(
                      token.formattedPriceChange,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: token.isPriceUp
                            ? AppColors.septenary
                            : AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
