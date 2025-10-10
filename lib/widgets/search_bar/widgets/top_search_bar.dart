import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar(
      {super.key,
      this.openDrawer,
      this.suffix,
      this.suffixOnPressed,
      this.searchController});

  final VoidCallback? openDrawer;
  final Widget? suffix;
  final Function? suffixOnPressed;
  final TextEditingController? searchController;

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        const SizedBox(width: 10),
        Expanded(
            child: SizedBox(
          height: 40,
          child: TextField(
            controller: widget.searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
              hintText: "Search name or CA",
              hintStyle: TextStyle(color: AppColors.textQuaternary(context)),
              // prefixIcon: const Icon(Icons.search_sharp),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/images/icons/lightning-search.svg",
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    AppColors.textQuaternary(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: TextButton(
                // onPressed: () {
                //   ClipboardUtils.paste().then((value) {
                //     searchController.text = value;
                //   });
                // },
                onPressed: () => widget.suffixOnPressed?.call(),
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
                  borderSide:
                      BorderSide(color: AppColors.border(context), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.border(context), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.border(context), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ))
      ],
    );
  }
}
