import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar(
      {super.key,
      this.openDrawer,
      this.prefix,
      this.suffix,
      this.suffixOnPressed,
      this.isRead,
      this.backgroundColor,
      this.borderColor,
      this.hintStyle,
      this.prefixIconColor,
      this.leftSpacing,
      this.searchController});

  final VoidCallback? openDrawer;
  final Widget? suffix;
  final Function? suffixOnPressed;
  final TextEditingController? searchController;
  final Widget? prefix;
  final bool? isRead;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;
  final bool? leftSpacing;

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.prefix ??
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              return GestureDetector(
                onTap: () => widget.openDrawer?.call(),
                child: state.status.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    success: (user) => ClipOval(
                            child: CachedNetworkImage(
                          width: 35.w,
                          height: 35.h,
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.tokenPlaceholderColor,
                            child: Center(
                              child: Text(
                                user.nickname.splitValueByCount(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          imageUrl: ImageUtils.getAvatarUrl(user.avatar),
                        ))),
              );
            }),
        if (widget.leftSpacing == true) const SizedBox(width: 10),
        Expanded(
            child: SizedBox(
          height: 40,
          child: TextField(
            readOnly: widget.isRead ?? false,
            // 点击之后跳转到代币查询界面
            onTap: widget.isRead == true
                ? () => context.push(Routes.searchInternal, extra: "")
                : null,
            controller: widget.searchController,
            decoration: InputDecoration(
              filled: widget.backgroundColor != null,
              fillColor: widget.backgroundColor ?? Colors.transparent,
              contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
              hintText: S.of(context).searchNameOrCA,
              hintStyle: widget.hintStyle ??
                  TextStyle(color: AppColors.textQuaternary(context)),
              // prefixIcon: const Icon(Icons.search_sharp),

              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/images/icons/lightning-search.svg",
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    widget.prefixIconColor ?? AppColors.textQuaternary(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: TextButton(
                style:
                    TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                onPressed: () async {
                  if (widget.isRead == true) {
                    final clipboardText = await ClipboardUtils.paste();
                    if (context.mounted) {
                      context.push(Routes.searchInternal, extra: clipboardText);
                    }
                  } else {
                    widget.suffixOnPressed?.call();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    // color: Colors.red[500]!.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // child: SvgPicture.asset(
                  //   "assets/images/icons/copy.svg",
                  //   width: 18.w,
                  //   height: 16.h,
                  //   colorFilter: ColorFilter.mode(
                  //       AppColors.textTertiary(context), BlendMode.srcIn),
                  // ),
                  child: widget.suffix,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.border(context),
                      width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.border(context),
                      width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.border(context),
                      width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ))
      ],
    );
  }
}
