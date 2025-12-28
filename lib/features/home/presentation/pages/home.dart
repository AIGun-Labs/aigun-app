import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../../core/services/gate_keeper_service.dart';
import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../l10n/l10n.dart';
// import '../../../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/toast.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../update/presentation/cubits/update_cubit.dart';
import '../../../update/presentation/utils/show_installer_dialog.dart';
import '../../../update/presentation/utils/show_update_sheet.dart';
import '../widgets/active_icon.dart';
import '../widgets/setting_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.navigationShell,
    required this.gatekeeper,
  });

  final StatefulNavigationShell navigationShell;
  final GateKeeperService gatekeeper;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  StreamSubscription<UpdateState>? _updateSubscription;

  bool? _lastLocked;
  Future<void> _checkForUpdate() async {
    final updateCubit = getIt<UpdateCubit>();

    await _updateSubscription?.cancel();
    _updateSubscription = updateCubit.stream.listen((state) {
      if (!mounted) return;

      state.whenOrNull(
        available: (info, force) {
          showUpdateSheet(context, info: info, force: force);
        },
        installNeedsPermission: (path) async {
          await showInstallerDialog(
            context,
            onSetting: () async {
              updateCubit.openInstallPermissionSettings();
            },
          );
        },
        error: (message) {
          ToastUtils.showFailureToast(context, message: message);
        },
      );
    });
    await updateCubit.checkForUpdate();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    widget.gatekeeper.isServiceLockedNotifier.addListener(
      _onServiceLockedChanged,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdate();
    });
  }

  void _onServiceLockedChanged() {
    if (!mounted) return;
    final isLocked = widget.gatekeeper.isServiceLockedNotifier.value;
    if (_lastLocked == isLocked) return;
    _lastLocked = isLocked;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!mounted) return;

    //   if (isLocked) {
    //     NetworkToastUtils.dismiss();
    //     if (!widget.gatekeeper.isDeviceOnline) {
    //       NetworkToastUtils.showNetworkFailed(
    //         context,
    //         S.of(context).networkIsNotConnected,
    //       );
    //     } else if (!widget.gatekeeper.isBackendHealthy) {
    //       NetworkToastUtils.showNetworkFailed(
    //         context,
    //         S.of(context).servicesAreNotHealthy,
    //       );
    //     }
    //   } else {
    //     NetworkToastUtils.dismiss();
    //   }
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateSubscription?.cancel();
    widget.gatekeeper.isServiceLockedNotifier.removeListener(
      _onServiceLockedChanged,
    );

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getIt<UpdateCubit>().resumeInstallFromSettings();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectCubit, CollectState>(
      listenWhen: (previous, current) =>
          current.actionStatus == CollectActionStatus.added ||
          current.actionStatus == CollectActionStatus.removed ||
          current.actionStatus == CollectActionStatus.error,
      listener: (BuildContext context, CollectState state) {
        if (state.actionStatus == CollectActionStatus.added) {
          ToastUtils.showCenterToast(context, S.of(context).trackSuccess);
          BlocProvider.of<SoundEffectCubit>(context).playGunLoad();
        }

        if (state.actionStatus == CollectActionStatus.removed) {
          ToastUtils.showCenterToast(context, S.of(context).cancelTracking);
        }

        if (state.actionStatus == CollectActionStatus.error) {
          ToastUtils.showCenterToast(context, state.errorMessage ?? '');
        }
        BlocProvider.of<CollectCubit>(context).clearActionStatus();
      },
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: const SettingDrawer(),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.borderSecondary(context), //
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
        body: SafeArea(child: widget.navigationShell),
      ),
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

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

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
    BuildContext context,
  ) {
    final labels = [
      S.of(context).intel,
      S.of(context).trending,
      S.of(context).trade,
      S.of(context).bonus,
      S.of(context).wallet,
    ];

    final items = List<BottomNavigationBarItem>.generate(_iconPaths.length, (
      index,
    ) {
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
          isSelected: widget.navigationShell.currentIndex == index,
        ),
        label: labels[index],
      );
    });

    return items;
  }
}
