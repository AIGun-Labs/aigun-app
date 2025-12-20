import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/router/routes/app_routes.dart';
import '../../../../core/service_locator.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/toast.dart';
import '../../../update/presentation/cubits/update_cubit.dart';

class SettingDrawer extends StatefulWidget {
  const SettingDrawer({super.key});

  @override
  State<SettingDrawer> createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
      });
    } catch (e) {
      setState(() {
        _version = 'Unknown';
      });
    }
  }

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
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Divider(height: 1, color: AppColors.border(context)),
            ),
            // 菜单项
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 10.h),
                children: [
                  _buildMenuItem(
                    assetName: Assets.iconsSettings.joinUs,
                    title: S.of(context).joinUs,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    assetName: Assets.iconsSettings.secureWallet,
                    title: S.of(context).welletSecurity,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    assetName: Assets.iconsSettings.switchLanguage,
                    title: S.of(context).languages,
                    onTap: () => const LocaleSettingRoute().push(context),
                  ),
                  _buildUpdateMenuItem(),
                  _buildMenuItem(
                    assetName: Assets.iconsSettings.learnAigun,
                    title: S.of(context).learnAIGun,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    assetName: Assets.iconsSettings.logOut,
                    title: S.of(context).logOut,
                    onTap: () async {
                      if (context.mounted) {
                        await BlocProvider.of<NewUserCubit>(context).logout();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          context.goNamed(RouteNames.intel);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Divider(height: 1, color: AppColors.border(context)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16.w,
                children: [
                  IconButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.surface(context),
                      ),
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
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.surface(context),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return BlocBuilder<NewUserCubit, NewUserState>(
      builder: (context, state) {
        if (state.authStatus != AuthStatus.authenticated) {
          return Container();
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  width: 60.w,
                  height: 60.w,
                  errorWidget: (context, url, error) => ColoredBox(
                    color: AppColors.tokenPlaceholderColor,
                    child: Center(
                      child: Text(
                        state.userInfo?.nickname.splitValueByCount() ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  imageUrl: ImageUtils.getAvatarUrl(state.userInfo?.avatar),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userInfo?.email ?? '',
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
                          height: 16.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          state.userInfo?.nickname ?? '',
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
    required String assetName,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
      leading: SvgPicture.asset(assetName, width: 30.w, height: 30.w),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textPrimary(context),
      ),
      title: Text(title),
      trailing: trailing,
      onTap: () => onTap.call(),
    );
  }

  Widget _buildUpdateMenuItem() {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (context, state) => _buildMenuItem(
        assetName: Assets.iconsSettings.update,
        title: S.of(context).update,
        onTap: () async {
          await getIt<UpdateCubit>().checkForUpdate();

          state.whenOrNull(
            noUpdate: () => ToastUtils.showSuccessToast(
              context,
              message: S.of(context).noNewVersion,
            ),
            downloading: (_) => ToastUtils.showSuccessToast(
              context,
              message: S.of(context).downloading,
            ),
          );
        },
        trailing: _buildVersionBadge(),
      ),
    );
  }

  Widget _buildVersionBadge() {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (context, state) => state.maybeWhen(
        iosUnavailable: () => Text(
          'V$_version',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textTertiary(context),
            letterSpacing: 0.5,
          ),
        ),
        checking: () => Text(
          S.of(context).checking,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textTertiary(context),
          ),
        ),
        noUpdate: () => Text(
          'V$_version',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textTertiary(context),
            letterSpacing: 0.5,
          ),
        ),
        downloading: (progress) => Text(
          '${S.of(context).downloading}${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textTertiary(context),
          ),
        ),
        orElse: () => Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.w,
          children: [
            Text(
              'V$_version',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textTertiary(context),
                letterSpacing: 0.5,
              ),
            ),
            // 有更新时显示 New 标记
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  height: 1.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
