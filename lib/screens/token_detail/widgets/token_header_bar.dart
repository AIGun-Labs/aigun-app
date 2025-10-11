import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TokenHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const TokenHeaderBar({super.key, required this.tabbar});
  final PreferredSizeWidget tabbar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      return AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          title: Transform.translate(
            offset: Offset(-18.w, 0),
            child: TokenHeaderTitle(
              url: state.token?.tokenAvatar ?? '',
              name: state.token?.tokenName ?? '',
              chainIcon: state.token?.chainLogo ?? '',
              address: state.token?.address ?? '',
              isNative: state.tokenDetailInfo?.isNative ?? false,
            ),
          ),
          // 底部 tabbar
          bottom: tabbar,
          actions: [
            BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
                builder: (context, favoriteState) {
              final isFavorite = context
                  .read<FavoriteTokenCubit>()
                  .isFavoriteToken(state.token!);

              final isActionLoading = favoriteState.actionStatus.maybeWhen(
                  orElse: () => false,
                  adding: () => true,
                  removing: () => true);

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: ActionButtonIcon(
                  key: ValueKey<bool>(isFavorite),
                  color: isFavorite
                      ? AppColors.tertiary
                      : AppColors.textPrimary(context),
                  assetPath: isFavorite
                      ? 'assets/images/icons/star-filled.svg'
                      : 'assets/images/icons/star-outline.svg',
                  onPressed: isActionLoading
                      ? null
                      : () {
                          final token = Token(
                            chainId: state.token?.chainId ?? 0,
                            chainLogo: state.token?.chainLogo ?? '',
                            chainName: state.token?.chainName ?? '',
                            tokenAvatar: state.token?.tokenAvatar ?? '',
                            tokenName: state.token?.tokenName ?? '',
                            address: state.token?.address ?? '',
                            symbol: state.token?.symbol ?? '',
                            balance: state.token?.balance ?? '',
                            decimals: state.token?.decimals ?? 0,
                            network: state.token?.network ?? '',
                            tokenPrice:
                                state.tokenDetailInfo?.priceUsd.toString() ??
                                    '',
                            rawBalance: state.token?.rawBalance ?? '',
                            slug: state.token?.slug ?? '',
                            priceChange24h:
                                state.tokenDetailInfo?.priceChange24h,
                            marketCap: state.tokenDetailInfo?.marketCap ?? 0,
                          );

                          context
                              .read<FavoriteTokenCubit>()
                              .handleFavoriteToken(token);
                        },
                ),
              );
            }),
            ActionButtonIcon(
                key: const ValueKey<bool>(false),
                color: AppColors.textPrimary(context),
                assetPath: 'assets/images/icons/share-outline.svg',
                onPressed: () {}),
          ]);
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 49.h);
}

class ActionButtonIcon extends StatelessWidget {
  const ActionButtonIcon(
      {super.key,
      required this.assetPath,
      required this.onPressed,
      required this.color});

  final String assetPath;
  final VoidCallback? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed ?? () {},
        icon: SvgPicture.asset(assetPath,
            width: 20.w,
            height: 20.h,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn)));
  }
}

class TokenHeaderTitle extends StatefulWidget {
  const TokenHeaderTitle(
      {super.key,
      required this.url,
      required this.name,
      required this.chainIcon,
      required this.address,
      required this.isNative});

  final String url;
  final String name;
  final String chainIcon;
  final String address;
  final bool isNative;

  @override
  State<TokenHeaderTitle> createState() => _TokenHeaderTitleState();
}

class _TokenHeaderTitleState extends State<TokenHeaderTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TokenHeaderAvatar(
          url: widget.url,
          tokenName: widget.name,
        ),
        SizedBox(width: 8.w),
        SizedBox(
          height: 40.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 160.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Expanded(
                          child: Text(
                        widget.name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context)),
                      )),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  ClipOval(
                    child: SmartNetworkImage(
                      url: ImageUtils.getImageUrl(widget.chainIcon) ?? '',
                      width: 16.w,
                      height: 16.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              if (!widget.isNative)
                Row(
                  children: [
                    Text(
                      widget.address.splitStartAndEnd(4, 4),
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textTertiary(context)),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () async {
                        await ClipboardUtils.copy(widget.address);
                        if (!mounted) return;
                        ToastUtils.showCenterToast(
                            context, S.of(context).copySuccess);
                      },
                      child: SvgPicture.asset("assets/images/icons/copy.svg",
                          width: 13.w,
                          height: 13.h,
                          colorFilter: ColorFilter.mode(
                              AppColors.textTertiary(context),
                              BlendMode.srcIn)),
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class TokenHeaderAvatar extends StatelessWidget {
  const TokenHeaderAvatar(
      {super.key, required this.url, required this.tokenName});

  final String url;
  final String tokenName;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: SmartNetworkImage(
      url: ImageUtils.getImageUrl(url),
      width: 40.w,
      height: 40.h,
      fit: BoxFit.cover,
      errorWidget: Container(
        width: 40.w,
        height: 40.h,
        color: AppColors.tokenPlaceholderColor,
        child: Center(
          child: Text(
            tokenName.isNotEmpty
                ? tokenName.split('').first.toUpperCase()
                : "?",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundWhite,
            ),
          ),
        ),
      ),
      loadingWidget: Container(
        width: 40.w,
        height: 40.h,
        color: AppColors.tokenPlaceholderColor,
        child: Center(
          child: Text(
            tokenName.isNotEmpty
                ? tokenName.split('').first.toUpperCase()
                : "?",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundWhite,
            ),
          ),
        ),
      ),
    ));
  }
}
