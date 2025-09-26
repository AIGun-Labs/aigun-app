import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: Row(
        spacing: 10.w,
        children: [
          BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            return state.maybeWhen(
                orElse: () => CircleAvatar(
                      radius: 18.r,
                      child: Image.asset("assets/test/default-avatar.png"),
                    ),
                success: (user) => CircleAvatar(
                      radius: 18.r,
                      // TODO：记得打开
                      // backgroundImage: NetworkImage(
                      //   getImageUrl(user.avatar) ?? "",
                      // ),
                      child: Image.asset("assets/test/default-avatar.png"),
                    ));
          }),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
                hintText: "Search name or CA",
                hintStyle: TextStyle(color: AppColors.textQuaternary(context)),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24.w, minHeight: 24.w),
                prefixIcon: Container(
                  margin: EdgeInsets.fromLTRB(10.w, 8.h, 0, 8.h),
                  child: SvgPicture.asset(
                    "assets/images/icons/lightning-search.svg",
                    width: 18.w,
                    height: 18.h,
                    colorFilter: ColorFilter.mode(
                      AppColors.textQuaternary(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                      AppColors.quaternary,
                    ),
                  ),
                  onPressed: () {
                    ClipboardUtils.paste().then((value) {
                      searchController.text = value;
                    });
                  },
                  child: Text(S.of(context).paste),
                ),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.border(context), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.border(context), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.border(context), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
