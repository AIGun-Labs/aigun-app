import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../shared/presentation/widgets/appbar_widget.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/toast.dart';
import '../../../../utils/validators/token_validator.dart';
import '../../../../widgets/feature_image.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../cubits/intels/intels_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';
import '../cubits/token_security/token_security_cubit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.token});
  final BaseTokenEntity token;
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  void _scrollToTop(BuildContext context) {
    final fallback = PrimaryScrollController.maybeOf(context);
    if (fallback != null && fallback.hasClients) {
      fallback.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      fallback?.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _onCollected(BuildContext context, CollectState state) async {
    final tokenInfo =
        BlocProvider.of<TokenInfoCubit>(context).state.tokenInfo?.base ?? token;
    await BlocProvider.of<CollectCubit>(
      context,
    ).handleCollect(token: tokenInfo);

    if (!context.mounted) return;
    final isCollected = state.isCollected(tokenInfo);

    if (state.actionStatus == CollectActionStatus.success) {
      if (isCollected) {
        ToastUtils.showCenterToast(context, S.of(context).cancelTracking);
      } else {
        ToastUtils.showCenterToast(context, S.of(context).trackSuccess);
      }
    }

    if (state.actionStatus == CollectActionStatus.error) {
      ToastUtils.showCenterToast(context, state.errorMessage ?? '');
    }
  }

  void _onShare(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppbarWidget(
      centerTitle: false,
      titleSpacing: 0,
      title: TokenHeaderTitle(
        network: token.network,
        url: token.tokenLogo,
        name: token.symbol,
        chainIcon: token.chainLogo,
        address: token.address,
        isNative: token.isNative,
      ),
      actions: [
        BlocBuilder<CollectCubit, CollectState>(
          builder: (context, state) {
            final isCollected = state.isCollected(token);
            return IconButton(
              onPressed: () => _onCollected(context, state),
              isSelected: isCollected,
              selectedIcon: Icon(
                Icons.star_rounded,
                color: AppColors.tertiary,
                size: 28.sp,
              ),
              icon: Icon(
                Icons.star_border_rounded,
                color: AppColors.textPrimary(context),
                size: 28.sp,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () => _onShare(context),
          icon: Icon(
            Icons.share_outlined,
            color: AppColors.textPrimary(context),
            size: 26.sp,
          ),
        ),
      ],
      bottom: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.w), // 调大左右间距
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.h, color: Colors.black),
        ),
        // 点击tabbar时，背景颜色不变
        overlayColor: WidgetStateProperty.all(AppColors.background(context)),
        unselectedLabelColor: AppColors.textTertiary(context),
        labelColor: AppColors.textPrimary(context),
        indicatorColor: AppColors.textPrimary(context),
        dividerHeight: 1.h,
        dividerColor: AppColors.border(context),
        tabs: [
          Tab(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: s.marketTab,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<IntelsCubit, IntelsState>(
            builder: (context, state) {
              return Tab(
                child: Text.rich(
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: s.aiTab,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 4.w)),
                      if (state.count != null && state.count! > 0)
                        TextSpan(
                          text: state.count.toString(),
                          style: TextStyle(
                            color: AppColors.quaternary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          BlocBuilder<TokenSecurityCubit, TokenSecurityState>(
            builder: (context, state) {
              return Tab(
                child: Text.rich(
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: s.riskTab,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 4.w)),
                      if (state.tokenSecurity?.notSafeCount != null &&
                          state.tokenSecurity!.notSafeCount > 0)
                        TextSpan(
                          text: state.tokenSecurity!.notSafeCount.toString(),
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TokenHeaderTitle extends StatelessWidget {
  const TokenHeaderTitle({
    super.key,
    required this.network,
    required this.url,
    required this.name,
    required this.chainIcon,
    required this.address,
    required this.isNative,
  });

  final String url;
  final String name;
  final String chainIcon;
  final String address;
  final bool isNative;
  final String network;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TokenHeaderAvatar(url: url, tokenName: name),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () async {
            await ClipboardUtils.copy(address);
            if (!context.mounted) return;
            ToastUtils.showCenterToast(context, S.of(context).copySuccess);
          },
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 100.w),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    if (TokenValidator.shouldShowChainLogo(network, chainIcon))
                      ClipOval(
                        child: FeatureImage(
                          url: ImageUtils.getImageUrl(chainIcon),
                          width: 16.w,
                          height: 16.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 2.h),
                if (!isNative || !TokenValidator.isNativeToken(address))
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 160.w),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            address.splitStartAndEnd(4, 4),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textTertiary(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        'assets/images/icons/copy.svg',
                        width: 13.w,
                        height: 13.w,
                        colorFilter: ColorFilter.mode(
                          AppColors.textTertiary(context),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TokenHeaderAvatar extends StatelessWidget {
  const TokenHeaderAvatar({
    super.key,
    required this.url,
    required this.tokenName,
  });

  final String url;
  final String tokenName;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FeatureImage(
        url: ImageUtils.getImageProxyUrl(url),
        width: 40.w,
        height: 40.w,
        fit: BoxFit.cover,
        errorWidget: Container(
          width: 40.w,
          height: 40.w,
          color: AppColors.tokenPlaceholderColor,
          child: Center(
            child: Text(
              tokenName.splitValueByCount(count: 1),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
