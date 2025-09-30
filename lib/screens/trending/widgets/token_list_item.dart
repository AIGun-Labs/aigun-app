import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/custom_popup.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TrendingTokenListItem extends StatefulWidget {
  final int index;
  final Token token;
  final VoidCallback? onTap;
  final VoidCallback? onTopTap;

  const TrendingTokenListItem({
    super.key,
    required this.index,
    required this.token,
    this.onTap,
    this.onTopTap,
  });

  @override
  State<TrendingTokenListItem> createState() => _TrendingTokenListItemState();
}

class _TrendingTokenListItemState extends State<TrendingTokenListItem> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPopup(
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
                  "assets/images/icons/top-line-outline.svg",
                  height: 24.w,
                  width: 24.w,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
              builder: (context, state) {
                final isFavorite = context
                    .read<FavoriteTokenCubit>()
                    .isFavoriteToken(widget.token);
                final isActionLoading = state.actionStatus.maybeWhen(
                  adding: () => true,
                  removing: () => true,
                  orElse: () => false,
                );
                return GestureDetector(
                  //收藏功能
                  onTap: isActionLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                          context
                              .read<FavoriteTokenCubit>()
                              .handleFavoriteToken(widget.token);

                          if (isFavorite) {
                            ToastUtils.showCenterToast(
                                context, S.of(context).cancelTracking);
                          }
                          ;
                        },
                  child: SvgPicture.asset(
                    isFavorite
                        ? "assets/images/icons/star-filled.svg"
                        : "assets/images/icons/star-outline.svg",
                    height: 24.w,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      isFavorite ? Colors.yellow : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: ListTile(
            key: ValueKey('trending_item_${widget.index}'),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            horizontalTitleGap: 12.w,
            leading: ClipOval(
              child: CachedImage(
                imageUrl: widget.token.tokenAvatar ?? '',
                width: 40.w,
                height: 40.w,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
              maxLines: 1,
              widget.token.tokenName ?? '',
            ),
            subtitle: Text(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary(context),
              ),
              formatPriceEnglish(widget.token.marketCap ?? 0),
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
                    double.tryParse(widget.token.tokenPrice) ?? 0.0,
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: (widget.token.priceChange24h ?? 0) > 0
                        ? AppColors.septenary
                        : AppColors.secondary,
                  ),
                  '${widget.token.priceChange24h?.toString()}%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
