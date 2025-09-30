import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DrawerSetting extends StatefulWidget {
  const DrawerSetting({super.key});

  @override
  State<DrawerSetting> createState() => _DrawerSettingState();
}

class _DrawerSettingState extends State<DrawerSetting> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background(context),
      shape: const RoundedRectangleBorder(),
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Column(
          children: [
            // 用户信息区域
            _buildUserProfile(context),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                ),
                child: Divider(
                  height: 1,
                  color: AppColors.border(context),
                )),
            // 菜单项
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 10.h),
                children: [
                  _buildMenuItem(
                      iconName: "join-us",
                      title: S.of(context).joinUs,
                      onTap: () {}),
                  _buildMenuItem(
                      iconName: "secure-wallet",
                      title: S.of(context).welletSecurity,
                      onTap: () {}),
                  _buildMenuItem(
                      iconName: "switch-language",
                      title: S.of(context).languages,
                      onTap: () => context.push(Routes.switchLanguage)),
                  _buildMenuItem(
                      iconName: "update",
                      title: S.of(context).update,
                      onTap: () {},
                      trailing: _buildVersionBadge()),
                  _buildMenuItem(
                      iconName: "learn-aigun",
                      title: S.of(context).learnAIGun,
                      onTap: () {}),
                  _buildMenuItem(
                      iconName: "log-out",
                      title: S.of(context).logOut,
                      onTap: () {
                        context.read<UserCubit>().logout();
                      }),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                ),
                child: Divider(
                  height: 1,
                  color: AppColors.border(context),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16.w,
                children: [
                  IconButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.surface(context)),
                    ),
                    icon: SvgPicture.asset(
                      'assets/images/icons/x.svg',
                      width: 15.w,
                      height: 15.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.textPrimary(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.surface(context)),
                    ),
                    icon: SvgPicture.asset(
                      'assets/images/icons/telegram.svg',
                      width: 15.w,
                      height: 15.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.textPrimary(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          child: Row(
            children: [
              state.status.maybeWhen(
                  orElse: () => CircleAvatar(
                        radius: 30.w,
                        child: Image.asset("assets/test/default-avatar.png"),
                      ),
                  success: (user) => CircleAvatar(
                        radius: 30.w,
                        // TODO：记得打开
                        // backgroundImage: NetworkImage(
                        //   getImageUrl(user.avatar) ?? "",
                        // ),
                        child: Image.asset("assets/test/default-avatar.png"),
                      )),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.status.maybeWhen(
                        success: (user) => user.email,
                        orElse: () => "trump@gmail.com",
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons-settings/identity.svg',
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          state.status.maybeWhen(
                              orElse: () => "AiGun早鸟期用户",
                              success: (user) => user.nickname),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required String iconName,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
      leading: SvgPicture.asset('assets/icons-settings/$iconName.svg',
          width: 30.w, height: 30.h),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textPrimary(context),
      ),
      title: Text(title),
      trailing: trailing,
      onTap: () => onTap.call(),
    );
  }

  Widget _buildVersionBadge() {
    return Row(mainAxisSize: MainAxisSize.min, spacing: 2.w, children: [
      Text(
        "V1.1",
        style:
            TextStyle(fontSize: 14.sp, color: AppColors.textTertiary(context)),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            "New",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          )),
    ]);
  }
}
