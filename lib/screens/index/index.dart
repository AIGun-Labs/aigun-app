import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trending/trending.dart';
import 'package:flutter_aigun/screens/wallet/wallet.dart';
import 'package:flutter_aigun/widgets/keep_alive_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  IndexScreenState createState() => IndexScreenState();
}

class IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = NavIndex.intel;
  bool _isFirstLoad = true;

  // 使用 IndexedStack 来保持页面状态
  final List<Widget> _pages = const <Widget>[
    KeepAlivePage(child: IntelScreen()),
    // KeepAlivePage(child: MarketScreen()),
    KeepAlivePage(child: TrendingScreen()),
    KeepAlivePage(child: TradeScreen()),
    // KeepAlivePage(child: NotificationScreen()),
    KeepAlivePage(child: WalletScreen()),
  ];

  // final List<String> _iconPaths = [
  //   'assets/nav/intel-1.svg',
  //   'assets/nav/trend-1.svg',
  //   'assets/nav/trade-1.svg',
  //   'assets/nav/noti-1.svg',
  //   'assets/nav/wallet-1.svg',
  // ];

  // final List<String> _selectedIconPaths = [
  //   'assets/nav/intel-2.svg',
  //   'assets/nav/trend-2.svg',
  //   'assets/nav/trade-2.svg',
  //   'assets/nav/noti-2.svg',
  //   'assets/nav/wallet-2.svg',
  // ];

  final List<String> _iconPaths = [
    'assets/tabbar/intel.svg',
    'assets/tabbar/trending.svg',
    'assets/tabbar/trade.svg',
    'assets/tabbar/wallet.svg',
  ];

  final List<String> _selectedIconPaths = [
    'assets/tabbar/intel-active.svg',
    'assets/tabbar/trending-active.svg',
    'assets/tabbar/trade-active.svg',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 替代直接的 Widget
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavigationBarItems(context),
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
        ),
        onTap: _updateSelectedIndex,
        // selectedItemColor: const Color(0xFF5EF7FF),
        unselectedItemColor: const Color(0xFF5EF7FF), // 未选中时的颜色
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context) {
    final labels = [
      S.of(context).intel_intelligence,
      S.of(context).intel_trending,
      S.of(context).intel_trade,
      // S.of(context).intel_notification,
      S.of(context).wallet_wallet,
    ];

    final items = List<BottomNavigationBarItem>.generate(
      _iconPaths.length,
      (index) => BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _selectedIndex == index
              ? _selectedIconPaths[index]
              : _iconPaths[index],
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            _selectedIndex == index
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF5EF7FF),
            BlendMode.srcIn,
          ),
        ),
        label: labels[index],
        // 通过selectedLabelStyle/unselectedLabelStyle控制文字颜色
      ),
    );

    return items;
  }
}
