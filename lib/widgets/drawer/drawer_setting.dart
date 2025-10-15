import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/service_locator.dart';
import '../../features/update/domain/entities/update_info.dart';
import '../../features/update/presentation/cubit/update_cubit.dart';
import '../../features/update/presentation/update_sheet.dart';
import '../../utils/toast.dart';

class DrawerSetting extends StatefulWidget {
  const DrawerSetting({super.key});

  @override
  State<DrawerSetting> createState() => _DrawerSettingState();
}

class _DrawerSettingState extends State<DrawerSetting> {
  String _version = '';
  bool _isCheckingUpdate = false;
  bool _hasUpdate = false; // 是否有可用更新
  UpdateInfo? _updateInfo; // 更新信息
  bool _forceUpdate = false; // 是否强制更新
  String _statusMessage = ''; // 状态消息（无更新或错误时）

  @override
  void initState() {
    super.initState();
    _loadVersion();
    // 默认静默检查更新
    _checkForUpdate();
    _updateInfo;
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  Future<void> _checkForUpdate() async {
    if (_isCheckingUpdate) return;

    setState(() {
      _isCheckingUpdate = true;
      _statusMessage = '';
    });

    try {
      final updateCubit = getIt<UpdateCubit>();

      // 监听更新状态
      final subscription = updateCubit.stream.listen((state) {
        if (!mounted) return;

        state.whenOrNull(
          available: (info, force) {
            // 有可用更新，保存更新信息
            if (mounted) {
              setState(() {
                _hasUpdate = true;
                _updateInfo = info;
                _forceUpdate = force;
              });
            }
          },
          noUpdate: () {
            // 已是最新版本
            if (mounted) {
              setState(() {
                _hasUpdate = false;
                _updateInfo = null;
                _statusMessage = S.of(context).noNewVersion;
              });
            }
          },
          error: (message) {
            // 检查更新失败
            if (mounted) {
              setState(() {
                _hasUpdate = false;
                _updateInfo = null;
                _statusMessage = S.of(context).checkUpdateFail(message);
              });
            }
          },
        );
      });

      // 开始检查更新
      await updateCubit.checkForUpdate();

      // 等待一段时间后取消订阅
      Future.delayed(const Duration(seconds: 2), () {
        subscription.cancel();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingUpdate = false;
        });
      }
    }
  }

  void _onUpdateTap() {
    if (_hasUpdate && _updateInfo != null) {
      // 有更新，显示更新弹窗
      UpdateSheet.show(
        context,
        info: _updateInfo!,
        force: _forceUpdate,
      );
    } else if (_statusMessage.isNotEmpty) {
      // 无更新或出错，显示状态消息
      if (_statusMessage == S.of(context).noNewVersion) {
        ToastUtils.showSuccessToast(context, message: _statusMessage);
      } else {
        ToastUtils.showFailureToast(context, message: _statusMessage);
      }
    } else {
      // 还未检查完成，重新检查
      _checkForUpdate();
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
                      onTap: _onUpdateTap,
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
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
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
                  success: (user) => ClipOval(
                          child: CachedNetworkImage(
                        width: 60.w,
                        height: 60.h,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.w,
      children: [
        if (_isCheckingUpdate)
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: const CircularProgressIndicator(strokeWidth: 2),
          )
        else
          Text(
            'V$_version',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textTertiary(context),
              letterSpacing: 0.5,
            ),
          ),
        // 有更新时显示 New 标记
        if (_hasUpdate && !_isCheckingUpdate)
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
    );
  }
}
