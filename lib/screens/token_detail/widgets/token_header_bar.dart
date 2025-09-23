import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TokenHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const TokenHeaderBar({super.key});

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
            ),
          ),
          actions: [
            ActionButtonIcon(
                assetPath: 'assets/images/icons/star-outline.svg',
                onPressed: () {}),
            ActionButtonIcon(
                assetPath: 'assets/images/icons/share-outline.svg',
                onPressed: () {}),
          ]);
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ActionButtonIcon extends StatelessWidget {
  const ActionButtonIcon(
      {super.key, required this.assetPath, required this.onPressed});

  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(assetPath,
            width: 20.w,
            height: 20.h,
            colorFilter: ColorFilter.mode(
                AppColors.textPrimary(context), BlendMode.srcIn)));
  }
}

class TokenHeaderTitle extends StatelessWidget {
  const TokenHeaderTitle(
      {super.key,
      required this.url,
      required this.name,
      required this.chainIcon,
      required this.address});

  final String url;
  final String name;
  final String chainIcon;
  final String address;

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   contentPadding: EdgeInsets.zero,
    //   leading: TokenHeaderAvatar(url: url),
    //   title: Text(name),
    //   subtitle: Text(address.splitStartAndEnd(4, 4)),
    // );
    return Row(
      children: [
        TokenHeaderAvatar(url: url),
        SizedBox(width: 8.w),
        SizedBox(
          height: 40.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 100.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  ClipOval(
                    child: SmartNetworkImage(
                      url: getImageUrl(chainIcon) ?? '',
                      width: 16.w,
                      height: 16.h,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    address.splitStartAndEnd(4, 4),
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textTertiary(context)),
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () {
                      ClipboardUtils.copy(address).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).copySuccess,
                              style: TextStyle(
                                  color: AppColors.textPrimary(context)),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: AppColors.card(context),
                          ),
                        );
                      });
                    },
                    child: SvgPicture.asset("assets/images/icons/copy.svg",
                        width: 13.w,
                        height: 13.h,
                        colorFilter: ColorFilter.mode(
                            AppColors.textTertiary(context), BlendMode.srcIn)),
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
  const TokenHeaderAvatar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SmartNetworkImage(
        url: url,
        width: 40.w,
        height: 40.h,
      ),
    );
  }
}
