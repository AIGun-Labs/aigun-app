import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/colors.dart';
import '../../utils/format/number.dart';
import 'index.dart';
import 'models/token.dart';

class TokenItem extends StatelessWidget {
  const TokenItem({
    super.key,
    this.token,
    this.onTap,
    this.tokenAvatarSize = 46,
    this.chainLogoSize = 18,
    this.isShowRight = true,
    this.title,
    this.subtitle,
    this.trailing,
    this.trailingSubtitle,
    this.titleWidget,
    this.subtitleWidget,
    this.trailingWidget,
    this.trailingSubtitleWidget,
  });
  final Token? token;
  final Function(Token?)? onTap;
  final double tokenAvatarSize;
  final double chainLogoSize;
  final bool isShowRight;

  final String? title;
  final String? subtitle;
  final String? trailing;
  final String? trailingSubtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final Widget? trailingWidget;
  final Widget? trailingSubtitleWidget;

  @override
  Widget build(BuildContext context) {
    final tileTitle = title ?? token?.tokenName;
    final tileSubtitle = subtitle ?? token?.symbol;
    final tileTrailing = trailing ?? formatPrice(token?.rawBalance);
    final tileTrailingSubtitle =
        trailingSubtitle ?? formatPrice(token?.tokenPrice);

    return Row(
      children: [
        Expanded(
          child: ListTile(
            onTap: () => onTap?.call(token),
            contentPadding: EdgeInsets.only(
              right: 10.0.w,
              bottom: 2.0.w,
              top: 2.0.w,
              left: 16.w,
            ),
            leading: AvatarToken(
              avatar: token?.tokenAvatar,
              chainLogo: token?.chainLogo,
              tokenName: token?.tokenName,
              chainName: token?.chainName,
              width: tokenAvatarSize.w,
              height: tokenAvatarSize.h,
              chainLogoHeight: chainLogoSize.h,
              chainLogoWidth: chainLogoSize.w,
            ),
            title:
                titleWidget ??
                Text(
                  tileTitle ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),
            subtitle:
                subtitleWidget ??
                Text(
                  // _getChainName(token.chainId)
                  tileSubtitle ?? "",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textQuaternary(context),
                  ),
                ),
            trailing: isShowRight
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      trailingWidget ??
                          Text(
                            "\$$tileTrailing",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                      trailingSubtitleWidget ??
                          Text(
                            tileTrailingSubtitle,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textQuaternary(context),
                            ),
                          ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
        // BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
        //     builder: (context, state) {
        //   final isFavorite = state.tokens.any((element) =>
        //       element.address == token?.address &&
        //       element.symbol == token?.symbol &&
        //       element.tokenName == token?.tokenName &&
        //       element.chainId == token?.chainId &&
        //       element.tokenAvatar == token?.tokenAvatar);
        //   return GestureDetector(
        //     onTap: () {
        //       if (token != null) {
        //         getIt<FavoriteTokenCubit>().handleFavoriteToken(token!);
        //       }
        //     },
        //     child: Padding(
        //       padding: EdgeInsetsGeometry.only(right: 16.w, left: 10.w),
        //       child: Icon(
        //         isFavorite ? Icons.star : Icons.star_border,
        //         color: isFavorite
        //             ? AppColors.tertiary
        //             : AppColors.textQuaternary(context),
        //       ),
        //     ),
        //   );
        // }),
      ],
    );
  }
}

class TokenItemSkeleton extends StatelessWidget {
  const TokenItemSkeleton({
    super.key,
    this.tokenAvatarSize = 46,
    this.chainLogoSize = 18,
    this.isShowRight = true,
  });

  final double tokenAvatarSize;
  final double chainLogoSize;
  final bool isShowRight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(context),
      highlightColor: AppColors.shimmerHighlightColor(context),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
          vertical: 2.0.w,
        ),
        leading: _buildAvatarSkeleton(context),
        title: _buildTitleSkeleton(context),
        subtitle: _buildSubtitleSkeleton(context),
        trailing: isShowRight
            ? _buildTrailingSkeleton(context)
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildAvatarSkeleton(BuildContext context) {
    return SizedBox(
      width: tokenAvatarSize.w,
      height: tokenAvatarSize.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: tokenAvatarSize.w,
            height: tokenAvatarSize.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),

          Positioned(
            bottom: 0,
            right: -6,
            child: Container(
              width: chainLogoSize.w,
              height: chainLogoSize.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSkeleton(BuildContext context) {
    return Container(
      height: 16.sp,
      width: 120.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildSubtitleSkeleton(BuildContext context) {
    return Container(
      height: 12.sp,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildTrailingSkeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 16.sp,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 4.h),

        Container(
          height: 12.sp,
          width: 80.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
