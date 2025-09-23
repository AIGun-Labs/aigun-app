import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavbarUserSearch extends StatefulWidget implements PreferredSizeWidget {
  const NavbarUserSearch({super.key, required this.openDrawer});
  final VoidCallback? openDrawer;

  @override
  State<NavbarUserSearch> createState() => _NavUserSearchState();

  // 实现PreferredSizeWidget接口，定义AppBar的高度
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavUserSearchState extends State<NavbarUserSearch> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false, // 只处理顶部安全区域
      child: Container(
        height: widget.preferredSize.height,
        color: AppColors.background(context),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
        child: Row(
          children: [
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              return GestureDetector(
                onTap: () => widget.openDrawer?.call(),
                child: state.maybeWhen(
                    orElse: () => CircleAvatar(
                          radius: 20.r,
                          child: Image.asset("assets/test/default-avatar.png"),
                        ),
                    success: (user) => CircleAvatar(
                          radius: 20.r,
                          // TODO：记得打开
                          // backgroundImage: NetworkImage(
                          //   getImageUrl(user.avatar) ?? "",
                          // ),
                          child: Image.asset("assets/test/default-avatar.png"),
                        )),
              );
            }),
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
                  hintText: "Search name or CA",
                  hintStyle:
                      TextStyle(color: AppColors.textQuaternary(context)),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: SvgPicture.asset(
                      "assets/images/icons/lightning-search.svg",
                      width: 16.w,
                      height: 16.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textQuaternary(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {
                      ClipboardUtils.paste().then((value) {
                        searchController.text = value;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SvgPicture.asset(
                        "assets/images/icons/copy.svg",
                        width: 18.w,
                        height: 16.h,
                        colorFilter: ColorFilter.mode(
                            AppColors.textTertiary(context), BlendMode.srcIn),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.border(context), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.border(context), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.border(context), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.r))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
