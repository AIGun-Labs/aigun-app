import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/network/network_cubit.dart';
import 'package:flutter_aigun/cubits/network/network_state.dart';
import 'package:flutter_aigun/features/home/presentation/widgets/setting_drawer.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../utils/logger.dart';
import '../../../update/presentation/cubit/update_cubit.dart';
import '../../../update/presentation/cubit/update_state.dart';
import '../../../update/presentation/utils/show_installer_dialog.dart';
import '../../../update/presentation/utils/show_update_sheet.dart';
import '../widgets/active_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ToastController? _networkToastController;

  final List<String> _iconPaths = [
    'assets/tabbar/intel.svg',
    'assets/tabbar/trending.svg',
    'assets/tabbar/trade.svg',
    'assets/tabbar/invite.svg',
    'assets/tabbar/wallet.svg',
  ];

  final List<String> _selectedIconPaths = [
    'assets/tabbar/intel-active.json',
    'assets/tabbar/trending-active.json',
    'assets/tabbar/trade-active.json',
    'assets/tabbar/invite-active.json',
    'assets/tabbar/wallet-active.json',
  ];

  StreamSubscription<UpdateState>? _updateSubscription;

  @override
  void initState() {
    super.initState();
    // 添加生命周期监听
    WidgetsBinding.instance.addObserver(this);
    // 延迟执行更新检查，等待首页加载完成
    Logger.info('initState');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // // 如果路由有 extra，则更新选中的索引
      // if (GoRouterState.of(context).extra is int) {
      //   _updateSelectedIndex(GoRouterState.of(context).extra as int);
      // }
      //版本检查
      _checkForUpdate();
    });
  }

  @override
  void dispose() {
    // 移除生命周期监听
    WidgetsBinding.instance.removeObserver(this);
    _updateSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 当应用从后台返回前台时
    if (state == AppLifecycleState.resumed) {
      Logger.info('app resumed, checking if need to resume install');
      // 检查是否需要恢复安装流程
      getIt<UpdateCubit>().resumeInstallFromSettings();
    }
  }

  @override
  void didChangeDependencies() {
    // 如果路由有 extra，则更新选中的索引
    super.didChangeDependencies();
  }

  /// 检查更新
  Future<void> _checkForUpdate() async {
    Logger.info('checkForUpdate');
    final updateCubit = getIt<UpdateCubit>();

    await _updateSubscription?.cancel();

    // 监听更新状态
    _updateSubscription = updateCubit.stream.listen((state) {
      if (!mounted) return;

      state.whenOrNull(
        available: (info, force) {
          // 有可用更新，弹出更新弹窗
          showUpdateSheet(
            context,
            info: info,
            force: force,
          );
        },
        downloaded: (info, path) => updateCubit.checkCanInstall(path: path),
        installNeedsPermission: (path) async {
          await showInstallerDialog(context, onSetting: () async {
            // 跳转设置页面
            updateCubit.openInstallPermissionSettings();
          });
        },
        installing: (path) => updateCubit.install(path: path),
      );
    });

    // 开始检查更新
    await updateCubit.checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: const SettingDrawer(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.borderSecondary(context), // 使用应用主题的边框颜色
                width: 1.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: widget.navigationShell.currentIndex,
            onTap: (index) => _onTabTapped(context, index),
            items: _buildBottomNavigationBarItems(context),
          ),
        ),
        body: BlocListener<NetworkCubit, NetworkState>(
          listener: (context, state) {
            // if (!kDebugMode) {
            //   if (state is NetworkFailure) {
            //     _networkToastController = NetworkToastUtils.showNetworkFailed(
            //       context,
            //       'Network disconnected, please check your network settings',
            //     );
            //   } else if (state is NetworkSuccess) {
            //     _networkToastController?.dismiss();
            //   }
            // }
          },
          child: widget.navigationShell,
        ));
  }

  void _onTabTapped(BuildContext context, int index) {
    // 使用 goBranch 可以保持每个分支的导航状态
    final userCubit = getIt<UserCubit>();
    if (!userCubit.state.isLoggedIn && index != 0) {
      context.pushNamed(RouteNames.login);
      return;
    }
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context) {
    final labels = [
      S.of(context).intel,
      S.of(context).trending,
      S.of(context).trade,
      S.of(context).bonus,
      S.of(context).wallet,
    ];

    final items = List<BottomNavigationBarItem>.generate(
      _iconPaths.length,
      (index) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _iconPaths[index],
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary(context),
              BlendMode.srcATop,
            ),
          ),
          activeIcon: TabActiveIcon(
              path: _selectedIconPaths[index],
              isSelected: widget.navigationShell.currentIndex == index),
          label: labels[index],
        );
      },
    );

    return items;
  }
}
