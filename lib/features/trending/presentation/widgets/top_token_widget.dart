import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/trending/lastest_token/lastest_token.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/avatar/widget/token.dart';
import '../../../../widgets/custom_popup.dart';
import '../../../collect/domain/mappers/top_token_mapper.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';

class TopTokenWidget extends StatefulWidget {
  final int index;
  final LatestToken token;
  final VoidCallback? onTap;
  final VoidCallback? onTopTap;

  const TopTokenWidget({
    super.key,
    required this.index,
    required this.token,
    this.onTap,
    this.onTopTap,
  });

  @override
  State<TopTokenWidget> createState() => _TopTokenWidgetState();
}

class _TopTokenWidgetState extends State<TopTokenWidget> {
  Widget _buildFavoriteButton(BuildContext context, LatestToken token) {
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
            if (widget.onTopTap != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onTopTap?.call();
                },
                child: SvgPicture.asset(
                  'assets/images/icons/top-line-outline.svg',
                  height: 24.w,
                  width: 24.w,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            _buildFavoriteButton(context, widget.token),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: ListTile(
            key: ValueKey('trending_item_${widget.index}'),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            horizontalTitleGap: 12.w,
            leading: ClipOval(
              child: AvatarToken(
                avatar: widget.token.logo,
                tokenName: widget.token.symbol,
                width: 40.w,
                height: 40.w,
              ),
            ),
            title: Text(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
              maxLines: 1,
              widget.token.symbol,
            ),
            subtitle: Text(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary(context),
              ),
              widget.token.marketCap.marketCap(),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                  CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                    widget.token.priceUsd,
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: (widget.token.priceChange24h) > 0
                        ? AppColors.septenary
                        : AppColors.secondary,
                  ),
                  '${widget.token.priceChange24h.toString()}%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
