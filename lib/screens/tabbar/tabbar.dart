import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/invite/invite.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trade_back/trade_back.dart';
import 'package:flutter_aigun/screens/trending/trending.dart';
import 'package:flutter_aigun/screens/wallet/wallet.dart';
import 'package:flutter_aigun/widgets/keep_alive_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  TabbarScreenState createState() => TabbarScreenState();
}

class TabbarScreenState extends State<TabbarScreen> {
  int _selectedIndex = 0;
  bool _isFirstLoad = true;

  // 使用 IndexedStack 来保持页面状态
  final List<Widget> _pages = const <Widget>[
    KeepAlivePage(child: IntelScreen()),
    KeepAlivePage(child: TrendingScreen()),
    KeepAlivePage(child: TradeScreen()),
    KeepAlivePage(child: InviteScreen()),
    KeepAlivePage(child: WalletScreen()),
  ];

  final List<String> _iconPaths = [
    'assets/tabbar/intel.svg',
    'assets/tabbar/trending.svg',
    'assets/tabbar/trade.svg',
    'assets/tabbar/invite.svg',
    'assets/tabbar/wallet.svg',
  ];

  final List<String> _selectedIconPaths = [
    'assets/tabbar/intel-active.svg',
    'assets/tabbar/trending-acitve.svg',
    'assets/tabbar/trade-active.svg',
    'assets/tabbar/invite-active.svg',
    'assets/tabbar/wallet-active.svg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 如果路由有 extra，则更新选中的索引
    super.didChangeDependencies();
    if (_isFirstLoad) {
      if (GoRouterState.of(context).extra is int) {
        _updateSelectedIndex(GoRouterState.of(context).extra as int);
      }
      _isFirstLoad = false;
    }
  }

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context) {
    final labels = [
      S.of(context).intel_intelligence,
      S.of(context).intel_trending,
      S.of(context).intel_trade,
      S.of(context).intel_invite,
      S.of(context).wallet_wallet,
    ];

    final items = List<BottomNavigationBarItem>.generate(
      _iconPaths.length,
      (index) {
        ThemeData themeData = Theme.of(context);

        final isSelected = _selectedIndex == index;

        // final color = isSelected
        //     ? themeData.bottomNavigationBarTheme.selectedItemColor
        //     : themeData.bottomNavigationBarTheme.unselectedItemColor;
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _iconPaths[index],
            width: 24,
            height: 24,
            // colorFilter: ColorFilter.mode(
            //   color!,
            //   BlendMode.srcATop,
            // ),
          ),
          activeIcon: SvgPicture.asset(
            _selectedIconPaths[index],
            width: 24,
            height: 24,
          ),
          label: labels[index],
        );
      },
    );

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavigationBarItems(context),
        currentIndex: _selectedIndex,
        onTap: _updateSelectedIndex,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
