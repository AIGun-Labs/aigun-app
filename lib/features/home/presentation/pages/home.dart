import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/gatekeeper/gate_keeper_service.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/toast.dart';
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

  bool? _lastLocked;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    widget.gatekeeper.isServiceLockedNotifier.addListener(
      _onServiceLockedChanged,
    );
  }

  void _onServiceLockedChanged() {
    if (!mounted) return;
    final isLocked = widget.gatekeeper.isServiceLockedNotifier.value;

    if (_lastLocked == isLocked) return;
    _lastLocked = isLocked;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (isLocked) {
        NetworkToastUtils.dismiss();
        if (!widget.gatekeeper.isDeviceOnline) {
          NetworkToastUtils.showNetworkFailed(
            context,
            S.of(context).networkIsNotConnected,
          );
        } else if (!widget.gatekeeper.isBackendHealthy) {
          NetworkToastUtils.showNetworkFailed(
            context,
            S.of(context).servicesAreNotHealthy,
          );
        }
      } else {
        NetworkToastUtils.dismiss();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.gatekeeper.isServiceLockedNotifier.removeListener(
      _onServiceLockedChanged,
    );

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const SettingDrawer(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.borderSecondary(context),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (index) => null,
          items: _buildBottomNavigationBarItems(context),
        ),
      ),
      body: widget.navigationShell,
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
