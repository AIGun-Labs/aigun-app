import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/custom_popup.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TrendingTokenListItem extends StatelessWidget {
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
        content: SizedBox(
          width: 60.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTopTap ?? () {},
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
                  final isFavorite =
                      context.read<FavoriteTokenCubit>().isFavoriteToken(token);
                  final isLoading =
                      state.status == const FavoriteTokenStatus.loading();

                  return GestureDetector(
                    //收藏功能
                    onTap: isLoading
                        ? null
                        : () {
                            context
                                .read<FavoriteTokenCubit>()
                                .handleFavoriteToken(token);
                          },
                    child: isLoading
                        ? SizedBox(
                            height: 24.w,
                            width: 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : SvgPicture.asset(
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
              )
            ],
          ),
        ),
        child: ListTile(
          key: ValueKey('trending_item_$index'),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          horizontalTitleGap: 12.w,
          leading: ClipOval(
            child: CachedImage(
              imageUrl: token.tokenAvatar ?? '',
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
            token.tokenName ?? '',
          ),
          subtitle: Text(
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary(context),
            ),
            formatPriceEnglish(token.marketCap ?? 0),
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
                  '\$${token.tokenPrice}'),
              Text(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: (token.priceChange24h ?? 0) > 0
                      ? AppColors.septenary
                      : AppColors.secondary,
                ),
                '${token.priceChange24h?.toString()}%',
              ),
            ],
          ),
          onTap: onTap ?? () {},
        ),
      ),
    );
  }
}
