import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/wallet/widgets/search_bar.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_actions.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/service_locator.dart';
import '../../features/update/presentation/cubit/update_cubit.dart';
import '../../features/update/presentation/cubit/update_state.dart';
import '../../utils/logger.dart';
import '../../utils/sheet/sheet.dart';
import 'dart:async';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, this.openDrawer});
  final VoidCallback? openDrawer;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  StreamSubscription<UpdateState>? _updateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdate();
    });
  }

  @override
  void dispose() {
    _updateSubscription?.cancel();
    super.dispose();
  }

  /// 检查更新
  void _checkForUpdate() async {
    try {
      Logger.info('开始检查更新...');
      final updateCubit = getIt<UpdateCubit>();

      // 取消之前的订阅
      await _updateSubscription?.cancel();

      // 监听更新状态
      _updateSubscription = updateCubit.stream.listen((state) {
        Logger.info('更新状态: ${state.toString()}');
        if (!mounted) return;

        state.maybeWhen(
          available: (info, force) {
            Logger.info('发现新版本: ${info.latest}, 强制更新: $force');
            // 有可用更新，弹出更新弹窗
            ShowSheet.upgrade(
              context,
              info: info,
              force: force,
            );
          },
          noUpdate: () {
            Logger.info('已是最新版本');
          },
          error: (message) {
            Logger.error('检查更新失败: $message');
          },
          orElse: () {},
        );
      });

      // 开始检查更新
      Logger.info('调用 checkForUpdate...');
      await updateCubit.checkForUpdate();
    } catch (e, stackTrace) {
      Logger.error('检查更新异常: $e');
      Logger.error('堆栈跟踪: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.h),
          child: WalletSearchBar(openDrawer: () => widget.openDrawer?.call()),
        ),
        backgroundColor: AppColors.background(context),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          // 处理未登录的情况
          if (state.status.maybeWhen(
            success: (user) => false,
            orElse: () => true,
          )) {
            return Center(
                child: PrimaryButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onPressed: () {
                      context.push(Routes.login);
                      context.read<UserCubit>().logout();
                    },
                    label: Text(S.of(context).common_login,
                        style: const TextStyle(color: Colors.white))));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const WalletUserProfile(),
                const WalletActions(),
                Divider(
                  color: AppColors.border(context),
                ),
                SizedBox(height: 10.h),
                const WalletList(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
