import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/clipboard.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/toast.dart';
import '../../../utils/validators/token_validator.dart';
import '../../../widgets/feature_image.dart';

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
            ),
          ),
          title: Transform.translate(
            offset: Offset(-18.w, 0),
            child: TokenHeaderTitle(
              network: state.token?.network ?? '',
              url: state.token?.tokenAvatar ?? '',
              name: state.token?.symbol ?? '',
              chainIcon: state.token?.chainLogo ?? '',
              address: state.token?.address ?? '',
              isNative: state.tokenDetailInfo?.isNative ?? false,
            ),
          ),
          
          bottom: tabbar,
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ActionButtonIcon(
                color: AppColors.textPrimary(context),
                assetPath: 'assets/images/icons/star-outline.svg',
                onPressed: null,
              ),
            ),
            ActionButtonIcon(
              key: const ValueKey<bool>(false),
              color: AppColors.textPrimary(context),
              assetPath: 'assets/images/icons/share-outline.svg',
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 49.h);
}

class ActionButtonIcon extends StatelessWidget {
  const ActionButtonIcon({
    super.key,
    required this.assetPath,
    required this.onPressed,
    required this.color,
  });

  final String assetPath;
  final VoidCallback? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      icon: SvgPicture.asset(
        assetPath,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

class TokenHeaderTitle extends StatefulWidget {
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
  State<TokenHeaderTitle> createState() => _TokenHeaderTitleState();
}

class _TokenHeaderTitleState extends State<TokenHeaderTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TokenHeaderAvatar(url: widget.url, tokenName: widget.name),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () async {
            await ClipboardUtils.copy(widget.address);
            if (!context.mounted) return;
            ToastUtils.showCenterToast(context, S.of(context).copySuccess);
          },
          child: SizedBox(
            height: 40.h,
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
                          widget.name,
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
                    if (TokenValidator.shouldShowChainLogo(
                      widget.network,
                      widget.chainIcon,
                    ))
                      ClipOval(
                        child: FeatureImage(
                          url: ImageUtils.getImageUrl(widget.chainIcon),
                          width: 16.w,
                          height: 16.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 2.h),
                if (!widget.isNative ||
                    !TokenValidator.isNativeToken(widget.address))
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 160.w),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.address.splitStartAndEnd(4, 4),
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
                        height: 13.h,
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
        height: 40.h,
        fit: BoxFit.cover,
        errorWidget: Container(
          width: 40.w,
          height: 40.h,
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
