import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/invite/invite.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trending/trending.dart';
import 'package:flutter_aigun/screens/wallet/wallet.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/keep_alive_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  TabbarScreenState createState() => TabbarScreenState();
}

class TabbarScreenState extends State<TabbarScreen> {
  int _selectedIndex = 0;
  bool _isFirstLoad = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      S.of(context).intel,
      S.of(context).trending,
      S.of(context).trade,
      S.of(context).invite,
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
            // colorFilter: ColorFilter.mode(
            //   color!,
            //   BlendMode.srcATop,
            // ),
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary(context),
              BlendMode.srcATop,
            ),
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

  // @override
  // Widget build(BuildContext context) {
  //
  // return Scaffold(
  //     key: scaffoldKey,
  //     bottomNavigationBar: Container(
  //       decoration: BoxDecoration(
  //         border: Border(
  //           top: BorderSide(
  //             color: AppColors.borderSecondary(context), // 使用应用主题的边框颜色
  //             width: 1.0,
  //           ),
  //         ),
  //       ),
  //       child: BottomNavigationBar(
  //         items: _buildBottomNavigationBarItems(context),
  //         currentIndex: _selectedIndex,
  //         onTap: _updateSelectedIndex,
  //       ),
  //     ),
  //     body: IndexedStack(
  //       index: _selectedIndex,
  //       children: _pages,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: AppColors.borderSecondary(context), width: 1.0))),
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            label: "Intel",
            icon: TabItem(
                svgPath: "assets/tabbar/intel.svg",
                lottiePath: "assets/lottie/cap.lottie",
                unselectedColor: AppColors.textPrimary(context),
                isSelected: true),
          ),
          BottomNavigationBarItem(
            label: "Trending",
            icon: TabItem(
                svgPath: "assets/tabbar/trending.svg",
                lottiePath: "assets/lottie/cap.lottie",
                unselectedColor: AppColors.textPrimary(context),
                isSelected: false),
          ),
        ]),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.svgPath,
      required this.lottiePath,
      required this.unselectedColor,
      required this.isSelected});
  final String svgPath;
  final String lottiePath;
  final Color unselectedColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(microseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
      child: isSelected
          ? TabActiveIcon(path: lottiePath)
          : SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcATop),
            ),
    );
  }
}

class TabActiveIcon extends StatelessWidget {
  const TabActiveIcon({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset(path, frameBuilder: (context, dotlottie) {
      if (dotlottie != null) {
        return Lottie.memory(dotlottie.animations.values.single,
            width: 24, height: 24);
      }
      return const SizedBox.shrink();
    });
  }
}
