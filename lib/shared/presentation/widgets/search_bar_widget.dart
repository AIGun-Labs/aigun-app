import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/clipboard.dart';
import '../../../utils/image_utils.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
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
    this.searchController,
  });

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
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.prefix ??
            GestureDetector(
              onTap: () => widget.openDrawer?.call(),
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 35.w,
                  height: 35.w,
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.tokenPlaceholderColor,
                    child: Center(
                      child: Text(
                        "H",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  imageUrl: ImageUtils.getAvatarUrl(
                    "https://cdn.route.aigun.ai/fission/images/avatar/12.png",
                  ),
                ),
              ),
            ),
        if (widget.leftSpacing == true) SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 35.w,
            child: TextField(
              readOnly: widget.isRead ?? false,
              
              onTap: widget.isRead == true
                  ? () =>
                        context.pushNamed(RouteNames.searchInternal, extra: '')
                  : null,
              controller: widget.searchController,
              decoration: InputDecoration(
                filled: widget.backgroundColor != null,
                fillColor: widget.backgroundColor ?? Colors.transparent,
                contentPadding: EdgeInsets.zero, 
                hintText: S.of(context).searchNameOrCA,
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(
                      color: AppColors.textQuaternary(context),
                      fontSize: 14.sp,
                    ),
                // prefixIcon: const Icon(Icons.search_sharp),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30.w,
                  minHeight: 30.w,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: SvgPicture.asset(
                    'assets/images/icons/lightning-search.svg',
                    // width: 10.w,
                    // height: 10.w,
                    alignment: Alignment.centerRight,
                    colorFilter: ColorFilter.mode(
                      widget.prefixIconColor ??
                          AppColors.textQuaternary(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () async {
                    if (widget.isRead == true) {
                      final clipboardText = await ClipboardUtils.paste();
                      if (context.mounted) {
                        context.pushNamed(
                          RouteNames.searchInternal,
                          extra: clipboardText,
                        );
                      }
                    } else {
                      widget.suffixOnPressed?.call();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.red[500]!.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: widget.suffix,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.border(context),
                    width: 1.r,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.border(context),
                    width: 1.r,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.border(context),
                    width: 1.r,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
