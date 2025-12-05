import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/router/constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

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
            _buildUserProfile(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Divider(height: 1, color: AppColors.border(context)),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 10.h),
                children: [
                  _buildMenuItem(
                    iconName: 'join-us',
                    title: S.of(context).joinUs,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    iconName: 'secure-wallet',
                    title: S.of(context).welletSecurity,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    iconName: 'switch-language',
                    title: S.of(context).languages,
                    onTap: () => context.pushNamed(RouteNames.switchLanguage),
                  ),
                  _buildUpdateMenuItem(),
                  _buildMenuItem(
                    iconName: 'learn-aigun',
                    title: S.of(context).learnAIGun,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    iconName: 'log-out',
                    title: S.of(context).logOut,
                    onTap: () async {
                      if (context.mounted) {
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 60.w,
              height: 60.h,
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
              imageUrl:
                  "https://cdn.route.aigun.ai/fission/images/avatar/12.png",
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'trump@gmail.com',
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
                      'AiGun',
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
  }

  Widget _buildMenuItem({
    required String iconName,
    required String title,
    required VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
      leading: SvgPicture.asset(
        'assets/icons-settings/$iconName.svg',
        width: 30.w,
        height: 30.h,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textPrimary(context),
      ),
      title: Text(title),
      trailing: trailing,
      onTap: () => onTap?.call(),
    );
  }

  Widget _buildUpdateMenuItem() {
    return _buildMenuItem(
      iconName: 'update',
      title: S.of(context).update,
      onTap: null,
      trailing: _buildVersionBadge(),
    );
  }

  Widget _buildVersionBadge() {
    return Text(
      'V$_version',
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textTertiary(context),
        letterSpacing: 0.5,
      ),
    );
  }
}
